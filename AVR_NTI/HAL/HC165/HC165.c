#include "HC165.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"

#define HC165_LATCH_PORT  GPIO_PORTC
#define HC165_LATCH_PIN   GPIO_PIN2

#define SPI_PORT GPIO_PORTB
#define SPI_SS GPIO_PIN4
#define BUTTON_MASK 0xFFFFU

static uint16 stableButtons = 0U;
static uint16 candidateButtons = 0U;
static uint16 pressedEdges = 0U;
static uint8 candidateCount = 0U;

uint16 BTN_Scan(void)
{
    uint16 rawButtons = 0U;
    uint16 pressedButtons;
    uint8 received;

    // Latch the parallel data into the shift register
    GPIO_SetPinValue(HC165_LATCH_PORT, HC165_LATCH_PIN, GPIO_LOW);
    GPIO_SetPinValue(HC165_LATCH_PORT, HC165_LATCH_PIN, GPIO_HIGH);

    SPI_SelectSlave(SPI_PORT, SPI_SS);
    for (uint8 i = 0; i < 2; i++)
    {
        SPI_Transceive(0xFF, &received);
            rawButtons = (rawButtons << 8) | received;
    }
    SPI_ReleaseSlave(SPI_PORT, SPI_SS);

    /* Buttons are wired active-low: pressed means the shift-register bit is 0. */
    pressedButtons = (uint16)(~rawButtons) & BUTTON_MASK;
    if (pressedButtons == candidateButtons)
    {
        if (candidateCount < 2U)
        {
            candidateCount++;
        }
    }
    else
    {
        candidateButtons = pressedButtons;
        candidateCount = 1U;
    }

    if (candidateCount >= 2U && candidateButtons != stableButtons)
    {
        pressedEdges |= candidateButtons & (uint16)~stableButtons;
        stableButtons = candidateButtons;
    }

    return stableButtons;
}

uint8 BTN_Pressed(uint8 n)
{
    uint8 pressed;

    if (n >= 16U)
    {
        return 0U;
    }

    pressed = (uint8)((pressedEdges >> n) & 1U);
    pressedEdges &= (uint16)~((uint16)1U << n);
    return pressed;
}