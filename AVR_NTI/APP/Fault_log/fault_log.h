#ifndef FAULT_LOG_H_
#define FAULT_LOG_H_

#include "STD_TYPES.h"

#define FAULT_LOG_DEPTH 16U

void FL_Init(void);
void FL_Clear(void);
void FL_AddFault(uint8 faultCode);
uint8 FL_GetCount(void);
uint8 FL_ReadNewest(void);
uint8 FL_ReadOldest(void);
uint8 FL_ReadAt(uint8 index);

#endif //FAULT_LOG_H_