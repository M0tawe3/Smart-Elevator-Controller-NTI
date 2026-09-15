#ifndef CARFSM_H_
#define CARFSM_H_

#include "STD_TYPES.h"

typedef enum {
    CAR_STATE_IDLE = 0U,
    CAR_STATE_MOVING,
    CAR_STATE_DOOR_OPEN,
    CAR_STATE_OVERLOAD,
    CAR_STATE_FAULT
} CarState_t;

void CarFSM_Init(void);
void CarFSM_Update(uint8 overload, uint8 doorOpen, uint8 doorClosed, uint8 obstruction);
CarState_t CarFSM_GetState(void);

#endif /* CARFSM_H_ */
