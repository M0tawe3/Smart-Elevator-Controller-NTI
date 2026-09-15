# 0 "HAL/Hoist/Hoist.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Hoist/Hoist.c"
# 1 "HAL/Hoist/Hoist.h" 1



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
# 5 "HAL/Hoist/Hoist.h" 2

typedef enum {
    HST_DIR_NONE = 0U,
    HST_DIR_UP,
    HST_DIR_DOWN
} HST_Dir_t;

void HST_Init(void);
void HST_Brake(void);
void HST_SetDir(HST_Dir_t dir);
void HST_SetDuty(uint8 dutyPct, uint8 doorPct);
void HST_EmergencyStop(void);
# 2 "HAL/Hoist/Hoist.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Hoist/Hoist.c" 2
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
# 4 "HAL/Hoist/Hoist.c" 2
# 12 "HAL/Hoist/Hoist.c"
static void HST_ApplyBrakeState(void)
{
    GPIO_SetPinValue(1u, 0u, 0u);
    GPIO_SetPinValue(1u, 1u, 0u);
}

void HST_Init(void)
{
    GPIO_SetPinDirection(1u, 0u, 1u);
    GPIO_SetPinDirection(1u, 1u, 1u);
    GPIO_SetPinDirection(3u, 5u, 1u);

    HST_ApplyBrakeState();

    TIMER1_PWM(10000U, 0U);
}

void HST_Brake(void)
{
    TIMER1_PWM(10000U, 0U);
    HST_ApplyBrakeState();
}

void HST_SetDir(HST_Dir_t dir)
{
    if (dir == HST_DIR_UP) {
        GPIO_SetPinValue(1u, 1u, 0u);
        GPIO_SetPinValue(1u, 0u, 1u);
    } else if (dir == HST_DIR_DOWN) {
        GPIO_SetPinValue(1u, 0u, 0u);
        GPIO_SetPinValue(1u, 1u, 1u);
    } else {
        HST_Brake();
    }
}

void HST_SetDuty(uint8 dutyPct, uint8 doorPct)
{
    if (doorPct > 0U) {
        HST_Brake();
        return;
    }

    if (dutyPct > 100U) {
        dutyPct = 100U;
    }

    TIMER1_PWM(10000U, dutyPct);
}

void HST_EmergencyStop(void)
{
    HST_Brake();
}
