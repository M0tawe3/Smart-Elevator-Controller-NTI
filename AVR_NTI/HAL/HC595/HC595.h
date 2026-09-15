#ifndef _HC595_H
#define _HC595_H

#include "STD_TYPES.h"

#define HC595_LATCH_PORT GPIO_PORTC
#define HC595_LATCH_PIN GPIO_PIN3

void HC595_Write(uint8 data);

#endif /* _HC595_H */