#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "I2C_interface.h"
#include "HAL/LCD/lcd.h"
#include "HAL/Buzzer/Buzzer.h"
#include "HAL/Hoist/Hoist.h"
#include "HAL/Load/Load.h"
#include "HAL/Position/position.h"
#include "APP/Consol/consol.h"
#include "APP/DoorFSM/DoorFSM.h"
#include "APP/Fault_log/fault_log.h"
#include "APP/Motion/Motion.h"
#include "APP/Safety/Safety.h"
#include "APP/dispatch/dispatch.h"

static uint8 hasCalls(const Calls_t *calls)
{
    return (uint8)((calls->carCall | calls->hallUp | calls->hallDown) != 0U);
}

static uint8 callAtFloor(const Calls_t *calls, uint8 floor)
{
    return (uint8)(((calls->carCall | calls->hallUp | calls->hallDown) & (1U << floor)) != 0U);
}

static uint8 findTargetFloor(const Calls_t *calls, uint8 currentFloor, Dir_t direction)
{
    if (direction == DIR_UP) {
        for (uint8 floor = (uint8)(currentFloor + 1U); floor < FLOOR_COUNT; floor++) {
            if (callAtFloor(calls, floor)) {
                return floor;
            }
        }
    } else if (direction == DIR_DOWN) {
        for (sint8 floor = (sint8)currentFloor - 1; floor >= 0; floor--) {
            if (callAtFloor(calls, (uint8)floor)) {
                return (uint8)floor;
            }
        }
    }

    for (uint8 floor = 0U; floor < FLOOR_COUNT; floor++) {
        if (callAtFloor(calls, floor)) {
            return floor;
        }
    }

    return FLOOR_COUNT;
}

int main(void)
{
    char frame[LCD_CHARS];
    CarData_t car = {0};
    Calls_t *calls;
    uint8 targetFloor = FLOOR_COUNT;
    uint8 dwellTicks = 0U;
    uint8 lastFault = FLT_NONE;

    TIMER0_Init();
    I2C_InitMaster(100000UL);
    LCD_Init();
    DoorFSM_Init();
    HST_Init();
    LOAD_Init();
    BUZ_Init();
    CONS_Init();
    FL_Init();

    car.state = CS_IDLE;
    car.doorState = DOOR_STATE_CLOSED;

    while (1) {
        CONS_Task();
        calls = CONS_GetCalls();

        car.positionCm = POS_cm();
        car.currentFloor = POS_nearestFloor(car.positionCm);
        car.loadKg = LOAD_ReadKg();
        car.overload = LOAD_IsOverloaded();
        if (LOAD_IsReadValid() == 0U) {
            car.loadKg = LOAD_LIMIT_KG;
        }
        car.doorState = DoorFSM_GetState();
        car.doorPct = (car.doorState == DOOR_STATE_CLOSED) ? 0U : 100U;

        SAF_Evaluate(&car);
        if (SAF_Active(&car)) {
            MOT_Stop();
            HST_EmergencyStop();
            if (car.activeFault != lastFault) {
                FL_AddFault(car.activeFault);
                lastFault = car.activeFault;
            }
        } else if (MOT_IsActive()) {
            if (MOT_AtTarget(car.positionCm)) {
                MOT_Stop();
                DSP_ClearFloor(calls, targetFloor);
                DoorFSM_Open();
                car.state = CS_DOOR_OPEN;
                dwellTicks = 0U;
            } else {
                MOT_Step(&car);
            }
        } else if (car.doorState == DOOR_STATE_OPEN) {
            if (++dwellTicks >= 20U) {
                DoorFSM_Close();
            }
        } else if (car.doorState == DOOR_STATE_OPENING || car.doorState == DOOR_STATE_CLOSING) {
            DoorFSM_Update(car.obstruction);
        } else if (hasCalls(calls)) {
            if (callAtFloor(calls, car.currentFloor)) {
                DSP_ClearFloor(calls, car.currentFloor);
                DoorFSM_Open();
                car.state = CS_DOOR_OPEN;
            } else {
                car.dir = (uint8)DSP_NextDirection(calls, car.currentFloor, (Dir_t)car.dir);
                targetFloor = findTargetFloor(calls, car.currentFloor, (Dir_t)car.dir);
                if (targetFloor < FLOOR_COUNT) {
                    car.state = CS_STARTING;
                    MOT_GoTo(targetFloor, car.positionCm);
                }
            }
        }

        car.doorState = DoorFSM_GetState();
        LCD_UpdateFrame(frame, car.currentFloor, (Dir_t)car.dir, car.positionCm,
                        car.loadKg, (Fault_t)car.activeFault, car.doorState,
                        car.state, (uint8)(lastFault != FLT_NONE));
        LCD_RefreshPartial(frame);
        TIMER0_DelayMS(50U);
    }
}