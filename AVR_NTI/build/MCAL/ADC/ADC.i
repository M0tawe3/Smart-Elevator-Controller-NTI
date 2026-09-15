# 0 "MCAL/ADC/ADC.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/ADC/ADC.c"
# 9 "MCAL/ADC/ADC.c"
# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 1 3 4
# 160 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4

# 160 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
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

    (*(volatile uint8 *)0x27) |= (Copy_u8Channel & 0x1F);
    (((*(volatile uint8 *)0x26)) |= (1u << (6)));
    while (((((*(volatile uint8 *)0x26)) >> (4)) & 1u) == 0)
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

    (*(volatile uint8 *)0x27) |= (Copy_u8Channel & 0x1F);
    (*(volatile uint8 *)0x26) |= (1 << 6);
    return E_OK;
}






STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading)
{
    if (Copy_pu16Reading == 
# 77 "MCAL/ADC/ADC.c" 3 4
                           ((void *)0) 
# 77 "MCAL/ADC/ADC.c"
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
