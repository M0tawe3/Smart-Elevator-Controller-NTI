#ifndef DOORFSM_H_
#define DOORFSM_H_

#include "STD_TYPES.h"

typedef enum {
    DOOR_STATE_CLOSED = 0U,
    DOOR_STATE_OPENING,
    DOOR_STATE_OPEN,
    DOOR_STATE_CLOSING,
    DOOR_STATE_JAMMED
} DoorState_t;

void DoorFSM_Init(void);
void DoorFSM_Open(void);
void DoorFSM_Close(void);
void DoorFSM_Update(uint8 obstructionDetected);
DoorState_t DoorFSM_GetState(void);

#endif /* DOORFSM_H_ */
