#ifndef _LCD_H_
#define _LCD_H_

#include "STD_TYPES.h"

#define LCD_COLS 16U
#define LCD_ROWS 2U
#define LCD_CHARS (LCD_COLS * LCD_ROWS)

void LCD_Init(void);
STD_ReturnType LCD_WriteData(uint8 byte);
void LCD_Update(const char *frame);
void LCD_RefreshPartial(const char *newFrame);
void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive,DoorState_t door, uint8 faultBlinkOn);

#endif // _LCD_H_