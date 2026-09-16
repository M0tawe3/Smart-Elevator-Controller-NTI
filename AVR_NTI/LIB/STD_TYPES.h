#ifndef STD_TYPES_H
#define STD_TYPES_H

/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * Shared standard types for AVR_NTI LIB / MCAL / HAL / Logic.
 */

#include <stddef.h>

#define SET_BIT(REG, BIT) ((REG) |= (1u << (BIT)))
#define CLEAR_BIT(REG, BIT) ((REG) &= ~(1u << (BIT)))
#define TOGGLE_BIT(REG, BIT) ((REG) ^= (1u << (BIT)))
#define READ_BIT(REG, BIT) (((REG) >> (BIT)) & 1u)

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

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

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;


#define FLOOR_COUNT 4u
#define FLOOR_MASK  0x0Fu

typedef struct
{
    uint8 carCall;
    uint8 hallUp;
    uint8 hallDown;
} Calls_t;

typedef enum
{
    CALL_CAR,
    CALL_HALL_UP,
    CALL_HALL_DOWN
} CallType_t;

typedef enum
{
    DIR_NONE,
    DIR_UP,
    DIR_DOWN
} Dir_t;


#endif /* STD_TYPES_H */
