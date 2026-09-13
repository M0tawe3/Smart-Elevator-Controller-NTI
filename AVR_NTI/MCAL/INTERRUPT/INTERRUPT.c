/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — INTERRUPT.c  (ATmega32 EXTI + global I-bit)
 * Implement every prototype from INTERRUPT_interface.h.
 */

#include "STD_TYPES.h"
#include "INTERRUPT_interface.h"
#include "INTERRUPT_private.h"
#include <avr/interrupt.h>

static void (*EXTI_Callbacks[3])(void) = {NULL, NULL, NULL};

STD_ReturnType INTERRUPT_EnableGlobal(void)
{
    SET_BIT(SREG_REG, I);
    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void)
{
    CLEAR_BIT(SREG_REG, I);
    return E_OK;
}

STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        MCUCR_REG |= (Copy_u8Sense & 0x03);
        return E_OK;
    case EXTI_INT1:
        MCUCR_REG |= ((Copy_u8Sense & 0x03) << 2);
        return E_OK;
    case EXTI_INT2:
        if (Copy_u8Sense == EXTI_FALLING_EDGE)
        {
            CLEAR_BIT(MCUCSR_REG, ISC2);
            return E_OK;
        }
        else if (Copy_u8Sense == EXTI_RISING_EDGE)
        {
            SET_BIT(MCUCSR_REG, ISC2);
            return E_OK;
        }
        else
            return E_NOK; // Invalid sense for INT2

    default:
        return E_NOK; // Invalid interrupt source
    }
}

STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        SET_BIT(GIFR_REG, INTF0);
        return E_OK;
    case EXTI_INT1:
        SET_BIT(GIFR_REG, INTF1);
        return E_OK;
    case EXTI_INT2:
        SET_BIT(GIFR_REG, INTF2);
        return E_OK;
    default:
        return E_NOK; // Invalid interrupt source
    }
}

STD_ReturnType EXTI_Enable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        SET_BIT(GIFR_REG, INTF0);
        SET_BIT(GICR_REG, INT0);
        return E_OK;
    case EXTI_INT1:
        SET_BIT(GIFR_REG, INTF1);
        SET_BIT(GICR_REG, INT1);
        return E_OK;
    case EXTI_INT2:
        SET_BIT(GIFR_REG, INTF2);
        SET_BIT(GICR_REG, INT2);
        return E_OK;
    default:
        return E_NOK; // Invalid interrupt source
    }
}

STD_ReturnType EXTI_Disable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        CLEAR_BIT(GICR_REG, INT0);
        return E_OK;
    case EXTI_INT1:
        CLEAR_BIT(GICR_REG, INT1);
        return E_OK;
    case EXTI_INT2:
        CLEAR_BIT(GICR_REG, INT2);
        return E_OK;
    default:
        return E_NOK; // Invalid interrupt source
    }
}

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void))
{
    if (Copy_u8Int < 3)
    {
        EXTI_Callbacks[Copy_u8Int] = Copy_pfCallback;
        return E_OK;
    }
    else
        return E_NOK; // Invalid interrupt source
}

ISR(INT0_vect)
{
    if (EXTI_Callbacks[EXTI_INT0] != NULL)
    {
        EXTI_Callbacks[EXTI_INT0]();
    }
}

ISR(INT1_vect)
{
    if (EXTI_Callbacks[EXTI_INT1] != NULL)
    {
        EXTI_Callbacks[EXTI_INT1]();
    }
}

ISR(INT2_vect)
{
    if (EXTI_Callbacks[EXTI_INT2] != NULL)
    {
        EXTI_Callbacks[EXTI_INT2]();
    }
}