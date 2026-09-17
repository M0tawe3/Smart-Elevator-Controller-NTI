#include <assert.h>
#include <stdio.h>

#define ADC_Init fake_ADC_Init
#define ADC_ReadChannel fake_ADC_ReadChannel
#include "../HAL/Load/Load.c"
#undef ADC_Init
#undef ADC_ReadChannel

static STD_ReturnType g_adcStatus = E_OK;
static uint16 g_adcValue = 0U;

STD_ReturnType fake_ADC_Init(uint8 ref, uint8 prescaler)
{
    (void)ref;
    (void)prescaler;
    return E_OK;
}

STD_ReturnType fake_ADC_ReadChannel(uint8 channel, uint16 *reading)
{
    (void)channel;
    if (g_adcStatus != E_OK)
    {
        return g_adcStatus;
    }

    *reading = g_adcValue;
    return E_OK;
}

static void test_overload_hysteresis(void)
{
    LOAD_Init();

    g_adcValue = 930U;
    assert(LOAD_IsOverloaded() == 1U);

    g_adcValue = 880U;
    assert(LOAD_IsOverloaded() == 1U);

    g_adcValue = 860U;
    assert(LOAD_IsOverloaded() == 0U);
}

static void test_adc_failure_is_fail_safe(void)
{
    LOAD_Init();
    g_adcValue = 930U;
    assert(LOAD_IsOverloaded() == 1U);

    g_adcStatus = E_NOK;
    assert(LOAD_IsOverloaded() == 1U);
    g_adcStatus = E_OK;
}

int main(void)
{
    test_overload_hysteresis();
    test_adc_failure_is_fail_safe();
    puts("load_test: PASS");
    return 0;
}