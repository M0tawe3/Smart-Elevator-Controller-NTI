#ifndef CARFSM_H_
#define CARFSM_H_

#include "STD_TYPES.h"

#define CAR_STATE_IDLE      CS_IDLE
#define CAR_STATE_MOVING    CS_MOVING
#define CAR_STATE_DOOR_OPEN CS_DOOR_OPEN
#define CAR_STATE_OVERLOAD  CS_OVERLOAD
#define CAR_STATE_FAULT     CS_FAULT

void CarFSM_Init(void);
void CarFSM_Update(uint8 overload, uint8 doorOpen, uint8 doorClosed, uint8 obstruction);
CarState_t CarFSM_GetState(void);

#endif /* CARFSM_H_ */
