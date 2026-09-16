# 0 "MCAL/TIMER/TIMER.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/TIMER/TIMER.c"
# 19 "MCAL/TIMER/TIMER.c"
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







# 18 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;





typedef struct
{
    uint8 carCall;
    uint8 hallUp;
    uint8 hallDown;
} Calls_t;

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
# 20 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 21 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 24 "MCAL/TIMER/TIMER_interface.h"
extern volatile uint8 systemTicks10ms;







STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 76 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);




STD_ReturnType TIMER2_Init(void);


STD_ReturnType TIMER2_PWM(uint8 Copy_u8DutyPercent);


STD_ReturnType TIMER2_Stop(void);
# 22 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 23 "MCAL/TIMER/TIMER.c" 2
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
# 24 "MCAL/TIMER/TIMER.c" 2


# 25 "MCAL/TIMER/TIMER.c"
volatile uint8 systemTicks10ms = 0U;
# 39 "MCAL/TIMER/TIMER.c"
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);
# 48 "MCAL/TIMER/TIMER.c"
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);





STD_ReturnType TIMER0_Init(void)
{
    (*(volatile uint8 *)0x53) = (1 << 3) | (1 << 2) | (1 << 0);
    (*(volatile uint8 *)0x5C) = 77U;
    (*(volatile uint8 *)0x52) = 0U;
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    (*(volatile uint8 *)0x58) |= (1 << 
# 64 "MCAL/TIMER/TIMER.c" 3 4
                     1
# 64 "MCAL/TIMER/TIMER.c"
                         );
    (*(volatile uint8 *)0x53) = ((*(volatile uint8 *)0x53) & (uint8)~0x07U) | (1 << 2) | (1 << 0);
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 68 "MCAL/TIMER/TIMER.c" 3 4
                                       1
# 68 "MCAL/TIMER/TIMER.c"
                                           ));
    }
    (*(volatile uint8 *)0x53) &= ~((1 << 2) | (1 << 1) | (1 << 0));
    return E_OK;
}

STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds)
{
    for (uint16 i = 0; i < Copy_u16Seconds; i++)
    {
        TIMER0_DelayMS(1000);
    }
    return E_OK;
}

STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
        return E_NOK;

    GPIO_SetPinDirection(1u, 3u, 1u);
    (*(volatile uint8 *)0x53) |= (1 << 3) | (1 << 6);
    (*(volatile uint8 *)0x53) |= (1 << 5);
    (*(volatile uint8 *)0x5C) = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    (*(volatile uint8 *)0x53) |= (1 << 1) | (1 << 0);
    return E_OK;
}

STD_ReturnType TIMER0_Stop(void)
{
    (*(volatile uint8 *)0x53) &= ~((1 << 2) | (1 << 1) | (1 << 0));
    (*(volatile uint8 *)0x53) &= ~((1 << 5) | (1 << 4));
    return E_OK;
}





STD_ReturnType TIMER1_Init(void)
{
    (*(volatile uint8 *)0x4F) = 0;
    (*(volatile uint8 *)0x4E) = (1 << 3);
    (*(volatile uint16 *)0x4A) = 999;
    (*(volatile uint16 *)0x4C) = 0;
    return E_OK;
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{
    (*(volatile uint8 *)0x58) = (1 << 
# 118 "MCAL/TIMER/TIMER.c" 3 4
                    4
# 118 "MCAL/TIMER/TIMER.c"
                         );
    (*(volatile uint8 *)0x4E) = ((*(volatile uint8 *)0x4E) & ~((1 << 2) | (1 << 1) | (1 << 0))) | (1 << 1);
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 122 "MCAL/TIMER/TIMER.c" 3 4
                                       4
# 122 "MCAL/TIMER/TIMER.c"
                                            ));
    }
    (*(volatile uint8 *)0x4E) &= ~((1 << 2) | (1 << 1) | (1 << 0));
    return E_OK;
}

STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100 || Copy_u16FrequencyHz < 16 || Copy_u16FrequencyHz > 20000)
        return E_NOK;

    GPIO_SetPinDirection(3u, 5u, 1u);
    (*(volatile uint8 *)0x4F) |= (1 << 7);
    (*(volatile uint8 *)0x4F) |= (1 << 1);
    (*(volatile uint8 *)0x4E) |= (1 << 4) | (1 << 3);
    (*(volatile uint16 *)0x46) = (uint16)((8000000UL / Copy_u16FrequencyHz) - 1UL);
    (*(volatile uint16 *)0x4A) = TIMER_DutyToCompare((*(volatile uint16 *)0x46), Copy_u8DutyPercent);
    (*(volatile uint8 *)0x4E) = ((*(volatile uint8 *)0x4E) & (uint8)~0x07U) | (1 << 0);
    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    (*(volatile uint8 *)0x4E) &= ~((1 << 2) | (1 << 1) | (1 << 0));
    (*(volatile uint8 *)0x4F) &= ~((1 << 7) | (1 << 6));
    return E_OK;
}

STD_ReturnType TIMER2_Init(void)
{
    (*(volatile uint8 *)0x45) = 0U;
    (*(volatile uint8 *)0x44) = 0U;
    (*(volatile uint8 *)0x43) = 0U;
    return E_OK;
}

STD_ReturnType TIMER2_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }

    GPIO_SetPinDirection(3u, 7u, 1u);
    (*(volatile uint8 *)0x45) = (1U << 
# 166 "MCAL/TIMER/TIMER.c" 3 4
                             6
# 166 "MCAL/TIMER/TIMER.c"
                                  ) |
                       (1U << 
# 167 "MCAL/TIMER/TIMER.c" 3 4
                             3
# 167 "MCAL/TIMER/TIMER.c"
                                  ) |
                       (1U << 
# 168 "MCAL/TIMER/TIMER.c" 3 4
                             5
# 168 "MCAL/TIMER/TIMER.c"
                                  ) |
                       (1U << 
# 169 "MCAL/TIMER/TIMER.c" 3 4
                             2
# 169 "MCAL/TIMER/TIMER.c"
                                 );
    (*(volatile uint8 *)0x43) = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    return E_OK;
}

STD_ReturnType TIMER2_Stop(void)
{
    (*(volatile uint8 *)0x45) &= (uint8)~((1U << 
# 176 "MCAL/TIMER/TIMER.c" 3 4
                                       2
# 176 "MCAL/TIMER/TIMER.c"
                                           ) | (1U << 
# 176 "MCAL/TIMER/TIMER.c" 3 4
                                                      1
# 176 "MCAL/TIMER/TIMER.c"
                                                          ) | (1U << 
# 176 "MCAL/TIMER/TIMER.c" 3 4
                                                                     0
# 176 "MCAL/TIMER/TIMER.c"
                                                                         ));
    (*(volatile uint8 *)0x45) &= (uint8)~((1U << 
# 177 "MCAL/TIMER/TIMER.c" 3 4
                                       5
# 177 "MCAL/TIMER/TIMER.c"
                                            ) | (1U << 
# 177 "MCAL/TIMER/TIMER.c" 3 4
                                                       4
# 177 "MCAL/TIMER/TIMER.c"
                                                            ));
    (*(volatile uint8 *)0x43) = 0U;
    return E_OK;
}





static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask)
{
    while ((*Copy_pu8Register & Copy_u8BitMask) == 0)
    {
    }
    *Copy_pu8Register = Copy_u8BitMask;
}

static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent)
{
    uint32 temp = ((uint32)Copy_u16Top) * Copy_u8DutyPercent;
    return (uint16)(temp / 100);
}
