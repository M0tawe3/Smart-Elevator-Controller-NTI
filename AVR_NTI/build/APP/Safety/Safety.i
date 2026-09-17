# 0 "APP/Safety/Safety.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "APP/Safety/Safety.c"
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
# 2 "APP/Safety/Safety.c" 2
# 1 "APP/Safety/Safety.h" 1



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
# 23 "LIB/STD_TYPES.h"

# 23 "LIB/STD_TYPES.h"
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
    FLT_OVERLOAD,
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

typedef enum {
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;

typedef enum
{
    CALL_CAR,
    CALL_HALL_UP,
    CALL_HALL_DOWN
} CallType_t;

typedef enum {
    DIR_NONE,
    DIR_UP,
    DIR_DOWN
} Dir_t;
# 5 "APP/Safety/Safety.h" 2

void SAF_Evaluate(CarData_t *car);
uint8 SAF_Active(const CarData_t *car);
# 3 "APP/Safety/Safety.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 4 "APP/Safety/Safety.c" 2
# 1 "./APP/Fault_log/fault_log.h" 1







void FL_Init(void);
void FL_Clear(void);
void FL_AddFault(uint8 faultCode);
uint8 FL_GetCount(void);
uint8 FL_ReadNewest(void);
uint8 FL_ReadOldest(void);
uint8 FL_ReadAt(uint8 index);
# 5 "APP/Safety/Safety.c" 2







static uint16_t s_overcurrentTimer = 0U;

void SAF_Evaluate(CarData_t *car) {
    if (car == 0) {
        return;
    }

    if (car->estop) {
        car->activeFault = FLT_ESTOP;
        car->state = CS_ESTOP;
        FL_AddFault(FLT_ESTOP);
        return;
    }

    if (car->positionCm > 1005U) {
        car->activeFault = FLT_OVERTRAVEL;
        FL_AddFault(FLT_OVERTRAVEL);
        car->state = CS_FAULT;
        return;
    }

    if ((car->doorPct > 5U) && (car->hoistDuty > 0U)) {
        car->activeFault = FLT_DOOR_JAM;
        FL_AddFault(FLT_DOOR_JAM);
        car->state = CS_FAULT;
        return;
    }

    if (car->currentmA > 15000U) {
        s_overcurrentTimer++;
        if (s_overcurrentTimer >= 50U) {
            car->activeFault = FLT_OVERCURRENT;
            FL_AddFault(FLT_OVERCURRENT);
            car->state = CS_FAULT;
            return;
        }
    } else {
        s_overcurrentTimer = 0U;
        if (car->currentmA <= 14000U &&
            car->activeFault == FLT_OVERCURRENT) {
            car->activeFault = FLT_NONE;
            if (car->state == CS_FAULT) {
                car->state = CS_IDLE;
            }
        }
    }

    if (car->loadKg >= 900U) {
        car->overload = 1U;
        car->activeFault = FLT_OVERLOAD;
        FL_AddFault(FLT_OVERLOAD);
        if (car->state == CS_IDLE || car->state == CS_DOOR_OPEN) {
            car->state = CS_OVERLOAD;
            GPIO_SetPinValue(2u, 7u, 1u);
        }
    } else if (car->overload && (car->loadKg <= 850U)) {
        car->overload = 0U;
        car->activeFault = FLT_NONE;
        GPIO_SetPinValue(2u, 7u, 0u);
        if (car->state == CS_OVERLOAD) {
            car->state = CS_IDLE;
        }
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
