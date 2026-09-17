#ifndef _HC595_H
#define _HC595_H

#include "STD_TYPES.h"

#define HC595_LATCH_PORT GPIO_PORTC
#define HC595_LATCH_PIN GPIO_PIN3

void SEG_Show(uint8 floor, Dir_t dir);

#endif /* _HC595_H */