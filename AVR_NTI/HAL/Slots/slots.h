#ifndef SLOTS_H_
#define SLOTS_H_

#include "STD_TYPES.h"
#include "GPIO_interface.h"

/*
 * Sensor pins used by the project are expected to be on PC2..PC7.
 * The exact polarity (active HIGH / active LOW) must still be verified on the
 * hardware, because the documentation and intended wiring are not fully trusted
 * until checked on the real board.
 */

#define SLOT_SENSOR_PORT GPIO_PORTC
#define SLOT_SENSOR_START_PIN 2u
#define SLOT_SENSOR_END_PIN   7u
#define SLOT_SENSOR_MASK      0xFCu

STD_ReturnType slots_init(void);
STD_ReturnType slots_read_raw(uint8 *Copy_pu8Mask);
STD_ReturnType slots_read_active_low(uint8 *Copy_pu8Mask);

#endif /* SLOTS_H_ */
