#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "GPIO_interface.h"
#include "I2C_interface.h"
#include "HAL/LCD/lcd.h"

// #define LCD_ADDRESS 0x3EU

// static STD_ReturnType LCD_TestCommand(uint8 command)
// {
//     STD_ReturnType result = I2C_SendStart();

//     if (result == E_OK)
//     {
//         result = I2C_SendSlaveAddressWithWrite(LCD_ADDRESS);
//     }
//     if (result == E_OK)
//     {
//         result = I2C_SendByte(0x00U);
//     }
//     if (result == E_OK)
//     {
//         result = I2C_SendByte(command);
//     }

//     I2C_SendStop();
//     return result;
// }

// static STD_ReturnType LCD_TestText(const char *text)
// {
//     STD_ReturnType result = I2C_SendStart();

//     if (result == E_OK)
//     {
//         result = I2C_SendSlaveAddressWithWrite(LCD_ADDRESS);
//     }
//     if (result == E_OK)
//     {
//         result = I2C_SendByte(0x40U);
//     }

//     while (result == E_OK && *text != '\0')
//     {
//         result = I2C_SendByte((uint8)*text);
//         text++;
//     }

//     I2C_SendStop();
//     return result;
// }
 /* use 0x00 here for a 1-line display */

// static STD_ReturnType LCD_Command(uint8 command)
// {
//     STD_ReturnType result = I2C_SendStart();
//     if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(LCD_ADDRESS);
//     if (result == E_OK) result = I2C_SendByte(0x00U);      /* control byte: command */
//     if (result == E_OK) result = I2C_SendByte(command);
//     I2C_SendStop();
//     return result;
// }



// static void LCD_Print(const char *text)
// {
//     while (*text != '\0')
//     {
//         LCD_Data((uint8)*text);
//         text++;
//     }
// }

// static void LCD_Init(void)
// {
//     TIMER0_DelayMS(50U);                              /* power-on settle */

//     LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE);
//     TIMER0_DelayMS(5U);
//     LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE);
//     TIMER0_DelayMS(1U);
//     LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE);
//     LCD_Command(LCD_FUNCTIONSET | LCD_8BITMODE | LCD_2LINE);

//     LCD_Command(LCD_DISPLAYCONTROL | LCD_DISPLAYON);   /* 0x0C */
//     LCD_Command(LCD_CLEARDISPLAY);                     /* 0x01 */
//     TIMER0_DelayMS(2U);
//     LCD_Command(LCD_ENTRYMODESET | LCD_ENTRYLEFT);     /* 0x06 */
//     LCD_Command(LCD_RETURNHOME);                       /* 0x02 */
//     TIMER0_DelayMS(2U);
// }


int main(void)
{
    TIMER0_Init();
    I2C_InitMaster(100000UL);
    TIMER0_DelayMS(10U);
    LCD_Init();
    TIMER0_DelayMS(10U);

    LCD_Update(2, DIR_NONE, 200);

    while (1) { }
}