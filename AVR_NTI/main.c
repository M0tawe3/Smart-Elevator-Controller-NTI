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

  /* Configure a separate GPIO pin for Parallel Load (e.g., PORTD, PIN0) */
  GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN0, GPIO_OUTPUT);
  GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN0, GPIO_HIGH);

  uint8 rec;
  while (1)
  {
    /* 1. Latch parallel data into the 74HC165 */
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN0, GPIO_LOW);
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN0, GPIO_HIGH);

    /* 2. Shift data out via SPI (no need for SPI_SelectSlave since 74HC165 has no CS pin) */
    SPI_Transceive(0xFF, &rec);

    UART_SendByte('A');

    TIMER0_DelayMS(200);
  }
  return 0;
}
