/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — GPIO.c  (ATmega32)
 * Implement every prototype from GPIO_interface.h. Return E_NOK on bad arguments.
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "GPIO_private.h"
#include <stddef.h>

STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > GPIO_PORTD || Copy_u8Pin > GPIO_PIN7)
    {
        return E_NOK;
    }

    volatile uint8 *port_reg;
    volatile uint8 *ddr_reg;

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        port_reg = &GPIO_PORTA_REG;
        ddr_reg = &GPIO_DDRA_REG;
        break;

    case GPIO_PORTB:
        port_reg = &GPIO_PORTB_REG;
        ddr_reg = &GPIO_DDRB_REG;
        break;

    case GPIO_PORTC:
        port_reg = &GPIO_PORTC_REG;
        ddr_reg = &GPIO_DDRC_REG;
        break;

    case GPIO_PORTD:
        port_reg = &GPIO_PORTD_REG;
        ddr_reg = &GPIO_DDRD_REG;
        break;

    default:
        return E_NOK; // Invalid port
    }

    switch (Copy_u8Direction)
    {
    case GPIO_INPUT:
        // Clear DDRx bit, clear PORTx bit
        GPIO_PIN_CLEAR(*ddr_reg, Copy_u8Pin);
        GPIO_PIN_CLEAR(*port_reg, Copy_u8Pin);
        break;

    case GPIO_OUTPUT:
        // Set DDRx bit
        GPIO_PIN_SET(*ddr_reg, Copy_u8Pin);
        GPIO_PIN_CLEAR(*port_reg, Copy_u8Pin); // pin starts as low for output
        break;

    case GPIO_INPUT_PULLUP:
        // Clear DDRx bit, set PORTx bit
        GPIO_PIN_CLEAR(*ddr_reg, Copy_u8Pin);
        GPIO_PIN_SET(*port_reg, Copy_u8Pin);
        break;
    default:
        return E_NOK; // Invalid direction
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value)
{
    if (Copy_u8Port > GPIO_PORTD || Copy_u8Pin > GPIO_PIN7)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        if (Copy_u8Value == GPIO_HIGH)
        {
            GPIO_PIN_SET(GPIO_PORTA_REG, Copy_u8Pin);
        }
        else if (Copy_u8Value == GPIO_LOW)
        {
            GPIO_PIN_CLEAR(GPIO_PORTA_REG, Copy_u8Pin);
        }
        else
        {
            return E_NOK; // Invalid value
        }
        break;

    case GPIO_PORTB:
        if (Copy_u8Value == GPIO_HIGH)
        {
            GPIO_PIN_SET(GPIO_PORTB_REG, Copy_u8Pin);
        }
        else if (Copy_u8Value == GPIO_LOW)
        {
            GPIO_PIN_CLEAR(GPIO_PORTB_REG, Copy_u8Pin);
        }
        else
        {
            return E_NOK; // Invalid value
        }
        break;

    case GPIO_PORTC:
        if (Copy_u8Value == GPIO_HIGH)
        {
            GPIO_PIN_SET(GPIO_PORTC_REG, Copy_u8Pin);
        }
        else if (Copy_u8Value == GPIO_LOW)
        {
            GPIO_PIN_CLEAR(GPIO_PORTC_REG, Copy_u8Pin);
        }
        else
        {
            return E_NOK; // Invalid value
        }
        break;

    case GPIO_PORTD:
        if (Copy_u8Value == GPIO_HIGH)
        {
            GPIO_PIN_SET(GPIO_PORTD_REG, Copy_u8Pin);
        }
        else if (Copy_u8Value == GPIO_LOW)
        {
            GPIO_PIN_CLEAR(GPIO_PORTD_REG, Copy_u8Pin);
        }
        else
        {
            return E_NOK; // Invalid value
        }
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}

STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > GPIO_PORTD || Copy_u8Pin > GPIO_PIN7 || Copy_pu8Value == NULL)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        *Copy_pu8Value = GPIO_PIN_READ(GPIO_PINA_REG, Copy_u8Pin);
        break;

    case GPIO_PORTB:
        *Copy_pu8Value = GPIO_PIN_READ(GPIO_PINB_REG, Copy_u8Pin);
        break;

    case GPIO_PORTC:
        *Copy_pu8Value = GPIO_PIN_READ(GPIO_PINC_REG, Copy_u8Pin);
        break;

    case GPIO_PORTD:
        *Copy_pu8Value = GPIO_PIN_READ(GPIO_PIND_REG, Copy_u8Pin);
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}

STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    if (Copy_u8Port > GPIO_PORTD || Copy_u8Pin > GPIO_PIN7)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        GPIO_PIN_TOGGLE(GPIO_PORTA_REG, Copy_u8Pin);
        break;

    case GPIO_PORTB:
        GPIO_PIN_TOGGLE(GPIO_PORTB_REG, Copy_u8Pin);
        break;

    case GPIO_PORTC:
        GPIO_PIN_TOGGLE(GPIO_PORTC_REG, Copy_u8Pin);
        break;

    case GPIO_PORTD:
        GPIO_PIN_TOGGLE(GPIO_PORTD_REG, Copy_u8Pin);
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > GPIO_PORTD)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        GPIO_DDRA_REG = Copy_u8Direction;
        break;

    case GPIO_PORTB:
        GPIO_DDRB_REG = Copy_u8Direction;
        break;

    case GPIO_PORTC:
        GPIO_DDRC_REG = Copy_u8Direction;
        break;

    case GPIO_PORTD:
        GPIO_DDRD_REG = Copy_u8Direction;
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}

STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value)
{
    if (Copy_u8Port > GPIO_PORTD)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        GPIO_PORTA_REG = Copy_u8Value;
        break;

    case GPIO_PORTB:
        GPIO_PORTB_REG = Copy_u8Value;
        break;

    case GPIO_PORTC:
        GPIO_PORTC_REG = Copy_u8Value;
        break;

    case GPIO_PORTD:
        GPIO_PORTD_REG = Copy_u8Value;
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}

STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > GPIO_PORTD || Copy_pu8Value == NULL)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case GPIO_PORTA:
        *Copy_pu8Value = GPIO_PINA_REG;
        break;

    case GPIO_PORTB:
        *Copy_pu8Value = GPIO_PINB_REG;
        break;

    case GPIO_PORTC:
        *Copy_pu8Value = GPIO_PINC_REG;
        break;

    case GPIO_PORTD:
        *Copy_pu8Value = GPIO_PIND_REG;
        break;

    default:
        return E_NOK; // Invalid port
    }

    return E_OK;
}