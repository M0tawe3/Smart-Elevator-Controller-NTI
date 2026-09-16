#ifndef _POSITION_H_
#define _POSITION_H_

#include "STD_TYPES.h"

#define POSITION_FLOOR_0 0
#define POSITION_FLOOR_1 300
#define POSITION_FLOOR_2 600
#define POSITION_FLOOR_3 900

uint16 POS_cm(void);
uint8 POS_nearestFloor(uint16 cm);
uint8 POS_InLevelZone(uint16 cm);

#endif /* _POSITION_H_ */