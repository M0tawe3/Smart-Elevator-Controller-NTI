#include "Buzzer.h"
#include "TIMER_interface.h"

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
