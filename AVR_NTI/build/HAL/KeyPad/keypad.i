# 0 "HAL/KeyPad/keypad.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/KeyPad/keypad.c"
# 1 "HAL/KeyPad/keypad.h" 1



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
# 5 "HAL/KeyPad/keypad.h" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 6 "HAL/KeyPad/keypad.h" 2
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 1 3 4
# 7 "HAL/KeyPad/keypad.h" 2

STD_ReturnType keypad_init(uint8 port);

STD_ReturnType keypad_get_keypressed(uint8 port, uint8 *value);
# 2 "HAL/KeyPad/keypad.c" 2

uint8 keypad_map[4][4] = {
    {1, 2, 3, 'A'},
    {4, 5, 6, 'B'},
    {7, 8, 9, 'C'},
    {'*', 0, '#', 'D'}};

STD_ReturnType keypad_init(uint8 port)
{

    return GPIO_SetPortDirection(port, 0x0F);
}

STD_ReturnType keypad_get_keypressed(uint8 port, uint8 *value)
{
    if (value == 
# 17 "HAL/KeyPad/keypad.c" 3 4
                ((void *)0)
# 17 "HAL/KeyPad/keypad.c"
                    )
        return E_NOK;


    GPIO_SetPortDirection(port, 0x0F);

    for (uint8 row = 0; row < 4; row++)
    {

        GPIO_SetPortValue(port, ~(1 << row));

        for (uint8 col = 0; col < 4; col++)
        {
            uint8 pin_value;
            GPIO_GetPinValue(port, col + 4, &pin_value);

            if (pin_value == 0u)
            {
                *value = keypad_map[row][col];
                return E_OK;
            }
        }
    }

    return E_NOK;
}
