#include "HC165.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"

#define HC165_LATCH_PORT  GPIO_PORTC
#define HC165_LATCH_PIN   GPIO_PIN2

#define SPI_PORT GPIO_PORTB
#define SPI_SS GPIO_PIN4

uint16 HC165_Read(void)
{
    uint16 buttons = 0;
    uint8 received;

    // Latch the parallel data into the shift register
    GPIO_SetPinValue(HC165_LATCH_PORT, HC165_LATCH_PIN, GPIO_LOW);
    GPIO_SetPinValue(HC165_LATCH_PORT, HC165_LATCH_PIN, GPIO_HIGH);

    SPI_SelectSlave(SPI_PORT, SPI_SS);
    for (uint8 i = 0; i < 2; i++)
    {
        SPI_Transceive(0xFF, &received);
        buttons = (buttons << 8) | received;
    }
    SPI_ReleaseSlave(SPI_PORT, SPI_SS);

    return buttons;
}