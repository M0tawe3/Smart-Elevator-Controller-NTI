#include "DoorFSM.h"
#include "Door.h"

static DoorState_t g_doorState = DOOR_STATE_CLOSED;
static uint8 g_obstructionCount = 0U;

void DoorFSM_Init(void)
{
    g_doorState = DOOR_STATE_CLOSED;
    g_obstructionCount = 0U;
    DRV_Init();
    DRV_Stop();
}

void DoorFSM_Open(void)
{
    g_doorState = DOOR_STATE_OPENING;
    DRV_SetDir(DRV_DIR_OPEN);
    DRV_SetDuty(60U);
}

void DoorFSM_Close(void)
{
    g_doorState = DOOR_STATE_CLOSING;
    DRV_SetDir(DRV_DIR_CLOSE);
    DRV_SetDuty(60U);
}

void DoorFSM_Update(uint8 obstructionDetected)
{
    if (g_doorState == DOOR_STATE_JAMMED)
    {
        DRV_Stop();
        return;
    }

    if (obstructionDetected)
    {
        g_obstructionCount++;
        if (g_obstructionCount >= 3U)
        {
            g_doorState = DOOR_STATE_JAMMED;
            DRV_Stop();
            return;
        }

        if (g_doorState == DOOR_STATE_CLOSING)
        {
            g_doorState = DOOR_STATE_OPENING;
            DRV_SetDir(DRV_DIR_OPEN);
            DRV_SetDuty(50U);
            return;
        }

        if (g_doorState == DOOR_STATE_OPENING || g_doorState == DOOR_STATE_OPEN)
        {
            g_doorState = DOOR_STATE_OPENING;
            DRV_SetDir(DRV_DIR_OPEN);
            DRV_SetDuty(50U);
            return;
        }
    }
    else
    {
        g_obstructionCount = 0U;
    }

    if (g_doorState == DOOR_STATE_OPENING)
    {
        if (!obstructionDetected)
        {
            g_doorState = DOOR_STATE_OPEN;
            DRV_Stop();
        }
    }
    else if (g_doorState == DOOR_STATE_CLOSING)
    {
        if (!obstructionDetected)
        {
            g_doorState = DOOR_STATE_CLOSED;
            DRV_Stop();
        }
    }
}

void DoorFSM_UpdatePosition(uint8 obstructionDetected, uint8 doorPct)
{
    if (doorPct > 100U)
    {
        doorPct = 100U;
    }

    if (g_doorState == DOOR_STATE_JAMMED)
    {
        DRV_Stop();
        return;
    }

    if (obstructionDetected)
    {
        g_obstructionCount++;
        if (g_obstructionCount >= 3U)
        {
            g_doorState = DOOR_STATE_JAMMED;
            DRV_Stop();
            return;
        }

        if (g_doorState == DOOR_STATE_CLOSING)
        {
            g_doorState = DOOR_STATE_OPENING;
            DRV_SetDir(DRV_DIR_OPEN);
            DRV_SetDuty(50U);
            return;
        }
    }
    else
    {
        g_obstructionCount = 0U;
    }

    if (g_doorState == DOOR_STATE_OPENING && doorPct >= 95U)
    {
        g_doorState = DOOR_STATE_OPEN;
        DRV_Stop();
    }
    else if (g_doorState == DOOR_STATE_CLOSING && doorPct <= 5U)
    {
        g_doorState = DOOR_STATE_CLOSED;
        DRV_Stop();
    }
}

DoorState_t DoorFSM_GetState(void)
{
    return g_doorState;
}
