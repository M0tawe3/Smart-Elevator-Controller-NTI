/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */

#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "ADC_interface.h"
#include "TIMER_interface.h"

void led_isr(void)
{
  GPIO_TogglePinValue(GPIO_PORTA, GPIO_PIN7);
}

int main(void)
{
  GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN4, GPIO_OUTPUT);
  GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN7, GPIO_OUTPUT);
  EXTI_SetSense(EXTI_INT0, EXTI_ANY_CHANGE);
  EXTI_SetCallback(EXTI_INT0, led_isr);
  EXTI_Enable(EXTI_INT0);
  INTERRUPT_EnableGlobal();

  while (1)
  {
    GPIO_TogglePinValue(GPIO_PORTA, GPIO_PIN4);
    TIMER0_DelayMS(1000);
  }
  return 0;
}
