#include <avr/io.h>
#include "Hoist.h"
#include "GPIO_interface.h"

#define HOIST_DIR_PORT     GPIO_PORTB
#define HOIST_DIR_PIN_UP   GPIO_PIN0
#define HOIST_DIR_PIN_DOWN GPIO_PIN1
#define HOIST_PWM_PORT     GPIO_PORTD
#define HOIST_PWM_PIN      GPIO_PIN5
#define HOIST_PWM_TOP      799U

static void HST_ApplyBrakeState(void)
{
    GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_LOW);
    GPIO_SetPinValue(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_LOW);
    /* PWM duty set to zero is handled by the caller/scheduler. */
}

void HST_Init(void)
{
    GPIO_SetPinDirection(HOIST_DIR_PORT, HOIST_DIR_PIN_UP, GPIO_OUTPUT);
    GPIO_SetPinDirection(HOIST_DIR_PORT, HOIST_DIR_PIN_DOWN, GPIO_OUTPUT);
    GPIO_SetPinDirection(HOIST_PWM_PORT, HOIST_PWM_PIN, GPIO_OUTPUT);

    HST_ApplyBrakeState();

    /* Timer1 Fast PWM, mode 14 (ICR1 as TOP), prescaler 1, non-inverting on OC1A */
    TCCR1A = (1U << COM1A1) | (1U << WGM11);
    TCCR1B = (1U << WGM13) | (1U << WGM12) | (1U << CS10);
    ICR1 = HOIST_PWM_TOP;
    OCR1A = 0U;
}

void HST_Brake(void)
{
    OCR1A = 0U;
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

    uint32 compareVal = ((uint32)dutyPct * HOIST_PWM_TOP) / 100U;
    OCR1A = (uint16)compareVal;
}

void HST_EmergencyStop(void)
{
    HST_Brake();
}