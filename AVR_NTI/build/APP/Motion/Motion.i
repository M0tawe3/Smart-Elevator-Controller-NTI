# 0 "APP/Motion/Motion.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "APP/Motion/Motion.c"
# 1 "/usr/lib64/gcc/avr/15/include/stdint.h" 1 3 4
# 9 "/usr/lib64/gcc/avr/15/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "/usr/avr/sys-root/include/stdint.h" 1 3 4
# 125 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "/usr/lib64/gcc/avr/15/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 2 "APP/Motion/Motion.c" 2
# 1 "HAL/Hoist/Hoist.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2
# 22 "LIB/STD_TYPES.h"

# 22 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

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
    DOOR_STATE_CLOSED = 0U,
    DOOR_STATE_OPENING,
    DOOR_STATE_OPEN,
    DOOR_STATE_CLOSING,
    DOOR_STATE_JAMMED
} DoorState_t;

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
    uint8 carCall;
    uint8 hallUp;
    uint8 hallDown;
} Calls_t;

typedef struct {
    uint16 positionCm;
    uint8 currentFloor;
    uint8 targetFloor;
    uint8 doorPct;
    uint16 loadKg;
    uint16 currentmA;
    Calls_t calls;
    uint8 dir;
    uint8 lastDir;
    uint8 state;
    uint8 doorState;
    uint8 hoistDuty;
    uint8 overload : 1;
    uint8 fireService : 1;
    uint8 independent : 1;
    uint8 estop : 1;
    uint8 obstruction : 1;
    uint8 levelled : 1;
    uint8 reserved : 2;
    uint8 activeFault;
    uint16 doorDwellTicks;
    uint32 tripCount;
    uint32 doorCycles;
    uint32 upTimeSec;
} CarData_t;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;

typedef enum
{
    CALL_CAR,
    CALL_HALL_UP,
    CALL_HALL_DOWN
} CallType_t;

typedef enum
{
    DIR_NONE,
    DIR_UP,
    DIR_DOWN
} Dir_t;
# 5 "HAL/Hoist/Hoist.h" 2

typedef enum {
    HST_DIR_NONE = 0U,
    HST_DIR_UP,
    HST_DIR_DOWN
} HST_Dir_t;

void HST_Init(void);
void HST_Brake(void);
void HST_SetDir(HST_Dir_t dir);
void HST_SetDuty(uint8 dutyPct, uint8 doorPct);
void HST_EmergencyStop(void);
# 3 "APP/Motion/Motion.c" 2



extern void HST_SetDuty(uint8_t dutyPct, uint8_t doorPct);
extern void HST_SetDir(HST_Dir_t dir);
extern void HST_Brake(void);
# 18 "APP/Motion/Motion.c"
static const uint16 s_floorCm[4] = {0U, 300U, 600U, 900U};

static uint16 s_targetPositionCm = 0U;
static uint16 s_startPositionCm = 0U;
static uint16 s_accelCounter = 0U;
static uint8 s_relevelCount = 0U;
static uint8 s_motionActive = 0U;

STD_ReturnType MOT_GoTo(uint8 targetFloor, uint16 currentCm) {
    if (targetFloor > 3U) {
        return E_NOK;
    }

    s_targetPositionCm = s_floorCm[targetFloor];
    s_startPositionCm = currentCm;
    s_accelCounter = 0U;
    s_relevelCount = 0U;
    s_motionActive = 1U;

    return E_OK;
}

void MOT_Stop(void) {
    s_motionActive = 0U;
    s_accelCounter = 0U;
    HST_Brake();
}

uint8_t MOT_AtTarget(uint16 currentCm) {
    uint16 dist = (currentCm >= s_targetPositionCm) ?
                    (currentCm - s_targetPositionCm) :
                    (s_targetPositionCm - currentCm);
    return (dist <= 3U) ? 1U : 0U;
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

    if (remainingDist <= 3U) {
        HST_Brake();
        car->hoistDuty = 0U;
        car->dir = HST_DIR_NONE;
        car->levelled = 1U;
        s_motionActive = 0U;
        return;
    }

    car->levelled = 0U;
    car->dir = (uint8)requiredDir;
    HST_SetDir(requiredDir);

    uint8_t calculatedDuty = 0U;

    if (remainingDist <= 15U) {
        calculatedDuty = 15U;
        car->state = CS_LEVELLING;
    } else if (remainingDist <= 60U) {
        calculatedDuty = 30U;
        car->state = CS_SLOWING;
    } else {
        car->state = CS_MOVING;
        if (s_accelCounter < 50U) {
            s_accelCounter++;
            calculatedDuty = (uint8)(((uint32)s_accelCounter * 100U) / 50U);
        } else {
            calculatedDuty = 100U;
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

    if (dist > 3U) {
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
