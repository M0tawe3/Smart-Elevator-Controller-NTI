#ifndef MOTION_H_
#define MOTION_H_

#include "STD_TYPES.h"
#include "Hoist.h"

STD_ReturnType MOT_GoTo(uint8 targetFloor, uint16 currentCm);
void MOT_Stop(void);
uint8 MOT_IsActive(void);
uint8 MOT_AtTarget(uint16 currentCm);
void MOT_Step(CarData_t *car);
void MOT_RelevelCheck(CarData_t *car);

#endif /* MOTION_H_ */
