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
#include "UART_interface.h"
#include "HAL/Slots/slots.h"

int main(void)
{
    uint8 sensor_mask = 0u;

    UART_Init(9600);
    slots_init();

    UART_SendString("Slot sensor test started\r\n");

    while (1)
    {
        if (slots_read_raw(&sensor_mask) == E_OK)
        {
            UART_SendString("Sensors: ");

            for (uint8 bit = SLOT_SENSOR_START_PIN; bit <= SLOT_SENSOR_END_PIN; bit++)
            {
                uint8 value = (sensor_mask >> bit) & 1u;
                UART_SendByte((uint8)('0' + value));
                UART_SendByte(' ');
            }

            UART_SendString("\r\n");
        }

        TIMER0_DelayMS(100);
    }

    return 0;
}
