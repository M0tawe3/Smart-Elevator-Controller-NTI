#include <stdint.h>
#include "Safety.h"

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
        car->activeFault = FLT_NONE;
        if (car->state == CS_IDLE || car->state == CS_DOOR_OPEN) {
            car->state = CS_OVERLOAD;
        }
    } else if (car->overload && (car->loadKg < OVERLOAD_CLEAR_KG)) {
        car->overload = 0U;
        car->activeFault = FLT_NONE;
        if (car->state == CS_OVERLOAD) {
            car->state = CS_IDLE;
        }
    } else {
        if (car->state == CS_OVERLOAD && car->activeFault == FLT_NONE) {
            car->state = CS_IDLE;
        }
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