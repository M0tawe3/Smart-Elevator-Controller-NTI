#ifndef SAFETY_H_
#define SAFETY_H_

#include "STD_TYPES.h"

void SAF_Evaluate(CarData_t *car);
uint8_t SAF_Active(const CarData_t *car);

#endif /* SAFETY_H_ */