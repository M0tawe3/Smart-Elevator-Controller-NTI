# 0 "HAL/Buzzer/Buzzer.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Buzzer/Buzzer.c"
# 1 "HAL/Buzzer/Buzzer.h" 1



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
# 5 "HAL/Buzzer/Buzzer.h" 2

void BUZ_Init(void);
void BUZ_Chime(void);
void BUZ_Alarm(void);
void BUZ_Stop(void);
# 2 "HAL/Buzzer/Buzzer.c" 2
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
# 3 "HAL/Buzzer/Buzzer.c" 2

void BUZ_Init(void)
{
    TIMER2_Init();
    TIMER2_Stop();
}

void BUZ_Chime(void)
{
    TIMER2_PWM(35U);
}

void BUZ_Alarm(void)
{
    TIMER2_PWM(80U);
}

void BUZ_Stop(void)
{
    TIMER2_Stop();
}
