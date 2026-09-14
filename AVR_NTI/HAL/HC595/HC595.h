#ifndef _HC595_H
#define _HC595_H

#include "STD_TYPES.h"

#define HC595_LATCH_PORT GPIO_PORTB
#define HC595_LATCH_PIN GPIO_PIN4

uint8 HC595_Read(uint8 Copy_u8ParallelLoadPort, uint8 Copy_u8ParallelLoadPin);

#endif /* _HC595_H */