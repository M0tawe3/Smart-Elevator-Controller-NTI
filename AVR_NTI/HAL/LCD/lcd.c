#include "lcd.h"
#include <string.h>
#include <stdio.h>
#include "I2C_interface.h"
#include "TIMER_interface.h"
#include "GPIO_interface.h"

#define LCD_ADDRESS        0x3EU

#define LCD_CLEARDISPLAY   0x01U
#define LCD_RETURNHOME     0x02U
#define LCD_ENTRYMODESET   0x04U
#define LCD_DISPLAYCONTROL 0x08U
#define LCD_FUNCTIONSET    0x20U

#define LCD_ENTRYLEFT      0x02U
#define LCD_DISPLAYON      0x04U
#define LCD_8BITMODE       0x10U
#define LCD_2LINE          0x08U  

void Debug_Fail(){
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN7, GPIO_HIGH);
}

static STD_ReturnType LCD_Command(uint8 command)
{
    STD_ReturnType result = I2C_SendStart();
    if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(LCD_ADDRESS);
    if (result == E_OK) result = I2C_SendByte(0x00U);      /* control byte: command */
    if (result == E_OK) result = I2C_SendByte(command);
    I2C_SendStop();
    return result;
}

void LCD_Init(){
    if (LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE) != E_OK) Debug_Fail();
    //TIMER0_DelayMS(5U);
    if (LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE) != E_OK) Debug_Fail();
    //TIMER0_DelayMS(1U);

    if (LCD_Command(LCD_DISPLAYCONTROL | LCD_DISPLAYON) != E_OK) Debug_Fail();  /* 0x0C */
    if (LCD_Command(LCD_CLEARDISPLAY) != E_OK) Debug_Fail();                   /* 0x01 */
    //TIMER0_DelayMS(2U);
    if (LCD_Command(LCD_ENTRYMODESET | LCD_ENTRYLEFT) != E_OK) Debug_Fail();   /* 0x06 */
    if (LCD_Command(LCD_RETURNHOME) != E_OK)      Debug_Fail();         /* 0x02 */
    //TIMER0_DelayMS(2U);
}

STD_ReturnType LCD_WriteData(uint8 data)
{
    STD_ReturnType result = I2C_SendStart();
    if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(LCD_ADDRESS);
    if (result == E_OK) result = I2C_SendByte(0x40U);      /* control byte: data */
    if (result == E_OK) result = I2C_SendByte(data);
    I2C_SendStop();
    return result;
}

void LCD_Update(uint8 floor, Dir_t dir, uint16 load){
    LCD_WriteData('F');
    TIMER0_DelayMS(1);
    LCD_WriteData('L');
    TIMER0_DelayMS(1);
    LCD_WriteData(floor+48);
    TIMER0_DelayMS(1);
    LCD_WriteData(' ');
    TIMER0_DelayMS(1);
    switch(dir){
        case DIR_DOWN:
        LCD_WriteData('v');
        break;
        case DIR_UP:
        LCD_WriteData('^');
        break;
        default:
        LCD_WriteData('-');
    }
    TIMER0_DelayMS(1);

}

static char g_lcdBuf[LCD_CHARS];
static char g_lcdPrev[LCD_CHARS];

static void LCD_SetCursor(uint8 row, uint8 col)
{
    uint8 addr = (row == 0U) ? (uint8)col : (uint8)(0x40U + col);
    LCD_Command(0x80U | addr);
}

static void LCD_WriteCharAt(uint8 row, uint8 col, char ch)
{
    LCD_SetCursor(row, col);
    TIMER0_DelayMS(1U);
    LCD_WriteData((uint8)ch);
}

void LCD_RefreshPartial(const char *newFrame)
{
    for (uint8 i = 0; i < LCD_CHARS; i++)
    {
        if (g_lcdPrev[i] != newFrame[i])
        {
            uint8 row = (i < LCD_COLS) ? 0U : 1U;
            uint8 col = (i < LCD_COLS) ? i : (i - LCD_COLS);

            LCD_WriteCharAt(row, col, newFrame[i]);
            TIMER0_DelayMS(1U);
            g_lcdPrev[i] = newFrame[i];
        }
    }
}

void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive, DoorState_t door, CarState_t carstate, uint8 faultBlinkOn)
{
    char line1[LCD_COLS + 1U];
    char line2[LCD_COLS + 1U];
    char dirChar = '-';

    if (frame == NULL)
    {
        return;
    }

    switch (dir)
    {
        case DIR_UP:
            dirChar = '^';
            break;
        case DIR_DOWN:
            dirChar = 'v';
            break;
        default:
            dirChar = '-';
            break;
    }

    memset(line1, ' ', sizeof(line1));
    memset(line2, ' ', sizeof(line2));
    line1[LCD_COLS] = '\0';
    line2[LCD_COLS] = '\0';

    snprintf(line1, sizeof(line1), "FL%u %c P:%ucm", (unsigned int)floor, dirChar, (unsigned int)positionCm);

    switch(faultActive)
    {
        case FLT_ESTOP:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!EMERGENCY STOP");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;
    
        case FLT_OVERTRAVEL:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!OVERTRAVEL");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_OVERCURRENT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!OVERCURRENT");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_TRAVEL_TIMEOUT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!TRAVEL TIMEOUT");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_DOOR_TIMEOUT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!DOOR TIMEOUT");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_DOOR_JAM:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!DOOR JAM");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_POSITION_SENSOR:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!POSITION SENSOR");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        case FLT_LEVEL_FAIL:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!LEVEL FAIL");
        else
            snprintf(line2, sizeof(line2), "                ");
        break;

        default:
        snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
    }
    memset(frame, ' ', LCD_CHARS);
    memcpy(&frame[0], line1, LCD_COLS);
    memcpy(&frame[LCD_COLS], line2, LCD_COLS);

    LCD_RefreshPartial(frame);
}