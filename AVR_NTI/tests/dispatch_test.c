#include <assert.h>
#include <stdio.h>

#include "dispatch.h"

static void test_add_and_clear(void)
{
    Calls_t calls = {0};

    assert(DSP_AddCall(&calls, 2U, CALL_CAR) == E_OK);
    assert(DSP_AddCall(&calls, 3U, CALL_HALL_UP) == E_OK);
    assert((calls.carCall & (1U << 2U)) != 0U);
    assert((calls.hallUp & (1U << 3U)) != 0U);

    assert(DSP_ClearFloor(&calls, 2U) == E_OK);
    assert((calls.carCall & (1U << 2U)) == 0U);
}

static void test_should_stop_in_direction(void)
{
    Calls_t calls = {0};

    assert(DSP_AddCall(&calls, 1U, CALL_HALL_UP) == E_OK);
    assert(DSP_ShouldStop(&calls, 1U, DIR_UP) == E_OK);
    assert(DSP_ShouldStop(&calls, 1U, DIR_DOWN) == E_OK);

    Calls_t calls2 = {0};
    assert(DSP_AddCall(&calls2, 3U, CALL_HALL_DOWN) == E_OK);
    assert(DSP_ShouldStop(&calls2, 3U, DIR_DOWN) == E_OK);
}

static void test_opposite_direction_last_call(void)
{
    Calls_t calls = {0};

    /* Current direction is up, but the only remaining call is a hall-down at floor 1.
       The LOOK rule says this must still be served because it is the last call ahead.
       No floor below it remains to serve first. */
    assert(DSP_AddCall(&calls, 1U, CALL_HALL_DOWN) == E_OK);
    assert(DSP_ShouldStop(&calls, 1U, DIR_UP) == E_OK);

    /* Upward travel with a call above should continue upward, not reverse. */
    Calls_t calls2 = {0};
    assert(DSP_AddCall(&calls2, 2U, CALL_HALL_UP) == E_OK);
    assert(DSP_NextDirection(&calls2, 0U, DIR_UP) == DIR_UP);
}

int main(void)
{
    test_add_and_clear();
    test_should_stop_in_direction();
    test_opposite_direction_last_call();

    puts("dispatch_test: PASS");
    return 0;
}
