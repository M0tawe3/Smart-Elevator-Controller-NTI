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
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);
# 22 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 23 "MCAL/TIMER/TIMER.c" 2
# 36 "MCAL/TIMER/TIMER.c"
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);
# 45 "MCAL/TIMER/TIMER.c"
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);





STD_ReturnType TIMER0_Init(void)
{
    (*(volatile uint8 *)0x53) = (1 << 3);
    (*(volatile uint8 *)0x5C) = 124;
    (*(volatile uint8 *)0x52) = 0;
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    (*(volatile uint8 *)0x58) |= (1 << 1);
    (*(volatile uint8 *)0x53) |= (1 << 1) | (1 << 0);
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 1));
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
    (*(volatile uint8 *)0x58) = (1 << 4);
    (*(volatile uint8 *)0x4E) = ((*(volatile uint8 *)0x4E) & ~((1 << 2) | (1 << 1) | (1 << 0))) | (1 << 1);
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 4));
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
    (*(volatile uint16 *)0x46) = (1000000UL / Copy_u16FrequencyHz) - 1;
    (*(volatile uint16 *)0x4A) = TIMER_DutyToCompare((*(volatile uint16 *)0x46), Copy_u8DutyPercent);
    (*(volatile uint8 *)0x4E) |= (1 << 1);
    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    (*(volatile uint8 *)0x4E) &= ~((1 << 2) | (1 << 1) | (1 << 0));
    (*(volatile uint8 *)0x4F) &= ~((1 << 7) | (1 << 6));
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
