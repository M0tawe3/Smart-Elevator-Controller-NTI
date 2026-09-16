#define F_CPU 8000000UL

#include <string.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "GPIO_interface.h"
#include "I2C_interface.h"
#include "HAL/LCD/lcd.h"

char frame[32];

int main(void)
{
    TIMER0_Init();
    I2C_InitMaster(100000UL);
    TIMER0_DelayMS(10U);
    LCD_Init();
    TIMER0_DelayMS(10U);

   

    while (1) {
        LCD_UpdateFrame(frame, 2, DIR_UP, 465, 209, FLT_NONE, DOOR_STATE_CLOSED, CS_ARRIVED, 0);
        LCD_RefreshPartial(frame);     
        TIMER0_DelayMS(150U);
        LCD_UpdateFrame(frame, 2, DIR_UP, 465, 209, FLT_NONE, DOOR_STATE_OPEN, CS_ARRIVED, 1);
        LCD_RefreshPartial(frame);    
        TIMER0_DelayMS(150U); 
    }
}