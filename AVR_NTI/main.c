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

int main(void)
{
  UART_Init(9600);
  TIMER0_Init();
  SPI_InitMaster(SPI_PRESC_16);

  uint8 rec;
  while (1)
  {

    SPI_SelectSlave(GPIO_PORTB, GPIO_PIN4);

    SPI_Transceive(0x55, &rec);

    SPI_ReleaseSlave(GPIO_PORTB, GPIO_PIN4);
    UART_SendByte(rec);
    TIMER0_DelayMS(200);
  }
  return 0;
}
