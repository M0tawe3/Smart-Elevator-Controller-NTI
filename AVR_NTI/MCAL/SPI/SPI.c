/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — SPI.c  (ATmega32, mode 0)
 * Implement every prototype from SPI_interface.h.
 */

#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "SPI_private.h"
#include "GPIO_interface.h"
#include "UART_interface.h"

/*
 * SPI_InitMaster
 * 1. Reject prescaler > SPI_PRESC_128.
 * 2. SS / MOSI / SCK = output, MISO = input. Drive SS HIGH (idle).
 * 3. SPCR = SPE | MSTR | Copy_u8Prescaler.  (mode 0, MSB first)
 * 4. 8 MHz / 16 = 500 kHz SPI clock with SPI_PRESC_16.
 */
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler)
{
    if (Copy_u8Prescaler > SPI_PRESC_128)
        return E_NOK;

    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_OUTPUT); /* SS */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN5, GPIO_OUTPUT); /* MOSI */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN6, GPIO_INPUT);  /* MISO */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN7, GPIO_OUTPUT); /* SCK */

    GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_HIGH); /* SS HIGH (idle) */

    SPCR = (1 << SPE) | (1 << MSTR) | Copy_u8Prescaler;
    SPSR &= ~(1 << SPI2X);
    return E_OK;
}

/*
 * SPI_InitSlave
 * 1. MISO = output. MOSI, SCK, SS = input.
 * 2. SPCR = SPE only (MSTR = 0).
 */
STD_ReturnType SPI_InitSlave(void)
{
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_INPUT);  /* SS */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN5, GPIO_INPUT);  /* MOSI */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN6, GPIO_OUTPUT); /* MISO */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN7, GPIO_INPUT);  /* SCK */

    SPCR = (1 << SPE);
    return E_OK;
}

/*
 * SPI_Transceive
 * 1. Reject a NULL receive pointer.
 * 2. SPDR = Copy_u8Sent;          // starts the shift in master mode
 * 3. while (SPIF == 0) ;
 * 4. *Copy_pu8Received = SPDR;    // also clears SPIF
 */
STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received)
{
    if (Copy_pu8Received == NULL)
        return E_NOK;

    SPDR = Copy_u8Sent;

    while (!READ_BIT(SPSR, SPIF))
        ;

    *Copy_pu8Received = SPDR;
    return E_OK;
}

/*
 * SPI_SelectSlave
 * 1. GPIO_SetPinDirection(port, pin, GPIO_OUTPUT);
 * 2. GPIO_SetPinValue(port, pin, GPIO_LOW);
 *
 * SPI_ReleaseSlave
 * 1. GPIO_SetPinValue(port, pin, GPIO_HIGH);
 */
STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    return GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_LOW);
}

STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    return GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_HIGH);
}
