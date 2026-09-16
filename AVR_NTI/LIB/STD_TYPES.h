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

#define FLOOR_COUNT 4u
#define FLOOR_MASK  0x0Fu


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
    DOOR_STATE_CLOSED = 0U,
    DOOR_STATE_OPENING,
    DOOR_STATE_OPEN,
    DOOR_STATE_CLOSING,
    DOOR_STATE_JAMMED
} DoorState_t;

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
    uint8 carCall;
    uint8  hallUp;
    uint8 hallDown;
} Calls_t;

typedef struct {
    uint16 positionCm;
    uint8  currentFloor;
    uint8  targetFloor;
    uint8  doorPct;
    uint16 loadKg;
    uint16 currentmA;
    Calls_t  calls;
    uint8  dir;
    uint8  lastDir;
    uint8  state;
    uint8  doorState;
    uint8  hoistDuty;
    uint8  overload    : 1;
    uint8  fireService : 1;
    uint8  independent : 1;
    uint8  estop       : 1;
    uint8  obstruction : 1;
    uint8  levelled    : 1;
    uint8  reserved    : 2;
    uint8  activeFault;
    uint16 doorDwellTicks;
    uint32 tripCount;
    uint32 doorCycles;
    uint32 upTimeSec;
} CarData_t;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;

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
