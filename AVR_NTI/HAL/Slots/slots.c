#include "slots.h"
#include "GPIO_interface.h"

/*
 * slots_init
 * Configure PC2..PC7 as inputs with pull-ups. This keeps the pins from floating
 * and makes the reading stable when a slot sensor is not active.
 */
STD_ReturnType slots_init(void)
{
    for (uint8 i = SLOT_SENSOR_START_PIN; i <= SLOT_SENSOR_END_PIN; i++)
    {
        if (GPIO_SetPinDirection(SLOT_SENSOR_PORT, i, GPIO_INPUT_PULLUP) != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}

/*
 * slots_read_raw
 * Read the actual level on each sensor pin and pack the result into a bitmask.
 * Bit n corresponds to Port C pin n.
 * Example: bit 2 -> PC2, bit 7 -> PC7.
 */
STD_ReturnType slots_read_raw(uint8 *Copy_pu8Mask)
{
    if (Copy_pu8Mask == NULL)
    {
        return E_NOK;
    }

    uint8 mask = 0u;

    for (uint8 i = SLOT_SENSOR_START_PIN; i <= SLOT_SENSOR_END_PIN; i++)
    {
        uint8 level = 0u;

        if (GPIO_GetPinValue(SLOT_SENSOR_PORT, i, &level) != E_OK)
        {
            return E_NOK;
        }

        if (level == GPIO_LOW)
        {
            mask |= (uint8)(1u << i);
        }
    }

    *Copy_pu8Mask = mask;
    return E_OK;
}

/*
 * slots_read_active_low
 * The project description suggests these slot sensors may be active-low. This
 * helper preserves the raw hardware reading as a convenience for debugging and
 * for the logic layer to interpret later.
 */
STD_ReturnType slots_read_active_low(uint8 *Copy_pu8Mask)
{
    return slots_read_raw(Copy_pu8Mask);
}
