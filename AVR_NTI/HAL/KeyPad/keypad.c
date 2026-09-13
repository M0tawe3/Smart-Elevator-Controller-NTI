#include "keypad.h"

uint8 keypad_map[4][4] = {
    {1, 2, 3, 'A'},
    {4, 5, 6, 'B'},
    {7, 8, 9, 'C'},
    {'*', 0, '#', 'D'}};

STD_ReturnType keypad_init(uint8 port)
{
    // Set the entire port as input with pull-up resistors
    return GPIO_SetPortDirection(port, 0x0F);
}

STD_ReturnType keypad_get_keypressed(uint8 port, uint8 *value)
{
    if (value == NULL)
        return E_NOK; // Invalid pointer

    // Set the lower 4 bits as output (rows) and the upper 4 bits as input (columns)
    GPIO_SetPortDirection(port, 0x0F);

    for (uint8 row = 0; row < 4; row++)
    {
        // Set the current row low and others high
        GPIO_SetPortValue(port, ~(1 << row));

        for (uint8 col = 0; col < 4; col++)
        {
            uint8 pin_value;
            GPIO_GetPinValue(port, col + 4, &pin_value); // Read the column pin

            if (pin_value == GPIO_LOW) // Key is pressed
            {
                *value = keypad_map[row][col];
                return E_OK;
            }
        }
    }

    return E_NOK; // No key pressed
}