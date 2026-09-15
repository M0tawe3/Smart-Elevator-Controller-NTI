# 0 "MCAL/GPIO/GPIO.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/GPIO/GPIO.c"
# 9 "MCAL/GPIO/GPIO.c"
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
# 10 "MCAL/GPIO/GPIO.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 11 "MCAL/GPIO/GPIO.c" 2
# 1 "MCAL/GPIO/GPIO_private.h" 1
# 12 "MCAL/GPIO/GPIO.c" 2
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 1 3 4
# 13 "MCAL/GPIO/GPIO.c" 2

STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    volatile uint8 *port_reg;
    volatile uint8 *ddr_reg;

    switch (Copy_u8Port)
    {
    case 0u:
        port_reg = &(*(volatile uint8 *)0x3B);
        ddr_reg = &(*(volatile uint8 *)0x3A);
        break;

    case 1u:
        port_reg = &(*(volatile uint8 *)0x38);
        ddr_reg = &(*(volatile uint8 *)0x37);
        break;

    case 2u:
        port_reg = &(*(volatile uint8 *)0x35);
        ddr_reg = &(*(volatile uint8 *)0x34);
        break;

    case 3u:
        port_reg = &(*(volatile uint8 *)0x32);
        ddr_reg = &(*(volatile uint8 *)0x31);
        break;

    default:
        return E_NOK;
    }

    switch (Copy_u8Direction)
    {
    case 0u:

        ((*ddr_reg) &= ~(1u << (Copy_u8Pin)));
        ((*port_reg) &= ~(1u << (Copy_u8Pin)));
        break;

    case 1u:

        ((*ddr_reg) |= (1u << (Copy_u8Pin)));
        ((*port_reg) &= ~(1u << (Copy_u8Pin)));
        break;

    case 2u:

        ((*ddr_reg) &= ~(1u << (Copy_u8Pin)));
        ((*port_reg) |= (1u << (Copy_u8Pin)));
        break;
    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        if (Copy_u8Value == 1u)
        {
            (((*(volatile uint8 *)0x3B)) |= (1u << (Copy_u8Pin)));
        }
        else if (Copy_u8Value == 0u)
        {
            (((*(volatile uint8 *)0x3B)) &= ~(1u << (Copy_u8Pin)));
        }
        else
        {
            return E_NOK;
        }
        break;

    case 1u:
        if (Copy_u8Value == 1u)
        {
            (((*(volatile uint8 *)0x38)) |= (1u << (Copy_u8Pin)));
        }
        else if (Copy_u8Value == 0u)
        {
            (((*(volatile uint8 *)0x38)) &= ~(1u << (Copy_u8Pin)));
        }
        else
        {
            return E_NOK;
        }
        break;

    case 2u:
        if (Copy_u8Value == 1u)
        {
            (((*(volatile uint8 *)0x35)) |= (1u << (Copy_u8Pin)));
        }
        else if (Copy_u8Value == 0u)
        {
            (((*(volatile uint8 *)0x35)) &= ~(1u << (Copy_u8Pin)));
        }
        else
        {
            return E_NOK;
        }
        break;

    case 3u:
        if (Copy_u8Value == 1u)
        {
            (((*(volatile uint8 *)0x32)) |= (1u << (Copy_u8Pin)));
        }
        else if (Copy_u8Value == 0u)
        {
            (((*(volatile uint8 *)0x32)) &= ~(1u << (Copy_u8Pin)));
        }
        else
        {
            return E_NOK;
        }
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u || Copy_pu8Value == 
# 154 "MCAL/GPIO/GPIO.c" 3 4
                                                                              ((void *)0)
# 154 "MCAL/GPIO/GPIO.c"
                                                                                  )
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x39)) >> (Copy_u8Pin)) & 1u);
        break;

    case 1u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x36)) >> (Copy_u8Pin)) & 1u);
        break;

    case 2u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x33)) >> (Copy_u8Pin)) & 1u);
        break;

    case 3u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x30)) >> (Copy_u8Pin)) & 1u);
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (((*(volatile uint8 *)0x3B)) ^= (1u << (Copy_u8Pin)));
        break;

    case 1u:
        (((*(volatile uint8 *)0x38)) ^= (1u << (Copy_u8Pin)));
        break;

    case 2u:
        (((*(volatile uint8 *)0x35)) ^= (1u << (Copy_u8Pin)));
        break;

    case 3u:
        (((*(volatile uint8 *)0x32)) ^= (1u << (Copy_u8Pin)));
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > 3u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (*(volatile uint8 *)0x3A) = Copy_u8Direction;
        break;

    case 1u:
        (*(volatile uint8 *)0x37) = Copy_u8Direction;
        break;

    case 2u:
        (*(volatile uint8 *)0x34) = Copy_u8Direction;
        break;

    case 3u:
        (*(volatile uint8 *)0x31) = Copy_u8Direction;
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value)
{
    if (Copy_u8Port > 3u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (*(volatile uint8 *)0x3B) = Copy_u8Value;
        break;

    case 1u:
        (*(volatile uint8 *)0x38) = Copy_u8Value;
        break;

    case 2u:
        (*(volatile uint8 *)0x35) = Copy_u8Value;
        break;

    case 3u:
        (*(volatile uint8 *)0x32) = Copy_u8Value;
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > 3u || Copy_pu8Value == 
# 282 "MCAL/GPIO/GPIO.c" 3 4
                                                    ((void *)0)
# 282 "MCAL/GPIO/GPIO.c"
                                                        )
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        *Copy_pu8Value = (*(volatile uint8 *)0x39);
        break;

    case 1u:
        *Copy_pu8Value = (*(volatile uint8 *)0x36);
        break;

    case 2u:
        *Copy_pu8Value = (*(volatile uint8 *)0x33);
        break;

    case 3u:
        *Copy_pu8Value = (*(volatile uint8 *)0x30);
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}
