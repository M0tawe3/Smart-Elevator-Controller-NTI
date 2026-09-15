#include <stdint.h>
#include "Hoist.h"

typedef enum {
    CS_INIT = 0,
    CS_HOMING,
    CS_IDLE,
    CS_DOOR_OPENING,
    CS_DOOR_OPEN,
    CS_DOOR_CLOSING,
    CS_STARTING,
    CS_MOVING,
    CS_SLOWING,
    CS_LEVELLING,
    CS_ARRIVED,
    CS_OVERLOAD,
    CS_FIRE_RECALL,
    CS_FIRE_HOLD,
    CS_FAULT,
    CS_ESTOP
} CarState_t;

typedef enum {
    FLT_NONE = 0,
    FLT_ESTOP,
    FLT_OVERTRAVEL,
    FLT_TRAVEL_TIMEOUT,
    FLT_DOOR_TIMEOUT,
    FLT_OVERCURRENT,
    FLT_POSITION_SENSOR,
    FLT_LEVEL_FAIL,
    FLT_DOOR_JAM
} Fault_t;

typedef struct {
    uint8_t carCall;
    uint8_t hallUp;
    uint8_t hallDown;
} Calls_t;

typedef struct {
    uint16_t positionCm;
    uint8_t  currentFloor;
    uint8_t  targetFloor;
    uint8_t  doorPct;
    uint16_t loadKg;
    uint16_t currentmA;
    Calls_t  calls;
    uint8_t  dir;
    uint8_t  lastDir;
    uint8_t  state;
    uint8_t  doorState;
    uint8_t  hoistDuty;
    uint8_t  overload    : 1;
    uint8_t  fireService : 1;
    uint8_t  independent : 1;
    uint8_t  estop       : 1;
    uint8_t  obstruction : 1;
    uint8_t  levelled    : 1;
    uint8_t  reserved    : 2;
    uint8_t  activeFault;
    uint16_t doorDwellTicks;
    uint32_t tripCount;
    uint32_t doorCycles;
    uint32_t upTimeSec;
} CarData_t;

extern void HST_SetDuty(uint8_t dutyPct, uint8_t doorPct);
extern void HST_SetDir(HST_Dir_t dir);
extern void HST_Brake(void);

#define LEVEL_TOL_CM   3U
#define CREEP_CM       15U
#define SLOW_CM        60U
#define FULL_DUTY      100U
#define SLOW_DUTY      30U
#define CREEP_DUTY     15U
#define ACCEL_TICKS    50U

static const uint16_t s_floorCm[4] = {0U, 300U, 600U, 900U};

static uint16_t s_targetPositionCm = 0U;
static uint16_t s_startPositionCm  = 0U;
static uint16_t s_accelCounter      = 0U;
static uint8_t  s_relevelCount      = 0U;
static uint8_t  s_motionActive      = 0U;

STD_ReturnType MOT_GoTo(uint8_t targetFloor, uint16_t currentCm) {
    if (targetFloor > 3U) {
        return E_NOK;
    }

    s_targetPositionCm = s_floorCm[targetFloor];
    s_startPositionCm  = currentCm;
    s_accelCounter      = 0U;
    s_relevelCount      = 0U;
    s_motionActive      = 1U;

    return E_OK;
}

void MOT_Stop(void) {
    s_motionActive = 0U;
    s_accelCounter = 0U;
    HST_Brake();
}

uint8_t MOT_AtTarget(uint16_t currentCm) {
    uint16_t dist = (currentCm >= s_targetPositionCm) ? 
                    (currentCm - s_targetPositionCm) : 
                    (s_targetPositionCm - currentCm);
    return (dist <= LEVEL_TOL_CM) ? 1U : 0U;
}

void MOT_Step(CarData_t *car) {
    if (car == 0 || !s_motionActive) {
        return;
    }

    if (car->state == CS_FAULT || car->state == CS_ESTOP || car->activeFault != FLT_NONE) {
        MOT_Stop();
        return;
    }

    uint16_t currentCm = car->positionCm;
    uint16_t remainingDist = 0U;
    HST_Dir_t requiredDir = HST_DIR_NONE;

    if (currentCm < s_targetPositionCm) {
        remainingDist = s_targetPositionCm - currentCm;
        requiredDir = HST_DIR_UP;
    } else if (currentCm > s_targetPositionCm) {
        remainingDist = currentCm - s_targetPositionCm;
        requiredDir = HST_DIR_DOWN;
    } else {
        remainingDist = 0U;
        requiredDir = HST_DIR_NONE;
    }

    if (remainingDist <= LEVEL_TOL_CM) {
        HST_Brake();
        car->hoistDuty = 0U;
        car->dir = HST_DIR_NONE;
        car->levelled = 1U;
        s_motionActive = 0U;
        return;
    }

    car->levelled = 0U;
    car->dir = (uint8_t)requiredDir;
    HST_SetDir(requiredDir);

    uint8_t calculatedDuty = 0U;

    if (remainingDist <= CREEP_CM) {
        calculatedDuty = CREEP_DUTY;
        car->state = CS_LEVELLING;
    } else if (remainingDist <= SLOW_CM) {
        calculatedDuty = SLOW_DUTY;
        car->state = CS_SLOWING;
    } else {
        car->state = CS_MOVING;
        if (s_accelCounter < ACCEL_TICKS) {
            s_accelCounter++;
            calculatedDuty = (uint8_t)(((uint32_t)s_accelCounter * FULL_DUTY) / ACCEL_TICKS);
        } else {
            calculatedDuty = FULL_DUTY;
        }
    }

    car->hoistDuty = calculatedDuty;
    HST_SetDuty(calculatedDuty, car->doorPct);
}

void MOT_RelevelCheck(CarData_t *car) {
    if (car == 0) {
        return;
    }

    uint16_t dist = (car->positionCm >= s_targetPositionCm) ? 
                    (car->positionCm - s_targetPositionCm) : 
                    (s_targetPositionCm - car->positionCm);

    if (dist > LEVEL_TOL_CM) {
        s_relevelCount++;
        if (s_relevelCount > 2U) {
            MOT_Stop();
            car->activeFault = FLT_LEVEL_FAIL;
            car->state = CS_FAULT;
        } else {
            s_motionActive = 1U;
        }
    }
}