#include "HC165.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"

STD_ReturnType HC165_Init(uint8 Copy_u8ParallelLoadPort, uint8 Copy_u8ParallelLoadPin)
{
    STD_ReturnType result;

    result = GPIO_SetPinDirection(Copy_u8ParallelLoadPort, Copy_u8ParallelLoadPin, GPIO_OUTPUT);
    if (result != E_OK)
    {
        return result;
    }

    return GPIO_SetPinValue(Copy_u8ParallelLoadPort, Copy_u8ParallelLoadPin, GPIO_HIGH);
}

uint8 HC165_Read(uint8 Copy_u8ParallelLoadPort, uint8 Copy_u8ParallelLoadPin)
{
    uint8 receivedData = 0;

    // Latch the parallel data into the shift register
    GPIO_SetPinValue(Copy_u8ParallelLoadPort, Copy_u8ParallelLoadPin, GPIO_LOW);
    GPIO_SetPinValue(Copy_u8ParallelLoadPort, Copy_u8ParallelLoadPin, GPIO_HIGH);

    // Shift out the data via SPI
    SPI_Transceive(0xFF, &receivedData);

    return receivedData;
}