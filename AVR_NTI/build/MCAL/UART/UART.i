# 0 "MCAL/UART/UART.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/UART/UART.c"
# 9 "MCAL/UART/UART.c"
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
# 10 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 15 "MCAL/UART/UART_interface.h"
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 16 "MCAL/UART/UART_interface.h" 2





STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 11 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_private.h" 1
# 12 "MCAL/UART/UART.c" 2
# 21 "MCAL/UART/UART.c"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate)
{
    if (Copy_u32BaudRate == 0)
        return E_NOK;

    uint16 temp = 8000000UL / (16 * Copy_u32BaudRate) - 1;
    (*(volatile uint8 *)0x40) = temp >> 8;
    (*(volatile uint8 *)0x29) = temp & 0xFF;

    (*(volatile uint8 *)0x40) |= (1 << 7) | (1 << 2) | (1 << 1);
    (*(volatile uint8 *)0x2A) |= (1 << 4) | (1 << 3);

    return E_OK;
}





STD_ReturnType UART_SendByte(uint8 Copy_u8Data)
{
    while (!(((*(volatile uint8 *)0x2B) >> 5) & 1u))
    {
    };

    (*(volatile uint8 *)0x2C) = Copy_u8Data;
    return E_OK;
}






STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data)
{
    if (Copy_pu8Data == 
# 57 "MCAL/UART/UART.c" 3 4
                       ((void *)0)
# 57 "MCAL/UART/UART.c"
                           )
        return E_NOK;

    while (!(((*(volatile uint8 *)0x2B) >> 7) & 1u))
    {
    };

    *Copy_pu8Data = (*(volatile uint8 *)0x2C);

    return E_OK;
}






STD_ReturnType UART_SendString(const uint8 *Copy_pu8String)
{
    if (Copy_pu8String == 
# 76 "MCAL/UART/UART.c" 3 4
                         ((void *)0)
# 76 "MCAL/UART/UART.c"
                             )
        return E_NOK;

    else
    {
        for (uint8 i = 0; Copy_pu8String[i] != '\0'; i++)
            UART_SendByte(Copy_pu8String[i]);

        return E_OK;
    }
}





STD_ReturnType UART_IsDataReady()
{
    if ((((*(volatile uint8 *)0x2B) >> 7) & 1u))
        return E_OK;
    else
        return E_NOK;
}
