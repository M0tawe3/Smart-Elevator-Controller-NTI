#include "CarFSM.h"
#include "DoorFSM.h"
#include "Hoist.h"

static CarState_t g_carState = CAR_STATE_IDLE;

void CarFSM_Init(void)
{
    g_carState = CAR_STATE_IDLE;
    DoorFSM_Init();
    HST_Init();
}

void CarFSM_Update(uint8 overload, uint8 doorOpen, uint8 doorClosed, uint8 obstruction)
{
    if (overload)
    {
        g_carState = CAR_STATE_OVERLOAD;
        HST_Brake();
        return;
    }

    if (obstruction)
    {
        g_carState = CAR_STATE_FAULT;
        HST_Brake();
        return;
    }

    if (doorOpen)
    {
        g_carState = CAR_STATE_DOOR_OPEN;
        return;
    }

    if (doorClosed)
    {
        g_carState = CAR_STATE_IDLE;
        HST_Brake();
        return;
    }

    g_carState = CAR_STATE_MOVING;
    HST_SetDir(HST_DIR_UP);
    HST_SetDuty(50U, 0U);
}

CarState_t CarFSM_GetState(void)
{
    return g_carState;
}
