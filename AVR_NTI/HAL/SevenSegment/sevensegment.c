#include "sevensegment.h"

static const uint8 digits[10] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};

STD_ReturnType seven_segment_init(uint8 port)
{
    return GPIO_SetPortDirection(port, 0xFF); // Set all pins of the port as output
}

STD_ReturnType seven_segment_write(uint8 port, uint8 num)
{
    if (num > 9)
        return E_NOK;

    return GPIO_SetPortValue(port, digits[num]); // Write the value to the port
}