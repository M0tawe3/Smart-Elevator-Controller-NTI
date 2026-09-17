#include <assert.h>
#include <stdio.h>

#define GPIO_SetPinDirection fake_GPIO_SetPinDirection
#define GPIO_SetPinValue fake_GPIO_SetPinValue
#define TIMER1_PWM fake_TIMER1_PWM
#include "../HAL/Hoist/Hoist.c"
#undef GPIO_SetPinDirection
#undef GPIO_SetPinValue
#undef TIMER1_PWM

static uint8 g_duty = 0U;
static uint8 g_up = GPIO_LOW;
static uint8 g_down = GPIO_LOW;

STD_ReturnType fake_GPIO_SetPinDirection(uint8 port, uint8 pin, uint8 direction)
{
    (void)port;
    (void)pin;
    (void)direction;
    return E_OK;
}

STD_ReturnType fake_GPIO_SetPinValue(uint8 port, uint8 pin, uint8 value)
{
    (void)port;
    if (pin == GPIO_PIN0) {
        g_up = value;
    } else if (pin == GPIO_PIN1) {
        g_down = value;
    }
    return E_OK;
}

STD_ReturnType fake_TIMER1_PWM(uint16 frequency, uint8 duty)
{
    (void)frequency;
    g_duty = duty;
    return E_OK;
}

static void test_door_interlock(void)
{
    HST_Init();
    HST_SetDir(HST_DIR_UP);
    HST_SetDuty(60U, 100U);
    assert(g_duty == 0U);
    assert(g_up == GPIO_LOW);
    assert(g_down == GPIO_LOW);
}

static void test_direction_and_clamping(void)
{
    HST_SetDir(HST_DIR_UP);
    assert(g_up == GPIO_HIGH);
    assert(g_down == GPIO_LOW);

    HST_SetDuty(150U, 0U);
    assert(g_duty == 100U);

    HST_SetDir(HST_DIR_DOWN);
    assert(g_up == GPIO_LOW);
    assert(g_down == GPIO_HIGH);
}

int main(void)
{
    test_door_interlock();
    test_direction_and_clamping();
    puts("hoist_test: PASS");
    return 0;
}