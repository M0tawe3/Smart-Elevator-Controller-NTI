#include <assert.h>
#include <stdio.h>

#define HST_SetDuty fake_HST_SetDuty
#define HST_SetDir fake_HST_SetDir
#define HST_Brake fake_HST_Brake
#include "../APP/Motion/Motion.c"
#undef HST_SetDuty
#undef HST_SetDir
#undef HST_Brake

#define UART_Init fake_UART_Init
#define UART_SetRxInterrupt fake_UART_SetRxInterrupt
#define UART_SetRxCallback fake_UART_SetRxCallback
#define UART_IsDataReady fake_UART_IsDataReady
#define UART_ReceiveByte fake_UART_ReceiveByte
#define UART_SendString fake_UART_SendString
#define INTERRUPT_EnableGlobal fake_INTERRUPT_EnableGlobal
#include "../APP/Consol/consol.c"
#undef UART_Init
#undef UART_SetRxInterrupt
#undef UART_SetRxCallback
#undef UART_IsDataReady
#undef UART_ReceiveByte
#undef UART_SendString
#undef INTERRUPT_EnableGlobal

#include "../APP/Safety/Safety.c"
#include "../APP/Fault_log/fault_log.c"

static uint8 g_brakeCount = 0U;
static uint8 g_duty = 0U;
static HST_Dir_t g_direction = HST_DIR_NONE;

void fake_HST_SetDuty(uint8 dutyPct, uint8 doorPct)
{
    g_duty = dutyPct;
    (void)doorPct;
}

void fake_HST_SetDir(HST_Dir_t dir)
{
    g_direction = dir;
}

void fake_HST_Brake(void)
{
    g_brakeCount++;
}

STD_ReturnType fake_UART_Init(uint32 baudRate) { (void)baudRate; return E_OK; }
STD_ReturnType fake_UART_SetRxInterrupt(uint8 state) { (void)state; return E_OK; }
STD_ReturnType fake_UART_SetRxCallback(UART_RxCallback_t callback) { (void)callback; return E_OK; }
STD_ReturnType fake_UART_IsDataReady(void) { return E_NOK; }
STD_ReturnType fake_UART_ReceiveByte(uint8 *data) { (void)data; return E_NOK; }
STD_ReturnType fake_UART_SendString(const uint8 *string) { (void)string; return E_OK; }
STD_ReturnType fake_INTERRUPT_EnableGlobal(void) { return E_OK; }

static void test_safety_hysteresis(void)
{
    CarData_t car = {0};

    car.state = CS_IDLE;
    car.loadKg = 900U;
    SAF_Evaluate(&car);
    assert(car.overload == 1U);
    assert(car.state == CS_OVERLOAD);

    car.loadKg = 875U;
    SAF_Evaluate(&car);
    assert(car.overload == 1U);
    assert(car.state == CS_OVERLOAD);

    car.loadKg = 850U;
    SAF_Evaluate(&car);
    assert(car.overload == 0U);
    assert(car.state == CS_IDLE);
}

static void test_safety_fault_priority(void)
{
    CarData_t car = {0};

    car.positionCm = 1006U;
    SAF_Evaluate(&car);
    assert(car.activeFault == FLT_OVERTRAVEL);
    assert(car.state == CS_FAULT);

    car = (CarData_t){0};
    car.estop = 1U;
    SAF_Evaluate(&car);
    assert(car.activeFault == FLT_ESTOP);
    assert(car.state == CS_ESTOP);

    car = (CarData_t){0};
    car.currentmA = 15001U;
    for (uint8 tick = 0U; tick < 50U; tick++) {
        SAF_Evaluate(&car);
    }
    assert(car.activeFault == FLT_OVERCURRENT);
    assert(car.state == CS_FAULT);
}

static void test_motion_door_interlock(void)
{
    CarData_t car = {0};

    assert(MOT_GoTo(2U, 0U) == E_OK);
    car.state = CS_IDLE;
    car.doorPct = 100U;
    g_brakeCount = 0U;
    g_duty = 0U;
    MOT_Step(&car);
    assert(g_brakeCount == 1U);
    assert(g_duty == 0U);

    car.doorPct = 0U;
    assert(MOT_GoTo(2U, 0U) == E_OK);
    MOT_Step(&car);
    assert(g_direction == HST_DIR_UP);
    assert(g_duty > 0U);
    MOT_Stop();
}

static void test_console_calls(void)
{
    const Calls_t *calls;

    CONS_ParseCommand((const uint8 *)"CALL 2 UP");
    CONS_ParseCommand((const uint8 *)"CALL 1 DOWN");
    CONS_ParseCommand((const uint8 *)"CALL 3 CAR");
    calls = CONS_GetCalls();

    assert((calls->hallUp & (1U << 2U)) != 0U);
    assert((calls->hallDown & (1U << 1U)) != 0U);
    assert((calls->carCall & (1U << 3U)) != 0U);
}

static void test_fault_log_ring(void)
{
    FL_Init();
    for (uint8 i = 0U; i < 18U; i++)
    {
        FL_AddFault(i);
    }

    assert(FL_GetCount() == FAULT_LOG_DEPTH);
    assert(FL_ReadOldest() == 2U);
    assert(FL_ReadNewest() == 17U);
}

int main(void)
{
    test_safety_hysteresis();
    test_safety_fault_priority();
    test_motion_door_interlock();
    test_console_calls();
    test_fault_log_ring();
    puts("system_logic_test: PASS");
    return 0;
}