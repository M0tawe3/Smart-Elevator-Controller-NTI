#ifndef _LCD_H_
#define _LCD_H_

#include "STD_TYPES.h"

void LCD_Init();

STD_ReturnType LCD_WriteData(uint8 byte);

void LCD_Update(uint8 floor, Dir_t dir, uint16 load);

#endif // _LCD_H_