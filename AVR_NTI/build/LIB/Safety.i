# 0 "LIB/Safety.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "LIB/Safety.c"
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
# 2 "LIB/Safety.c" 2


# 3 "LIB/Safety.c"
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
    uint8_t currentFloor;
    uint8_t targetFloor;
    uint8_t doorPct;
    uint16_t loadKg;
    uint16_t currentmA;
    Calls_t calls;
    uint8_t dir;
    uint8_t lastDir;
    uint8_t state;
    uint8_t doorState;
    uint8_t hoistDuty;
    uint8_t overload : 1;
    uint8_t fireService : 1;
    uint8_t independent : 1;
    uint8_t estop : 1;
    uint8_t obstruction : 1;
    uint8_t levelled : 1;
    uint8_t reserved : 2;
    uint8_t activeFault;
    uint16_t doorDwellTicks;
    uint32_t tripCount;
    uint32_t doorCycles;
    uint32_t upTimeSec;
} CarData_t;






static uint16_t s_overcurrentTimer = 0U;

void SAF_Evaluate(CarData_t *car) {
    if (car == 0) {
        return;
    }

    if (car->estop) {
        car->activeFault = FLT_ESTOP;
        car->state = CS_ESTOP;
        return;
    }

    if (car->positionCm > 1005U) {
        car->activeFault = FLT_OVERTRAVEL;
        car->state = CS_FAULT;
        return;
    }

    if ((car->doorPct > 5U) && (car->hoistDuty > 0U)) {
        car->activeFault = FLT_DOOR_JAM;
        car->state = CS_FAULT;
        return;
    }

    if (car->currentmA > 15000U) {
        s_overcurrentTimer++;
        if (s_overcurrentTimer >= 50U) {
            car->activeFault = FLT_OVERCURRENT;
            car->state = CS_FAULT;
            return;
        }
    } else {
        s_overcurrentTimer = 0U;
    }

    if (car->loadKg > 900U) {
        car->overload = 1U;
        if (car->state == CS_IDLE || car->state == CS_DOOR_OPEN) {
            car->state = CS_OVERLOAD;
        }
    } else if (car->overload && (car->loadKg < 850U)) {
        car->overload = 0U;
    }
}

uint8_t SAF_Active(const CarData_t *car) {
    if (car == 0) {
        return 1U;
    }

    if (car->estop || car->activeFault != FLT_NONE || car->state == CS_FAULT || car->state == CS_ESTOP) {
        return 1U;
    }

    return 0U;
}
