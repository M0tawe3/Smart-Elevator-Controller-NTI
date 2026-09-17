#ifndef DOORFSM_H_
#define DOORFSM_H_

#include "STD_TYPES.h"

void DoorFSM_Init(void);
void DoorFSM_Open(void);
void DoorFSM_Close(void);
void DoorFSM_Update(uint8 obstructionDetected);
void DoorFSM_UpdatePosition(uint8 obstructionDetected, uint8 doorPct);
DoorState_t DoorFSM_GetState(void);

#endif /* DOORFSM_H_ */
