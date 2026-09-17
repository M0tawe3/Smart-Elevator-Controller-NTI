# 0 "MCAL/ADC/ADC.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/ADC/ADC.c"
# 9 "MCAL/ADC/ADC.c"
# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4

# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2
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
# 13 "LIB/STD_TYPES.h" 2
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
# 10 "MCAL/ADC/ADC.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 11 "MCAL/ADC/ADC.c" 2
# 1 "MCAL/ADC/ADC_private.h" 1
# 12 "MCAL/ADC/ADC.c" 2
# 20 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler)
{
    if ((Copy_u8Ref != 1u && Copy_u8Ref != 0u && Copy_u8Ref != 3u) || (Copy_u8Prescaler > 7u || Copy_u8Prescaler < 1u))
        return E_NOK;

    (*(volatile uint8 *)0x27) = (Copy_u8Ref << 6);
    (*(volatile uint8 *)0x26) = (1 << 7) | (Copy_u8Prescaler & 0x07);
    return E_OK;
}
# 38 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading)
{
    if (Copy_u8Channel > 7u || Copy_pu16Reading == 
# 40 "MCAL/ADC/ADC.c" 3 4
                                                             ((void *)0)
# 40 "MCAL/ADC/ADC.c"
                                                                 )
        return E_NOK;


    (*(volatile uint8 *)0x27) = ((*(volatile uint8 *)0x27) & 0xE0U) | (Copy_u8Channel & 0x1FU);
    (((*(volatile uint8 *)0x26)) |= (1u << (4)));
    (((*(volatile uint8 *)0x26)) |= (1u << (6)));

    while (((((*(volatile uint8 *)0x26)) >> (6)) & 1u) == 1U)
    {
    }

    (((*(volatile uint8 *)0x26)) |= (1u << (4)));
    uint8 low = (*(volatile uint8 *)0x24);
    uint8 high = (*(volatile uint8 *)0x25);
    *Copy_pu16Reading = (high << 8) | low;
    return E_OK;
}






STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel)
{
    if (Copy_u8Channel > 7u)
        return E_NOK;

    (*(volatile uint8 *)0x27) = ((*(volatile uint8 *)0x27) & 0xE0U) | (Copy_u8Channel & 0x1FU);
    (((*(volatile uint8 *)0x26)) |= (1u << (4)));
    (((*(volatile uint8 *)0x26)) |= (1u << (6)));
    return E_OK;
}






STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading)
{
    if (Copy_pu16Reading == 
# 82 "MCAL/ADC/ADC.c" 3 4
                           ((void *)0) 
# 82 "MCAL/ADC/ADC.c"
                                || ((((*(volatile uint8 *)0x26)) >> (4)) & 1u) == 0)
        return E_NOK;

    (((*(volatile uint8 *)0x26)) |= (1u << (4)));
    *Copy_pu16Reading = ((*(volatile uint8 *)0x25) << 8) | (*(volatile uint8 *)0x24);
    return E_OK;
}






STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State > 1)
        return E_NOK;

    if (Copy_u8State == 1)
        (((*(volatile uint8 *)0x26)) |= (1u << (3)));
    else
        (((*(volatile uint8 *)0x26)) &= ~(1u << (3)));

    return E_OK;
}
