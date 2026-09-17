# 0 "MCAL/UART/UART.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/UART/UART.c"
# 9 "MCAL/UART/UART.c"
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
# 10 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 16 "MCAL/UART/UART_interface.h"
typedef void (*UART_RxCallback_t)(uint8 data);





STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetRxCallback(UART_RxCallback_t Copy_pfCallback);
# 11 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_private.h" 1
# 12 "MCAL/UART/UART.c" 2
# 1 "/usr/avr/sys-root/include/avr/interrupt.h" 1 3 4
# 38 "/usr/avr/sys-root/include/avr/interrupt.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/io.h" 1 3 4
# 99 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/sfr_defs.h" 1 3 4
# 126 "/usr/avr/sys-root/include/avr/sfr_defs.h" 3 4
# 1 "/usr/avr/sys-root/include/inttypes.h" 1 3 4
# 37 "/usr/avr/sys-root/include/inttypes.h" 3 4
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
# 38 "/usr/avr/sys-root/include/inttypes.h" 2 3 4
# 77 "/usr/avr/sys-root/include/inttypes.h" 3 4
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "/usr/avr/sys-root/include/avr/sfr_defs.h" 2 3 4
# 100 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 230 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/iom32.h" 1 3 4
# 720 "/usr/avr/sys-root/include/avr/iom32.h" 3 4
       
# 721 "/usr/avr/sys-root/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 585 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/portpins.h" 1 3 4
# 586 "/usr/avr/sys-root/include/avr/io.h" 2 3 4

# 1 "/usr/avr/sys-root/include/avr/common.h" 1 3 4
# 588 "/usr/avr/sys-root/include/avr/io.h" 2 3 4

# 1 "/usr/avr/sys-root/include/avr/version.h" 1 3 4
# 590 "/usr/avr/sys-root/include/avr/io.h" 2 3 4






# 1 "/usr/avr/sys-root/include/avr/fuse.h" 1 3 4
# 248 "/usr/avr/sys-root/include/avr/fuse.h" 3 4
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 597 "/usr/avr/sys-root/include/avr/io.h" 2 3 4


# 1 "/usr/avr/sys-root/include/avr/lock.h" 1 3 4
# 600 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 39 "/usr/avr/sys-root/include/avr/interrupt.h" 2 3 4
# 13 "MCAL/UART/UART.c" 2


# 14 "MCAL/UART/UART.c"
static UART_RxCallback_t g_uartRxCallback = 
# 14 "MCAL/UART/UART.c" 3 4
                                           ((void *)0)
# 14 "MCAL/UART/UART.c"
                                               ;
# 24 "MCAL/UART/UART.c"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate)
{
    if (Copy_u32BaudRate == 0)
        return E_NOK;

    uint16 temp = 8000000UL / (16 * Copy_u32BaudRate) - 1;
    
# 30 "MCAL/UART/UART.c" 3 4
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 30 "MCAL/UART/UART.c"
         = temp >> 8;
    
# 31 "MCAL/UART/UART.c" 3 4
   (*(volatile uint8_t *)((0x09) + 0x20)) 
# 31 "MCAL/UART/UART.c"
         = temp & 0xFF;

    
# 33 "MCAL/UART/UART.c" 3 4
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 33 "MCAL/UART/UART.c"
         |= (1 << 
# 33 "MCAL/UART/UART.c" 3 4
                  7
# 33 "MCAL/UART/UART.c"
                       ) | (1 << 
# 33 "MCAL/UART/UART.c" 3 4
                                 2
# 33 "MCAL/UART/UART.c"
                                      ) | (1 << 
# 33 "MCAL/UART/UART.c" 3 4
                                                1
# 33 "MCAL/UART/UART.c"
                                                     );
    
# 34 "MCAL/UART/UART.c" 3 4
   (*(volatile uint8_t *)((0x0A) + 0x20)) 
# 34 "MCAL/UART/UART.c"
         |= (1 << 
# 34 "MCAL/UART/UART.c" 3 4
                  4
# 34 "MCAL/UART/UART.c"
                      ) | (1 << 
# 34 "MCAL/UART/UART.c" 3 4
                                3
# 34 "MCAL/UART/UART.c"
                                    );

    return E_OK;
}





STD_ReturnType UART_SendByte(uint8 Copy_u8Data)
{
    while (!(((
# 45 "MCAL/UART/UART.c" 3 4
           (*(volatile uint8_t *)((0x0B) + 0x20))
# 45 "MCAL/UART/UART.c"
           ) >> (
# 45 "MCAL/UART/UART.c" 3 4
           5
# 45 "MCAL/UART/UART.c"
           )) & 1u))
    {
    };

    
# 49 "MCAL/UART/UART.c" 3 4
   (*(volatile uint8_t *)((0x0C) + 0x20)) 
# 49 "MCAL/UART/UART.c"
       = Copy_u8Data;
    return E_OK;
}






STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data)
{
    if (Copy_pu8Data == 
# 60 "MCAL/UART/UART.c" 3 4
                       ((void *)0)
# 60 "MCAL/UART/UART.c"
                           )
        return E_NOK;

    while (!(((
# 63 "MCAL/UART/UART.c" 3 4
           (*(volatile uint8_t *)((0x0B) + 0x20))
# 63 "MCAL/UART/UART.c"
           ) >> (
# 63 "MCAL/UART/UART.c" 3 4
           7
# 63 "MCAL/UART/UART.c"
           )) & 1u))
    {
    };

    *Copy_pu8Data = 
# 67 "MCAL/UART/UART.c" 3 4
                   (*(volatile uint8_t *)((0x0C) + 0x20))
# 67 "MCAL/UART/UART.c"
                      ;

    return E_OK;
}






STD_ReturnType UART_SendString(const uint8 *Copy_pu8String)
{
    if (Copy_pu8String == 
# 79 "MCAL/UART/UART.c" 3 4
                         ((void *)0)
# 79 "MCAL/UART/UART.c"
                             )
        return E_NOK;

    else
    {
        for (uint8 i = 0; Copy_pu8String[i] != '\0'; i++)
            UART_SendByte(Copy_pu8String[i]);

        return E_OK;
    }
}





STD_ReturnType UART_IsDataReady()
{
    if ((((
# 97 "MCAL/UART/UART.c" 3 4
       (*(volatile uint8_t *)((0x0B) + 0x20))
# 97 "MCAL/UART/UART.c"
       ) >> (
# 97 "MCAL/UART/UART.c" 3 4
       7
# 97 "MCAL/UART/UART.c"
       )) & 1u))
        return E_OK;
    else
        return E_NOK;
}






STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 0U)
    {
        ((
# 112 "MCAL/UART/UART.c" 3 4
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 112 "MCAL/UART/UART.c"
       ) &= ~(1u << (
# 112 "MCAL/UART/UART.c" 3 4
       7
# 112 "MCAL/UART/UART.c"
       )));
    }
    else
    {
        ((
# 116 "MCAL/UART/UART.c" 3 4
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 116 "MCAL/UART/UART.c"
       ) |= (1u << (
# 116 "MCAL/UART/UART.c" 3 4
       7
# 116 "MCAL/UART/UART.c"
       )));
    }
    return E_OK;
}

STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 0U)
    {
        ((
# 125 "MCAL/UART/UART.c" 3 4
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 125 "MCAL/UART/UART.c"
       ) &= ~(1u << (
# 125 "MCAL/UART/UART.c" 3 4
       5
# 125 "MCAL/UART/UART.c"
       )));
    }
    else
    {
        ((
# 129 "MCAL/UART/UART.c" 3 4
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 129 "MCAL/UART/UART.c"
       ) |= (1u << (
# 129 "MCAL/UART/UART.c" 3 4
       5
# 129 "MCAL/UART/UART.c"
       )));
    }
    return E_OK;
}

STD_ReturnType UART_SetRxCallback(UART_RxCallback_t Copy_pfCallback)
{
    g_uartRxCallback = Copy_pfCallback;
    return E_OK;
}


# 140 "MCAL/UART/UART.c" 3 4
void __vector_13 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_13 (void)

# 141 "MCAL/UART/UART.c"
{
    uint8 data = 
# 142 "MCAL/UART/UART.c" 3 4
                (*(volatile uint8_t *)((0x0C) + 0x20))
# 142 "MCAL/UART/UART.c"
                   ;
    if (g_uartRxCallback != 
# 143 "MCAL/UART/UART.c" 3 4
                           ((void *)0)
# 143 "MCAL/UART/UART.c"
                               )
    {
        g_uartRxCallback(data);
    }
}
