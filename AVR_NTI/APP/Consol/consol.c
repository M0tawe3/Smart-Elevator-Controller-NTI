#include "consol.h"
#include <string.h>
#include "MCAL/UART/UART_interface.h"
#include "MCAL/INTERRUPT/INTERRUPT_interface.h"
#include "../dispatch/dispatch.h"

static uint8 g_rxBuffer[CONS_CMD_MAX];
static uint8 g_rxLen = 0U;
static uint8 g_page = 0U;
static Calls_t g_calls = {0U, 0U, 0U};

static uint8 CONS_ParseFloor(const uint8 *command)
{
    if (command[0] < '0' || command[0] > '3' || command[1] != ' ') {
        return FLOOR_COUNT;
    }

    return (uint8)(command[0] - '0');
}

void CONS_Init(void)
{
    g_rxLen = 0U;
    g_page = 0U;
    g_calls = (Calls_t){0U, 0U, 0U};
    UART_Init(9600UL);
    UART_SetRxInterrupt(1U);
    UART_SetRxCallback(CONS_HandleByte);
    INTERRUPT_EnableGlobal();
}

void CONS_HandleByte(uint8 data)
{
    if (data == '\r' || data == '\n')
    {
        if (g_rxLen > 0U)
        {
            g_rxBuffer[g_rxLen] = '\0';
            CONS_ParseCommand(g_rxBuffer);
            g_rxLen = 0U;
        }
        return;
    }

    if (g_rxLen < (CONS_CMD_MAX - 1U))
    {
        g_rxBuffer[g_rxLen++] = data;
    }
}

void CONS_Task(void)
{
    if (UART_IsDataReady() == E_OK)
    {
        uint8 ch = 0U;
        UART_ReceiveByte(&ch);
        CONS_HandleByte(ch);
    }
}

void CONS_ParseCommand(const uint8 *command)
{
    if (command == NULL)
    {
        return;
    }

    if (strncmp((const char *)command, "PAGE ", 5U) == 0)
    {
        uint8 page = (uint8)(command[5] - '0');
        if (page <= 1U)
        {
            g_page = page;
        }
        return;
    }

    if (strncmp((const char *)command, "CALL ", 5U) == 0)
    {
        uint8 floor = CONS_ParseFloor(&command[5]);
        const uint8 *kind = &command[7];

        if (floor >= FLOOR_COUNT) {
            return;
        }

        if (strcmp((const char *)kind, "UP") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_HALL_UP);
        } else if (strcmp((const char *)kind, "DOWN") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_HALL_DOWN);
        } else if (strcmp((const char *)kind, "CAR") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_CAR);
        }
        return;
    }

    if (strncmp((const char *)command, "CC", 2U) == 0 || strncmp((const char *)command, "HU", 2U) == 0 || strncmp((const char *)command, "HD", 2U) == 0)
    {
        CONS_SendTelemetry();
    }
}

void CONS_SendTelemetry(void)
{
    UART_SendString((const uint8 *)"OK\r\n");
}

Calls_t *CONS_GetCalls(void)
{
    return &g_calls;
}
