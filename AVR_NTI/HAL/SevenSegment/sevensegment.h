#ifndef SEVENSEGMENT_H_
#define SEVENSEGMENT_H_

#include "STD_TYPES.h"
#include "GPIO_interface.h"

STD_ReturnType seven_segment_init(uint8 port);

STD_ReturnType seven_segment_write(uint8 port, uint8 num);

#endif // SEVENSEGMENT_H_