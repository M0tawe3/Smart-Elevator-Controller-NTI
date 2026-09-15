# 0 "HAL/Slots/slots.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Slots/slots.c"
# 1 "HAL/Slots/slots.h" 1



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
# 5 "HAL/Slots/slots.h" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 6 "HAL/Slots/slots.h" 2
# 19 "HAL/Slots/slots.h"
STD_ReturnType slots_init(void);
STD_ReturnType slots_read_raw(uint8 *Copy_pu8Mask);
STD_ReturnType slots_read_active_low(uint8 *Copy_pu8Mask);
# 2 "HAL/Slots/slots.c" 2







STD_ReturnType slots_init(void)
{
    for (uint8 i = 2u; i <= 7u; i++)
    {
        if (GPIO_SetPinDirection(2u, i, 2u) != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}







STD_ReturnType slots_read_raw(uint8 *Copy_pu8Mask)
{
    if (Copy_pu8Mask == 
# 30 "HAL/Slots/slots.c" 3 4
                       ((void *)0)
# 30 "HAL/Slots/slots.c"
                           )
    {
        return E_NOK;
    }

    uint8 mask = 0u;

    for (uint8 i = 2u; i <= 7u; i++)
    {
        uint8 level = 0u;

        if (GPIO_GetPinValue(2u, i, &level) != E_OK)
        {
            return E_NOK;
        }

        if (level == 0u)
        {
            mask |= (uint8)(1u << i);
        }
    }

    *Copy_pu8Mask = mask;
    return E_OK;
}







STD_ReturnType slots_read_active_low(uint8 *Copy_pu8Mask)
{
    return slots_read_raw(Copy_pu8Mask);
}
