#ifndef CONSOL_H_
#define CONSOL_H_

#include "STD_TYPES.h"

#define CONS_CMD_MAX 32U

void CONS_Init(void);
void CONS_HandleByte(uint8 data);
void CONS_Task(void);
void CONS_ParseCommand(const uint8 *command);
void CONS_SendTelemetry(void);

#endif //CONSOL_H_