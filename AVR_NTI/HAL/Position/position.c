#include "position.h"
#include "ADC_interface.h"

#define POSITION_LEVEL_TOLERANCE_CM 3U

uint16 POS_cm(void)
{
    uint16 reading;

    if (ADC_ReadChannel(ADC_CHANNEL_0, &reading) != E_OK)
    {
        return 0U;
    }

    reading = ((uint32)reading * 1000) / 1023;
    return reading;
}

uint8 POS_nearestFloor(uint16 cm)
{
    if (cm < 150U)
    {
        return 0U;
    }
    else if (cm < 450U)
    {
        return 1U;
    }
    else if (cm < 750U)
    {
        return 2U;
    }
    else
    {
        return 3U;
    }
}

uint8 POS_InLevelZone(uint16 cm)
{
    uint8 nearestFloor = POS_nearestFloor(cm);
    uint16 targetCm;
    uint16 distanceCm;

    switch (nearestFloor)
    {
        case 0U:
            targetCm = POSITION_FLOOR_0;
            break;

        case 1U:
            targetCm = POSITION_FLOOR_1;
            break;

        case 2U:
            targetCm = POSITION_FLOOR_2;
            break;

        default:
            targetCm = POSITION_FLOOR_3;
            break;
    }

    distanceCm = (cm >= targetCm) ? (cm - targetCm) : (targetCm - cm);
    return (distanceCm <= POSITION_LEVEL_TOLERANCE_CM) ? 1U : 0U;
}
