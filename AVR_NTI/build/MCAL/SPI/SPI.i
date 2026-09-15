# 0 "MCAL/SPI/SPI.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/SPI/SPI.c"
# 9 "MCAL/SPI/SPI.c"
# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4

# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2







# 18 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;
# 10 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 11 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/SPI/SPI_private.h" 1
# 12 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 13 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 20 "MCAL/UART/UART_interface.h"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 14 "MCAL/SPI/SPI.c" 2
# 22 "MCAL/SPI/SPI.c"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler)
{
    if (Copy_u8Prescaler > 3u)
        return E_NOK;

    GPIO_SetPinDirection(1u, 4u, 1u);
    GPIO_SetPinDirection(1u, 5u, 1u);
    GPIO_SetPinDirection(1u, 6u, 0u);
    GPIO_SetPinDirection(1u, 7u, 1u);

    GPIO_SetPinValue(1u, 4u, 1u);

    (*(volatile uint8 *)0x2D) = (1 << 6) | (1 << 4) | Copy_u8Prescaler;
    (*(volatile uint8 *)0x2E) &= ~(1 << 0);
    return E_OK;
}






STD_ReturnType SPI_InitSlave(void)
{
    GPIO_SetPinDirection(1u, 4u, 0u);
    GPIO_SetPinDirection(1u, 5u, 0u);
    GPIO_SetPinDirection(1u, 6u, 1u);
    GPIO_SetPinDirection(1u, 7u, 0u);

    (*(volatile uint8 *)0x2D) = (1 << 6);
    return E_OK;
}
# 62 "MCAL/SPI/SPI.c"
STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received)
{
    if (Copy_pu8Received == 
# 64 "MCAL/SPI/SPI.c" 3 4
                           ((void *)0)
# 64 "MCAL/SPI/SPI.c"
                               )
        return E_NOK;

    (*(volatile uint8 *)0x2F) = Copy_u8Sent;

    while (!((((*(volatile uint8 *)0x2E)) >> (7)) & 1u))
        ;

    *Copy_pu8Received = (*(volatile uint8 *)0x2F);
    return E_OK;
}
# 84 "MCAL/SPI/SPI.c"
STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    return GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, 0u);
}

STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    return GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, 1u);
}
