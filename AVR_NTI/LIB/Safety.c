#include <stdint.h>

typedef enum {
    CS_INIT = 0,
    CS_HOMING,
    CS_IDLE,
    CS_DOOR_OPENING,
    CS_DOOR_OPEN,
    CS_DOOR_CLOSING,
    CS_STARTING,
    CS_MOVING,
    CS_SLOWING,
    CS_LEVELLING,
    CS_ARRIVED,
    CS_OVERLOAD,
    CS_FIRE_RECALL,
    CS_FIRE_HOLD,
    CS_FAULT,
    CS_ESTOP
} CarState_t;

typedef enum {
    FLT_NONE = 0,
    FLT_ESTOP,
    FLT_OVERTRAVEL,
    FLT_TRAVEL_TIMEOUT,
    FLT_DOOR_TIMEOUT,
    FLT_OVERCURRENT,
    FLT_POSITION_SENSOR,
    FLT_LEVEL_FAIL,
    FLT_DOOR_JAM
} Fault_t;

typedef struct {
    uint8_t carCall;
    uint8_t hallUp;
    uint8_t hallDown;
} Calls_t;

typedef struct {
    uint16_t positionCm;
    uint8_t  currentFloor;
    uint8_t  targetFloor;
    uint8_t  doorPct;
    uint16_t loadKg;
    uint16_t currentmA;
    Calls_t  calls;
    uint8_t  dir;
    uint8_t  lastDir;
    uint8_t  state;
    uint8_t  doorState;
    uint8_t  hoistDuty;
    uint8_t  overload    : 1;
    uint8_t  fireService : 1;
    uint8_t  independent : 1;
    uint8_t  estop       : 1;
    uint8_t  obstruction : 1;
    uint8_t  levelled    : 1;
    uint8_t  reserved    : 2;
    uint8_t  activeFault;
    uint16_t doorDwellTicks;
    uint32_t tripCount;
    uint32_t doorCycles;
    uint32_t upTimeSec;
} CarData_t;

#define OVERLOAD_SET_KG     900U
#define OVERLOAD_CLEAR_KG   850U
#define OVERCURRENT_LIMIT_MA 15000U
#define OVERCURRENT_TICKS   50U

static uint16_t s_overcurrentTimer = 0U;

void SAF_Evaluate(CarData_t *car) {
    if (car == 0) {
        return;
    }

    if (car->estop) {
        car->activeFault = FLT_ESTOP;
        car->state = CS_ESTOP;
        return;
    }

    if (car->positionCm > 1005U) {
        car->activeFault = FLT_OVERTRAVEL;
        car->state = CS_FAULT;
        return;
    }

    if ((car->doorPct > 5U) && (car->hoistDuty > 0U)) {
        car->activeFault = FLT_DOOR_JAM;
        car->state = CS_FAULT;
        return;
    }

    if (car->currentmA > OVERCURRENT_LIMIT_MA) {
        s_overcurrentTimer++;
        if (s_overcurrentTimer >= OVERCURRENT_TICKS) {
            car->activeFault = FLT_OVERCURRENT;
            car->state = CS_FAULT;
            return;
        }
    } else {
        s_overcurrentTimer = 0U;
    }

    if (car->loadKg > OVERLOAD_SET_KG) {
        car->overload = 1U;
        if (car->state == CS_IDLE || car->state == CS_DOOR_OPEN) {
            car->state = CS_OVERLOAD;
        }
    } else if (car->overload && (car->loadKg < OVERLOAD_CLEAR_KG)) {
        car->overload = 0U;
    }
}

uint8_t SAF_Active(const CarData_t *car) {
    if (car == 0) {
        return 1U;
    }

    if (car->estop || car->activeFault != FLT_NONE || car->state == CS_FAULT || car->state == CS_ESTOP) {
        return 1U;
    }

    return 0U;
}