#include "HC595.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"

void HC595_Write(uint8 data)
{
    uint8 dummy;

    /* Shift data into the register */
    SPI_Transceive(data, &dummy);

    /* Copy shift register to output register */
    GPIO_SetPinValue(HC595_LATCH_PORT, HC595_LATCH_PIN, GPIO_HIGH);
    GPIO_SetPinValue(HC595_LATCH_PORT, HC595_LATCH_PIN, GPIO_LOW);
}