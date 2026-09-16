#include <assert.h>
#include <stdio.h>

#define DRV_Init fake_DRV_Init
#define DRV_SetDir fake_DRV_SetDir
#define DRV_SetDuty fake_DRV_SetDuty
#define DRV_Stop fake_DRV_Stop
#define HST_Init fake_HST_Init
#define HST_Brake fake_HST_Brake
#define HST_SetDir fake_HST_SetDir
#define HST_SetDuty fake_HST_SetDuty

#include "../APP/CarFSM/CarFSM.c"
#include "../APP/DoorFSM/DoorFSM.c"

#undef DRV_Init
#undef DRV_SetDir
#undef DRV_SetDuty
#undef DRV_Stop
#undef HST_Init
#undef HST_Brake
#undef HST_SetDir
#undef HST_SetDuty

void fake_DRV_Init(void) {}
void fake_DRV_SetDir(DRV_Dir_t dir) { (void)dir; }
void fake_DRV_SetDuty(uint8 dutyPct) { (void)dutyPct; }
void fake_DRV_Stop(void) {}
void fake_HST_Init(void) {}
static uint8 g_hstBrakeCount = 0U;
static uint8 g_hstDuty = 0U;
void fake_HST_Brake(void) { g_hstBrakeCount++; }
void fake_HST_SetDir(HST_Dir_t dir) { (void)dir; }
void fake_HST_SetDuty(uint8 dutyPct, uint8 doorPct)
{
    g_hstDuty = dutyPct;
    (void)doorPct;
}

static void reset_hoist_spy(void)
{
    g_hstBrakeCount = 0U;
    g_hstDuty = 0U;
}

static void test_car_fsm_overload_and_obstruction(void)
{
    CarFSM_Init();
    assert(CarFSM_GetState() == CAR_STATE_IDLE);

    CarFSM_Update(1U, 0U, 0U, 0U);
    assert(CarFSM_GetState() == CAR_STATE_OVERLOAD);

    CarFSM_Update(0U, 0U, 0U, 1U);
    assert(CarFSM_GetState() == CAR_STATE_FAULT);
}

static void test_car_fsm_door_interlock_and_motion(void)
{
    CarFSM_Init();
    reset_hoist_spy();

    CarFSM_Update(0U, 1U, 0U, 0U);
    assert(CarFSM_GetState() == CAR_STATE_DOOR_OPEN);
    assert(g_hstBrakeCount == 1U);

    reset_hoist_spy();
    CarFSM_Update(0U, 0U, 0U, 0U);
    assert(CarFSM_GetState() == CAR_STATE_MOVING);
    assert(g_hstDuty == 50U);
}

static void test_door_fsm_obstruction_and_jam(void)
{
    DoorFSM_Init();
    assert(DoorFSM_GetState() == DOOR_STATE_CLOSED);

    DoorFSM_Open();
    DoorFSM_Update(0U);
    assert(DoorFSM_GetState() == DOOR_STATE_OPEN);

    DoorFSM_Close();
    DoorFSM_Update(1U);
    assert(DoorFSM_GetState() == DOOR_STATE_OPENING);

    DoorFSM_Update(0U);
    DoorFSM_Close();
    DoorFSM_Update(0U);
    assert(DoorFSM_GetState() == DOOR_STATE_CLOSED);

    DoorFSM_Open();
    DoorFSM_Update(1U);
    DoorFSM_Update(0U);
    DoorFSM_Close();

    DoorFSM_Update(1U);
    DoorFSM_Update(1U);
    DoorFSM_Update(1U);
    assert(DoorFSM_GetState() == DOOR_STATE_JAMMED);
}

int main(void)
{
    test_car_fsm_overload_and_obstruction();
    test_car_fsm_door_interlock_and_motion();
    test_door_fsm_obstruction_and_jam();
    puts("fsm_logic_test: PASS");
    return 0;
}
