#include "lcd.h"
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