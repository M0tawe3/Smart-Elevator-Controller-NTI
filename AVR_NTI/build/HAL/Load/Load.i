# 0 "HAL/Load/Load.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Load/Load.c"
# 1 "HAL/Load/Load.h" 1



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
# 5 "HAL/Load/Load.h" 2




void LOAD_Init(void);
uint16 LOAD_ReadKg(void);
uint8 LOAD_IsOverloaded(void);
# 2 "HAL/Load/Load.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 3 "HAL/Load/Load.c" 2

void LOAD_Init(void)
{
    ADC_Init(1u, 6u);
}

uint16 LOAD_ReadKg(void)
{
    uint16 adcValue = 0U;
    uint16 loadKg = 0U;

    if (ADC_ReadChannel(1u, &adcValue) != E_OK)
    {
        return 0U;
    }

    loadKg = (uint16)(((uint32)adcValue * 1000UL) / 1023UL);
    return loadKg;
}

uint8 LOAD_IsOverloaded(void)
{
    return (LOAD_ReadKg() > 900U) ? 1U : 0U;
}
