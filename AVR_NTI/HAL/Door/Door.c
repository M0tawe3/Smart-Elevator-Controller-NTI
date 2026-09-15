#include <avr/io.h>
#include "Door.h"
#include "GPIO_interface.h"

#define DOOR_DIR_PORT GPIO_PORTB
#define DOOR_OPEN_PIN GPIO_PIN2
#define DOOR_CLOSE_PIN GPIO_PIN3
#define DOOR_PWM_PORT GPIO_PORTD
#define DOOR_PWM_PIN GPIO_PIN4
#define DOOR_PWM_TOP 799U

void DRV_Init(void)
{
    GPIO_SetPinDirection(DOOR_DIR_PORT, DOOR_OPEN_PIN, GPIO_OUTPUT);
    GPIO_SetPinDirection(DOOR_DIR_PORT, DOOR_CLOSE_PIN, GPIO_OUTPUT);
    GPIO_SetPinDirection(DOOR_PWM_PORT, DOOR_PWM_PIN, GPIO_OUTPUT);

    DRV_Stop();

    TCCR1A = (1U << COM1B1) | (1U << WGM11);
    TCCR1B = (1U << WGM13) | (1U << WGM12) | (1U << CS10);
    ICR1 = DOOR_PWM_TOP;
    OCR1B = 0U;
}

void DRV_SetDir(DRV_Dir_t dir)
{
    if (dir == DRV_DIR_OPEN)
    {
        GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_CLOSE_PIN, GPIO_LOW);
        GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_OPEN_PIN, GPIO_HIGH);
    }
    else if (dir == DRV_DIR_CLOSE)
    {
        GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_OPEN_PIN, GPIO_LOW);
        GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_CLOSE_PIN, GPIO_HIGH);
    }
    else
    {
        DRV_Stop();
    }
}

void DRV_SetDuty(uint8 dutyPct)
{
    if (dutyPct > 100U)
    {
        dutyPct = 100U;
    }

    uint32 compareVal = ((uint32)dutyPct * DOOR_PWM_TOP) / 100U;
    OCR1B = (uint16)compareVal;
}

void DRV_Stop(void)
{
    OCR1B = 0U;
    GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_OPEN_PIN, GPIO_LOW);
    GPIO_SetPinValue(DOOR_DIR_PORT, DOOR_CLOSE_PIN, GPIO_LOW);
}
