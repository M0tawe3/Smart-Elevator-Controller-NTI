# 0 "HAL/Door/Door.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Door/Door.c"
# 1 "/usr/avr/sys-root/include/avr/io.h" 1 3 4
# 99 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/sfr_defs.h" 1 3 4
# 126 "/usr/avr/sys-root/include/avr/sfr_defs.h" 3 4
# 1 "/usr/avr/sys-root/include/inttypes.h" 1 3 4
# 37 "/usr/avr/sys-root/include/inttypes.h" 3 4
# 1 "/usr/lib64/gcc/avr/15/include/stdint.h" 1 3 4
# 9 "/usr/lib64/gcc/avr/15/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "/usr/avr/sys-root/include/stdint.h" 1 3 4
# 125 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "/usr/avr/sys-root/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "/usr/lib64/gcc/avr/15/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 38 "/usr/avr/sys-root/include/inttypes.h" 2 3 4
# 77 "/usr/avr/sys-root/include/inttypes.h" 3 4
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "/usr/avr/sys-root/include/avr/sfr_defs.h" 2 3 4
# 100 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 230 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/iom32.h" 1 3 4
# 720 "/usr/avr/sys-root/include/avr/iom32.h" 3 4
       
# 721 "/usr/avr/sys-root/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 585 "/usr/avr/sys-root/include/avr/io.h" 3 4
# 1 "/usr/avr/sys-root/include/avr/portpins.h" 1 3 4
# 586 "/usr/avr/sys-root/include/avr/io.h" 2 3 4

# 1 "/usr/avr/sys-root/include/avr/common.h" 1 3 4
# 588 "/usr/avr/sys-root/include/avr/io.h" 2 3 4

# 1 "/usr/avr/sys-root/include/avr/version.h" 1 3 4
# 590 "/usr/avr/sys-root/include/avr/io.h" 2 3 4






# 1 "/usr/avr/sys-root/include/avr/fuse.h" 1 3 4
# 248 "/usr/avr/sys-root/include/avr/fuse.h" 3 4
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 597 "/usr/avr/sys-root/include/avr/io.h" 2 3 4


# 1 "/usr/avr/sys-root/include/avr/lock.h" 1 3 4
# 600 "/usr/avr/sys-root/include/avr/io.h" 2 3 4
# 2 "HAL/Door/Door.c" 2
# 1 "HAL/Door/Door.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2
# 23 "LIB/STD_TYPES.h"

# 23 "LIB/STD_TYPES.h"
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
    FLT_OVERLOAD,
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
    uint8 hallUp;
    uint8 hallDown;
} Calls_t;

typedef struct {
    uint16 positionCm;
    uint8 currentFloor;
    uint8 targetFloor;
    uint8 doorPct;
    uint16 loadKg;
    uint16 currentmA;
    Calls_t calls;
    uint8 dir;
    uint8 lastDir;
    uint8 state;
    uint8 doorState;
    uint8 hoistDuty;
    uint8 overload : 1;
    uint8 fireService : 1;
    uint8 independent : 1;
    uint8 estop : 1;
    uint8 obstruction : 1;
    uint8 levelled : 1;
    uint8 reserved : 2;
    uint8 activeFault;
    uint16 doorDwellTicks;
    uint32 tripCount;
    uint32 doorCycles;
    uint32 upTimeSec;
} CarData_t;

typedef enum {
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;

typedef enum
{
    CALL_CAR,
    CALL_HALL_UP,
    CALL_HALL_DOWN
} CallType_t;

typedef enum {
    DIR_NONE,
    DIR_UP,
    DIR_DOWN
} Dir_t;
# 5 "HAL/Door/Door.h" 2

typedef enum {
    DRV_DIR_NONE = 0U,
    DRV_DIR_OPEN,
    DRV_DIR_CLOSE
} DRV_Dir_t;

void DRV_Init(void);
void DRV_SetDir(DRV_Dir_t dir);
void DRV_SetDuty(uint8 dutyPct);
void DRV_Stop(void);
# 3 "HAL/Door/Door.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 4 "HAL/Door/Door.c" 2
# 12 "HAL/Door/Door.c"
void DRV_Init(void)
{
    GPIO_SetPinDirection(1u, 2u, 1u);
    GPIO_SetPinDirection(1u, 3u, 1u);
    GPIO_SetPinDirection(3u, 4u, 1u);

    DRV_Stop();

    
# 20 "HAL/Door/Door.c" 3 4
   (*(volatile uint8_t *)((0x2F) + 0x20)) 
# 20 "HAL/Door/Door.c"
          = (1U << 
# 20 "HAL/Door/Door.c" 3 4
                   5
# 20 "HAL/Door/Door.c"
                         ) | (1U << 
# 20 "HAL/Door/Door.c" 3 4
                                    1
# 20 "HAL/Door/Door.c"
                                         );
    
# 21 "HAL/Door/Door.c" 3 4
   (*(volatile uint8_t *)((0x2E) + 0x20)) 
# 21 "HAL/Door/Door.c"
          = (1U << 
# 21 "HAL/Door/Door.c" 3 4
                   4
# 21 "HAL/Door/Door.c"
                        ) | (1U << 
# 21 "HAL/Door/Door.c" 3 4
                                   3
# 21 "HAL/Door/Door.c"
                                        ) | (1U << 
# 21 "HAL/Door/Door.c" 3 4
                                                   0
# 21 "HAL/Door/Door.c"
                                                       );
    
# 22 "HAL/Door/Door.c" 3 4
   (*(volatile uint16_t *)((0x26) + 0x20)) 
# 22 "HAL/Door/Door.c"
        = 799U;
    
# 23 "HAL/Door/Door.c" 3 4
   (*(volatile uint16_t *)((0x28) + 0x20)) 
# 23 "HAL/Door/Door.c"
         = 0U;
}

void DRV_SetDir(DRV_Dir_t dir)
{
    if (dir == DRV_DIR_OPEN)
    {
        GPIO_SetPinValue(1u, 3u, 0u);
        GPIO_SetPinValue(1u, 2u, 1u);
    }
    else if (dir == DRV_DIR_CLOSE)
    {
        GPIO_SetPinValue(1u, 2u, 0u);
        GPIO_SetPinValue(1u, 3u, 1u);
    }
    else
    {
        DRV_Stop();
    }
}

void DRV_SetDuty(uint8 dutyPct)
{
    if (dutyPct > 100U)
    {
        dutyPct = 100U;
    }

    uint32 compareVal = ((uint32)dutyPct * 799U) / 100U;
    
# 52 "HAL/Door/Door.c" 3 4
   (*(volatile uint16_t *)((0x28) + 0x20)) 
# 52 "HAL/Door/Door.c"
         = (uint16)compareVal;
}

void DRV_Stop(void)
{
    
# 57 "HAL/Door/Door.c" 3 4
   (*(volatile uint16_t *)((0x28) + 0x20)) 
# 57 "HAL/Door/Door.c"
         = 0U;
    GPIO_SetPinValue(1u, 2u, 0u);
    GPIO_SetPinValue(1u, 3u, 0u);
}
