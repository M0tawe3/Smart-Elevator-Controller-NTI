#define F_CPU 8000000UL

#include <string.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "GPIO_interface.h"
#include "I2C_interface.h"
#include "SPI_interface.h"
#include "INTERRUPT_interface.h"
#include "HAL/LCD/lcd.h"
#include "HAL/HC595/HC595.h"
#include "HAL/HC165/HC165.h"
#include "HAL/Hoist/Hoist.h"
#include "HAL/Door/Door.h"
#include "HAL/Load/Load.h"
#include "HAL/Position/position.h"
#include "HAL/Buzzer/Buzzer.h"
#include "APP/CarFSM/CarFSM.h"
#include "APP/DoorFSM/DoorFSM.h"
#include "APP/Consol/consol.h"
#include "APP/Fault_log/fault_log.h"
#include "APP/Motion/Motion.h"
#include "APP/Safety/Safety.h"

static char g_lcdFrame[LCD_CHARS];

static void System_Init(void)
{
    /* Timer tick for the 10 ms scheduler. */
    TIMER0_Init();

    /* Shared bus interfaces for the elevator hardware. */
    SPI_InitMaster(SPI_PRESC_16);
    I2C_InitMaster(100000UL);

    /* Global interrupt support for UART / EXTI. */
    INTERRUPT_EnableGlobal();

    /* Peripheral initialization. */
    LCD_Init();
    HST_Init();
    DRV_Init();
    BUZ_Init();
    FL_Init();
    CONS_Init();
    CarFSM_Init();
    DoorFSM_Init();

    /* Ensure the floor display starts in a safe, neutral state. */
    SEG_Show(0U, DIR_NONE);
}

static void Car_UpdateFromSensors(CarData_t *car)
{
    if (car == NULL)
    {
        return;
    }

    car->positionCm = POS_cm();
    car->loadKg = LOAD_ReadKg();
    car->currentFloor = POS_nearestFloor(car->positionCm);
    car->doorPct = 0U;
    car->doorState = DoorFSM_GetState();
    car->state = CarFSM_GetState();
    car->dir = (uint8)DIR_NONE;

    if (car->state == CS_ESTOP || car->state == CS_FAULT)
    {
        car->activeFault = FLT_NONE;
    }

    /* Pull in debounced button events for the controller layer. */
    (void)BTN_Scan();
}

int main(void)
{
    CarData_t car;
    uint16 tickCounter = 0U;
    uint8 faultBlink = 0U;

    memset(&car, 0, sizeof(car));
    System_Init();

    while (1)
    {
        if (systemTicks10ms == 1U)
        {
            systemTicks10ms = 0U;
            tickCounter++;

            /* Refresh the local car snapshot every 10 ms. */
            Car_UpdateFromSensors(&car);

            /* Run safety checks and motion updates on the active car model. */
            SAF_Evaluate(&car);
            MOT_Step(&car);

            if ((tickCounter % 25U) == 0U)
            {
                /* 250 ms service display refresh. */
                faultBlink = (faultBlink == 0U) ? 1U : 0U;
                SEG_Show(car.currentFloor, (Dir_t)car.dir);
                LCD_UpdateFrame(g_lcdFrame,
                                car.currentFloor,
                                (Dir_t)car.dir,
                                car.positionCm,
                                car.loadKg,
                                car.activeFault,
                                (DoorState_t)car.doorState,
                                faultBlink);
            }

            if ((tickCounter % 200U) == 0U)
            {
                /* 2 s telemetry burst for the console. */
                CONS_SendTelemetry();
            }

            CONS_Task();
        }
    }

    return 0;
}