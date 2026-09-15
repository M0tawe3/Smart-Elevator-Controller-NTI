/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — TIMER.c  (ATmega32 Timer0 + Timer1, F_CPU = 8 MHz)
 * Implement every prototype from TIMER_interface.h.
 *
 * Rules for this file:
 *   - The application only ever sees what TIMER_interface.h declares.
 *   - Anything only this file needs is static, so no other .c can reach it.
 *   - Register names and bit numbers come from TIMER_private.h. Fill that in
 *     first, or nothing here will compile.
 *
 * Numbers you will need, all at 8 MHz:
 *   prescaler 64 -> 1 tick = 8 us      prescaler 8 -> 1 tick = 1 us
 *   A flag in TIFR is cleared by writing 1 to it, not 0.
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "TIMER_interface.h"
#include "TIMER_private.h"
#include <avr/interrupt.h>

/*==================================================================
 *  Local helpers — static, used only inside TIMER.c
 *==================================================================*/

/*
 * TIMER_WaitFlag
 * 1. Sit in an empty while loop until the bit Copy_u8BitMask is set in the
 *    register Copy_pu8Register (that register is TIFR).
 * 2. Clear the flag by writing 1 to that bit, so the next period starts clean.
 * 3. Both delay functions call this, which is the whole reason it exists —
 *    the wait-then-clear pattern is written once and cannot drift apart.
 */
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);

/*
 * TIMER_DutyToCompare
 * 1. Turn a 0..100 percent into a compare value: (Top + 1) * percent / 100.
 * 2. Do the multiply in uint32. Timer1 can reach 20000 * 100 = 2,000,000,
 *    which overflows uint16 long before the divide happens.
 * 3. Return the result; the caller writes it to OCR0 or OCR1A.
 */
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);

/*==================================================================
 *  Timer0 — 8-bit
 *==================================================================*/

STD_ReturnType TIMER0_Init(void)
{
    TIMER0_REG_TCCR0 = (1 << 3) | (1 << 2) | (1 << 0); // CTC, prescaler 1024
    TIMER0_REG_OCR0 = 77U;                               // approximately 10 ms at 8 MHz
    TIMER0_REG_TCNT0 = 0U;
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    TIFR_REG |= (1 << OCF0);                 // Clear stale flag
    TIMER0_REG_TCCR0 = (TIMER0_REG_TCCR0 & (uint8)~0x07U) | (1 << 2) | (1 << 0); // prescaler 1024
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&TIFR_REG, (1 << OCF0)); // Wait for OCF0 flag
    }
    TIMER0_REG_TCCR0 &= ~((1 << 2) | (1 << 1) | (1 << 0)); // Stop clock
    return E_OK;
}

STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds)
{
    for (uint16 i = 0; i < Copy_u16Seconds; i++)
    {
        TIMER0_DelayMS(1000);
    }
    return E_OK;
}

STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
        return E_NOK;

    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN3, GPIO_OUTPUT); // Make PB3 output
    TIMER0_REG_TCCR0 |= (1 << 3) | (1 << 6);                  // Fast PWM
    TIMER0_REG_TCCR0 |= (1 << 5);                             // Non-inverting output
    TIMER0_REG_OCR0 = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    TIMER0_REG_TCCR0 |= (1 << 1) | (1 << 0); // Start clock with prescaler 64
    return E_OK;
}

STD_ReturnType TIMER0_Stop(void)
{
    TIMER0_REG_TCCR0 &= ~((1 << 2) | (1 << 1) | (1 << 0)); // Stop clock
    TIMER0_REG_TCCR0 &= ~((1 << 5) | (1 << 4));            // Clear COM01:COM00
    return E_OK;
}

/*==================================================================
 *  Timer1 — 16-bit
 *==================================================================*/

STD_ReturnType TIMER1_Init(void)
{
    TIMER1_REG_TCCR1A = 0;        // WGM11 = 0 , WGM10 = 0
    TIMER1_REG_TCCR1B = (1 << 3); // WGM13 = 0 , WGM12 = 1
    TIMER1_REG_OCR1A = 999;       // 1 ms at prescaler 8
    TIMER1_REG_TCNT1 = 0;         // Clear counter
    return E_OK;
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{
    TIFR_REG = (1 << OCF1A);
    TIMER1_REG_TCCR1B = (TIMER1_REG_TCCR1B & ~((1 << 2) | (1 << 1) | (1 << 0))) | (1 << 1); // Start clock with prescaler 8
    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&TIFR_REG, (1 << OCF1A)); // Wait for OCF1A flag
    }
    TIMER1_REG_TCCR1B &= ~((1 << 2) | (1 << 1) | (1 << 0)); // Stop clock
    return E_OK;
}

STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100 || Copy_u16FrequencyHz < 16 || Copy_u16FrequencyHz > 20000)
        return E_NOK;

    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN5, GPIO_OUTPUT);                    // Make PD5 output
    TIMER1_REG_TCCR1A |= (1 << 7);                                               // Non-inverting
    TIMER1_REG_TCCR1A |= (1 << 1);                                               // WGM11
    TIMER1_REG_TCCR1B |= (1 << 4) | (1 << 3);                                    // WGM13 = 1 , WGM12 = 1
    TIMER1_REG_ICR1 = (uint16)((F_CPU / Copy_u16FrequencyHz) - 1UL);              // prescaler 1
    TIMER1_REG_OCR1A = TIMER_DutyToCompare(TIMER1_REG_ICR1, Copy_u8DutyPercent); // Set compare
    TIMER1_REG_TCCR1B = (TIMER1_REG_TCCR1B & (uint8)~0x07U) | (1 << 0);           // Start clock, prescaler 1
    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    TIMER1_REG_TCCR1B &= ~((1 << 2) | (1 << 1) | (1 << 0)); // Stop clock
    TIMER1_REG_TCCR1A &= ~((1 << 7) | (1 << 6));            // Clear COM1A1:COM1A0
    return E_OK;
}

STD_ReturnType TIMER2_Init(void)
{
    TIMER2_REG_TCCR2 = 0U;
    TIMER2_REG_TCNT2 = 0U;
    TIMER2_REG_OCR2 = 0U;
    return E_OK;
}

STD_ReturnType TIMER2_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }

    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN7, GPIO_OUTPUT);
    TIMER2_REG_TCCR2 = (1U << WGM20) |
                       (1U << WGM21) |
                       (1U << COM21) |
                       (1U << CS22); /* Fast PWM, non-inverting, /64 */
    TIMER2_REG_OCR2 = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    return E_OK;
}

STD_ReturnType TIMER2_Stop(void)
{
    TIMER2_REG_TCCR2 &= (uint8)~((1U << CS22) | (1U << CS21) | (1U << CS20));
    TIMER2_REG_TCCR2 &= (uint8)~((1U << COM21) | (1U << COM20));
    TIMER2_REG_OCR2 = 0U;
    return E_OK;
}

/*==================================================================
 *  Local helper bodies
 *==================================================================*/

static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask)
{
    while ((*Copy_pu8Register & Copy_u8BitMask) == 0)
    {
    } // spin until set
    *Copy_pu8Register = Copy_u8BitMask; // clear the flag
}

static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent)
{
    uint32 temp = ((uint32)Copy_u16Top) * Copy_u8DutyPercent;
    return (uint16)(temp / 100);
}

// ISR(TIMER0_COMP_vect)
// {
//     systemTicks10ms = 1U;
// }
