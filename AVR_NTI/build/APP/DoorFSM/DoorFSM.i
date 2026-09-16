# 0 "APP/DoorFSM/DoorFSM.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "APP/DoorFSM/DoorFSM.c"
# 1 "APP/DoorFSM/DoorFSM.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4

# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
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
# 5 "APP/DoorFSM/DoorFSM.h" 2

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
# 2 "APP/DoorFSM/DoorFSM.c" 2
# 1 "HAL/Door/Door.h" 1





typedef enum {
    DRV_DIR_NONE = 0U,
    DRV_DIR_OPEN,
    DRV_DIR_CLOSE
} DRV_Dir_t;

void DRV_Init(void);
void DRV_SetDir(DRV_Dir_t dir);
void DRV_SetDuty(uint8 dutyPct);
void DRV_Stop(void);
# 3 "APP/DoorFSM/DoorFSM.c" 2

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

DoorState_t DoorFSM_GetState(void)
{
    return g_doorState;
}
