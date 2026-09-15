# 0 "APP/CarFSM/CarFSM.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "APP/CarFSM/CarFSM.c"
# 1 "APP/CarFSM/CarFSM.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 1 3 4
# 160 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4

# 160 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2







# 18 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;
# 5 "APP/CarFSM/CarFSM.h" 2

typedef enum {
    CAR_STATE_IDLE = 0U,
    CAR_STATE_MOVING,
    CAR_STATE_DOOR_OPEN,
    CAR_STATE_OVERLOAD,
    CAR_STATE_FAULT
} CarState_t;

void CarFSM_Init(void);
void CarFSM_Update(uint8 overload, uint8 doorOpen, uint8 doorClosed, uint8 obstruction);
CarState_t CarFSM_GetState(void);
# 2 "APP/CarFSM/CarFSM.c" 2
# 1 "APP/DoorFSM/DoorFSM.h" 1





typedef enum {
    DOOR_STATE_CLOSED = 0U,
    DOOR_STATE_OPENING,
    DOOR_STATE_OPEN,
    DOOR_STATE_CLOSING,
    DOOR_STATE_JAMMED
} DoorState_t;

void DoorFSM_Init(void);
void DoorFSM_Open(void);
void DoorFSM_Close(void);
void DoorFSM_Update(uint8 obstructionDetected);
DoorState_t DoorFSM_GetState(void);
# 3 "APP/CarFSM/CarFSM.c" 2
# 1 "HAL/Hoist/Hoist.h" 1





typedef enum {
    HST_DIR_NONE = 0U,
    HST_DIR_UP,
    HST_DIR_DOWN
} HST_Dir_t;

void HST_Init(void);
void HST_Brake(void);
void HST_SetDir(HST_Dir_t dir);
void HST_SetDuty(uint8 dutyPct, uint8 doorPct);
void HST_EmergencyStop(void);
# 4 "APP/CarFSM/CarFSM.c" 2

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

    if (obstruction)
    {
        g_carState = CAR_STATE_FAULT;
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
