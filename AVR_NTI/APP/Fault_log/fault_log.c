#include "fault_log.h"

static uint8 g_faultLog[FAULT_LOG_DEPTH];
static uint8 g_logHead = 0U;
static uint8 g_logCount = 0U;

void FL_Init(void)
{
    FL_Clear();
}

void FL_Clear(void)
{
    for (uint8 i = 0U; i < FAULT_LOG_DEPTH; i++)
    {
        g_faultLog[i] = 0U;
    }
    g_logHead = 0U;
    g_logCount = 0U;
}

void FL_AddFault(uint8 faultCode)
{
    if (g_logCount < FAULT_LOG_DEPTH)
    {
        g_faultLog[g_logHead] = faultCode;
        g_logHead = (g_logHead + 1U) % FAULT_LOG_DEPTH;
        g_logCount++;
    }
    else
    {
        g_faultLog[g_logHead] = faultCode;
        g_logHead = (g_logHead + 1U) % FAULT_LOG_DEPTH;
    }
}

uint8 FL_GetCount(void)
{
    return g_logCount;
}

uint8 FL_ReadNewest(void)
{
    if (g_logCount == 0U)
    {
        return 0U;
    }

    uint8 idx = (g_logHead + FAULT_LOG_DEPTH - 1U) % FAULT_LOG_DEPTH;
    return g_faultLog[idx];
}

uint8 FL_ReadOldest(void)
{
    if (g_logCount == 0U)
    {
        return 0U;
    }

    uint8 oldestIndex = (g_logHead + FAULT_LOG_DEPTH - g_logCount) % FAULT_LOG_DEPTH;
    return g_faultLog[oldestIndex];
}

uint8 FL_ReadAt(uint8 index)
{
    if (index >= g_logCount)
    {
        return 0U;
    }

    uint8 actual = (g_logHead + FAULT_LOG_DEPTH - g_logCount + index) % FAULT_LOG_DEPTH;
    return g_faultLog[actual];
}
