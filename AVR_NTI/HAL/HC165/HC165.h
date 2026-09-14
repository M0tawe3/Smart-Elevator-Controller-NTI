#ifndef _HC165_H_
#define _HC165_H_

#include "STD_TYPES.h"

// Function prototypes for HC165
STD_ReturnType HC165_Init(uint8 Copy_u8ParallelLoadPort, uint8 Copy_u8ParallelLoadPin);
uint8 HC165_Read(uint8 Copy_u8ParallelLoadPort, uint8 Copy_u8ParallelLoadPin);

#endif /* _HC165_H_ */