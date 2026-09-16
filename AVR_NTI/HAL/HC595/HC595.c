#include "HC595.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"

static const uint8 digits[4] = {0b00111111, 0b00000110, 0b01011011, 0b01001111};

void SEG_Show(uint8 floor, Dir_t dir)
{
    if(floor >= FLOOR_COUNT)
        return;

    uint8 dummy;

    /* Shift data into the register */
    SPI_Transceive(digits[floor], &dummy);

    /* Copy shift register to output register */
    GPIO_SetPinValue(HC595_LATCH_PORT, HC595_LATCH_PIN, GPIO_HIGH);
    GPIO_SetPinValue(HC595_LATCH_PORT, HC595_LATCH_PIN, GPIO_LOW);

    switch(dir){
        case DIR_DOWN:
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN5, GPIO_HIGH);
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN4, GPIO_LOW);
        break;
        case DIR_UP:
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN4, GPIO_HIGH);
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN5, GPIO_LOW);
        break;
        default:
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN4, GPIO_LOW);
        GPIO_SetPinValue(GPIO_PORTC, GPIO_PIN5, GPIO_LOW);
    }
}