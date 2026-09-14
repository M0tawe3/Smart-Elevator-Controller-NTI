# 0 "HAL/Position/position.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Position/position.c"
# 1 "HAL/Position/position.h" 1



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
# 5 "HAL/Position/position.h" 2






STD_ReturnType get_position(uint8 *Copy_pu8Position);
# 2 "HAL/Position/position.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 3 "HAL/Position/position.c" 2

STD_ReturnType get_position(uint8 *floor)
{
    uint16 reading;
    ADC_ReadChannel(0u, &reading);

    if (reading < 300)
    {
        *floor = 0;
    }
    else if (reading < 600)
    {
        *floor = 1;
    }
    else if (reading < 900)
    {
        *floor = 2;
    }
    else
    {
        *floor = 3;
    }

    return E_OK;
}
