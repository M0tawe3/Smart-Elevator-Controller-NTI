#include "position.h"
#include "ADC_interface.h"

STD_ReturnType get_position(uint8 *floor)
{
    uint16 reading;
    ADC_ReadChannel(ADC_CHANNEL_0, &reading);

    reading = ((uint32)reading * 1000) / 1023;

    if (reading < POSITION_FLOOR_1)
    {
        *floor = 0;
    }
    else if (reading < POSITION_FLOOR_2)
    {
        *floor = 1;
    }
    else if (reading < POSITION_FLOOR_3)
    {
        *floor = 2;
    }
    else
    {
        *floor = 3;
    }

    return E_OK;
}
