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
#include "SPI_interface.h"
#include "UART_interface.h"
#include "HAL/HC595/HC595.h"

int main(void)
{
  TIMER2_Init();
  ADC_Init(ADC_REF_AREF, ADC_PRESC_64);
  while (1)
  {
    uint16 reading;
    uint8 disp;
    ADC_ReadChannel(ADC_CHANNEL_0, &reading);

    disp = ((uint32)reading *100)/1024;
    TIMER2_PWM(disp);
  }
  return 0;
}
