#define F_CPU 8000000UL

#include <string.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "ADC_interface.h"
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
#include "APP/dispatch/dispatch.h"

static char g_lcdFrame[LCD_CHARS];
static volatile uint8 g_emergencyStopTrip = 0U;

static void EmergencyStopCallback(void)
{
    g_emergencyStopTrip = 1U;
    HST_EmergencyStop();
}

static void System_Init(void)
{
    /* Timer tick for the 10 ms scheduler. */
    TIMER0_Init();
    INTERRUPT_EnableGlobal();


    /* Shared bus interfaces for the elevator hardware. */
    SPI_InitMaster(SPI_PRESC_16);
    I2C_InitMaster(100000UL);
    TIMER0_DelayMS(10U);

    GPIO_SetPinDirection(GPIO_PORTC, GPIO_PIN2, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTC, GPIO_PIN3, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTC, GPIO_PIN4, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTC, GPIO_PIN5, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTC, GPIO_PIN7, GPIO_OUTPUT);
    GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN2, GPIO_HIGH);
    GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN3, GPIO_LOW);

    ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);

    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN2, GPIO_INPUT_PULLUP);
    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN3, GPIO_INPUT_PULLUP);
    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN6, GPIO_INPUT_PULLUP);
    EXTI_SetSense(EXTI_INT0, EXTI_RISING_EDGE);
    EXTI_SetCallback(EXTI_INT0, EmergencyStopCallback);
    EXTI_Enable(EXTI_INT0);

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
    uint16 currentAdc;
    uint16 doorAdc;

    if (car == NULL)
    {
        return;
    }

    car->positionCm = POS_cm();
    car->loadKg = LOAD_ReadKg();
    if (ADC_ReadChannel(ADC_CHANNEL_2, &currentAdc) == E_OK)
    {
        /* SimulIDE current potentiometer represents 0..20 A. */
        car->currentmA = (uint16)(((uint32)currentAdc * 20000UL) / 1023UL);
    }
    else
    {
        car->currentmA = 0U;
    }
    car->currentFloor = POS_nearestFloor(car->positionCm);
    if (ADC_ReadChannel(ADC_CHANNEL_3, &doorAdc) == E_OK)
    {
        car->doorPct = (uint8)(((uint32)doorAdc * 100UL) / 1023UL);
    }
    else
    {
        car->doorPct = 0U;
    }
    car->doorState = DoorFSM_GetState();
    car->state = CarFSM_GetState();
    car->dir = (uint8)DIR_NONE;

}

static void UpdateCallBitmapFromHardware(CarData_t *car)
{
    uint16 buttonState;
    uint8 emergencyStopPin;
    uint8 fireServicePin;

    if (car == NULL)
    {
        return;
    }

    buttonState = BTN_Scan();
    car->independent = ((buttonState & (uint16)(1U << 7U)) != 0U) ? 1U : 0U;

    (void)GPIO_GetPinValue(GPIO_PORTD, GPIO_PIN2, &emergencyStopPin);
    (void)GPIO_GetPinValue(GPIO_PORTD, GPIO_PIN6, &fireServicePin);
    car->fireService = (fireServicePin == GPIO_LOW) ? 1U : 0U;
    /* The emergency contact is normally closed: HIGH means it has opened. */
    if (emergencyStopPin == GPIO_HIGH)
    {
        g_emergencyStopTrip = 1U;
        HST_EmergencyStop();
    }
    else
    {
        /* Releasing the physical stop makes the controller ready again. */
        g_emergencyStopTrip = 0U;
    }

    for (uint8 btn = 0U; btn < 16U; btn++)
    {
        if (BTN_Pressed(btn) == 0U)
        {
            continue;
        }

        switch (btn)
        {
            case 0U:
            case 1U:
            case 2U:
            case 3U:
                (void)DSP_AddCall(&car->calls, btn, CALL_CAR);
                break;

            case 4U:
                DoorFSM_Open();
                break;

            case 5U:
                DoorFSM_Close();
                break;

            case 6U:
                car->estop = 1U;
                car->activeFault = FLT_ESTOP;
                HST_EmergencyStop();
                DRV_Stop();
                break;

            case 7U:
                /* The switch level is applied above from buttonState. */
                car->independent = 1U;
                break;

            case 8U:
                (void)DSP_AddCall(&car->calls, 0U, CALL_HALL_UP);
                break;

            case 9U:
                (void)DSP_AddCall(&car->calls, 1U, CALL_HALL_UP);
                break;

            case 10U:
                (void)DSP_AddCall(&car->calls, 1U, CALL_HALL_DOWN);
                break;

            case 11U:
                (void)DSP_AddCall(&car->calls, 2U, CALL_HALL_UP);
                break;

            case 12U:
                (void)DSP_AddCall(&car->calls, 2U, CALL_HALL_DOWN);
                break;

            case 13U:
                (void)DSP_AddCall(&car->calls, 3U, CALL_HALL_DOWN);
                break;

            default:
                break;
        }
    }

    if (g_emergencyStopTrip != 0U)
    {
        car->estop = 1U;
        car->activeFault = FLT_ESTOP;
    }
    else
    {
        car->estop = 0U;
        if (car->activeFault == FLT_ESTOP)
        {
            car->activeFault = FLT_NONE;
        }
    }
}

static uint8 FindTargetFloor(const Calls_t *calls,
                             uint8 currentFloor,
                             Dir_t direction)
{
    uint8 floor;

    if (direction == DIR_UP)
    {
        for (floor = (uint8)(currentFloor + 1U);
             floor < FLOOR_COUNT;
             floor++)
        {
            if (DSP_ShouldStop(calls, floor, DIR_UP) == E_OK)
            {
                return floor;
            }
        }
    }
    else if (direction == DIR_DOWN)
    {
        floor = currentFloor;
        while (floor > 0U)
        {
            floor--;
            if (DSP_ShouldStop(calls, floor, DIR_DOWN) == E_OK)
            {
                return floor;
            }
        }
    }

    return currentFloor;
}

int main(void)
{
    CarData_t car;
    uint16 tickCounter = 0U;
    uint8 faultBlink = 0U;
    uint8 previousLevelled = 0U;
    uint8 fireRecallStarted = 0U;
    uint8 chimeTicks = 0U;
    Dir_t currentDir = DIR_NONE;

    memset(&car, 0, sizeof(car));
    System_Init();

    while (1)
    {
        if (systemTicks10ms == 1U)
        {
            systemTicks10ms = 0U;
            tickCounter++;

            Car_UpdateFromSensors(&car);
            UpdateCallBitmapFromHardware(&car);
            {
                uint8 obstructionPin;

                (void)GPIO_GetPinValue(GPIO_PORTD,
                                       GPIO_PIN3,
                                       &obstructionPin);
                DoorFSM_UpdatePosition(obstructionPin == GPIO_LOW ? 1U : 0U,
                                       car.doorPct);
                car.doorState = DoorFSM_GetState();
                if (car.doorState == DOOR_STATE_CLOSED)
                {
                    DRV_Stop();
                }
            }

            if (car.fireService != 0U)
            {
                /* Fire service has priority over every queued call. */
                car.calls.carCall = 0U;
                car.calls.hallUp = 0U;
                car.calls.hallDown = 0U;
                if (car.currentFloor != 0U &&
                    car.doorState == DOOR_STATE_CLOSED &&
                    car.estop == 0U)
                {
                    currentDir = DIR_DOWN;
                    if (fireRecallStarted == 0U)
                    {
                        car.targetFloor = 0U;
                        car.levelled = 0U;
                        (void)MOT_GoTo(0U, car.positionCm);
                        fireRecallStarted = 1U;
                    }
                }
                else
                {
                    MOT_Stop();
                    car.dir = (uint8)DIR_NONE;
                    currentDir = DIR_NONE;
                    if (car.currentFloor == 0U && car.estop == 0U &&
                        car.doorState == DOOR_STATE_CLOSED)
                    {
                        DoorFSM_Open();
                    }
                }
            }
            else if (car.estop != 0U || car.doorState != DOOR_STATE_CLOSED)
            {
                fireRecallStarted = 0U;
                currentDir = DIR_NONE;
                car.dir = (uint8)DIR_NONE;
                MOT_Stop();
            }
            else
            {
                fireRecallStarted = 0U;
                if (DSP_ShouldStop(&car.calls,
                                   car.currentFloor,
                                   currentDir) == E_OK)
                {
                    (void)DSP_ClearFloor(&car.calls, car.currentFloor);
                    MOT_Stop();
                    currentDir = DIR_NONE;
                    car.targetFloor = car.currentFloor;
                }

                currentDir = DSP_NextDirection(&car.calls,
                                               car.currentFloor,
                                               currentDir);

                if (currentDir != DIR_NONE)
                {
                    uint8 targetFloor = FindTargetFloor(&car.calls,
                                                        car.currentFloor,
                                                        currentDir);

                    if (targetFloor != car.currentFloor)
                    {
                        if (targetFloor != car.targetFloor ||
                            car.levelled != 0U)
                        {
                            car.targetFloor = targetFloor;
                            car.levelled = 0U;
                            (void)MOT_GoTo(targetFloor, car.positionCm);
                        }
                    }
                }
                else
                {
                    car.dir = (uint8)DIR_NONE;
                    MOT_Stop();
                }

                car.dir = (uint8)currentDir;
            }
            SAF_Evaluate(&car);
            MOT_Step(&car);

            if (car.estop != 0U || car.fireService != 0U ||
                car.activeFault != FLT_NONE)
            {
                chimeTicks = 0U;
                BUZ_Alarm();
            }
            else if (car.levelled != 0U && previousLevelled == 0U)
            {
                BUZ_Chime();
                chimeTicks = 10U;
            }
            else if (chimeTicks != 0U)
            {
                chimeTicks--;
                if (chimeTicks == 0U)
                {
                    BUZ_Stop();
                }
            }
            else
            {
                BUZ_Stop();
            }

            previousLevelled = car.levelled;

            if ((tickCounter % 25U) == 0U)
            {
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
                CONS_SendTelemetry();
            }

            CONS_Task();
        }
    }

    return 0;
}