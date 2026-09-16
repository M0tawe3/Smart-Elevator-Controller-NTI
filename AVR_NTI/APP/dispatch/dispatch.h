#ifndef _DISPATCH_H_
#define _DISPATCH_H_

#include "STD_TYPES.h"

STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type);

STD_ReturnType DSP_ClearFloor(Calls_t *calls, uint8 floor);

Dir_t DSP_NextDirection(const Calls_t *calls, uint8 currentFloor, Dir_t currentDirection);

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction);

#endif