#ifndef LOAD_H_
#define LOAD_H_

#include "STD_TYPES.h"

#define LOAD_LIMIT_KG 900U
#define LOAD_CLEAR_KG 850U

void LOAD_Init(void);
uint16 LOAD_ReadKg(void);
uint8 LOAD_IsOverloaded(void);

#endif /* LOAD_H_ */
