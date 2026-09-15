#include "Load.h"
#include "ADC_interface.h"

void LOAD_Init(void)
{
    ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
}

uint16 LOAD_ReadKg(void)
{
    uint16 adcValue = 0U;
    uint16 loadKg = 0U;

    if (ADC_ReadChannel(ADC_CHANNEL_1, &adcValue) != E_OK)
    {
        return 0U;
    }

    loadKg = (uint16)(((uint32)adcValue * 1000UL) / 1023UL);
    return loadKg;
}

uint8 LOAD_IsOverloaded(void)
{
    return (LOAD_ReadKg() > LOAD_LIMIT_KG) ? 1U : 0U;
}
