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
#include "HAL/HC165/HC165.h"

int main(void)
{
  UART_Init(9600);
  TIMER0_Init();
  SPI_InitMaster(SPI_PRESC_4);

  uint8 rec;
  while (1)
  {
    rec = HC165_Read(GPIO_PORTB, GPIO_PIN4);

    UART_SendByte(rec);

    TIMER0_DelayMS(1000);
  }
  return 0;
}
