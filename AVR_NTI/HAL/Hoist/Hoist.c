#include "Hoist.h"
#include "GPIO_interface.h"
#include "TIMER_interface.h"

#define HOIST_DIR_PORT     GPIO_PORTB
#define HOIST_DIR_PIN_UP   GPIO_PIN0
#define HOIST_DIR_PIN_DOWN GPIO_PIN1
#define HOIST_PWM_PORT     GPIO_PORTD
#define HOIST_PWM_PIN      GPIO_PIN5
#define HOIST_PWM_FREQUENCY 10000U

static void HST_ApplyBrakeState(void)
{
    GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_LOW);
    GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_LOW);
}

void HST_Init(void)
{
    GPIO_SetPinDirection(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_OUTPUT);
    GPIO_SetPinDirection(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_OUTPUT);
    GPIO_SetPinDirection(HOIST_PWM_PORT, HOIST_PWM_PIN, GPIO_OUTPUT);

    HST_ApplyBrakeState();

    TIMER1_PWM(HOIST_PWM_FREQUENCY, 0U);
}

void HST_Brake(void)
{
    TIMER1_PWM(HOIST_PWM_FREQUENCY, 0U);
    HST_ApplyBrakeState();
}

void HST_SetDir(HST_Dir_t dir)
{
    if (dir == HST_DIR_UP) {
        GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_LOW);
        GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_HIGH);
    } else if (dir == HST_DIR_DOWN) {
        GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_LOW);
        GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_HIGH);
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

    TIMER1_PWM(HOIST_PWM_FREQUENCY, dutyPct);
}

void HST_EmergencyStop(void)
{
    HST_Brake();
}