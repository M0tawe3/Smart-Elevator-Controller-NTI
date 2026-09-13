#ifndef KEYPAD_H_
#define KEYPAD_H_

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include <stddef.h>

STD_ReturnType keypad_init(uint8 port);

STD_ReturnType keypad_get_keypressed(uint8 port, uint8 *value);

#endif // KEYPAD_H_