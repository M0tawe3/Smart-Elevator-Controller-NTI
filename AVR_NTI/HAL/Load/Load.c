#include "Load.h"
#include "ADC_interface.h"

static uint8 g_overloadLatched = 0U;

void LOAD_Init(void)
{
    ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
    g_overloadLatched = 0U;
}

uint16 LOAD_ReadKg(void)
{
    uint16 adcValue = 0U;
    uint16 loadKg = 0U;

    if (ADC_ReadChannel(ADC_CHANNEL_1, &adcValue) != E_OK)
    {
        return 0U;
    }

    if (adcValue > 1023U)
    {
        adcValue = 1023U;
    }

    loadKg = (uint16)(((uint32)adcValue * 1000UL) / 1023UL);
    return loadKg;
}

uint8 LOAD_IsOverloaded(void)
{
    uint16 loadKg = LOAD_ReadKg();

    if (loadKg >= LOAD_LIMIT_KG)
    {
        g_overloadLatched = 1U;
    }
    else if (loadKg <= LOAD_CLEAR_KG)
    {
        g_overloadLatched = 0U;
    }

    return g_overloadLatched;
}
