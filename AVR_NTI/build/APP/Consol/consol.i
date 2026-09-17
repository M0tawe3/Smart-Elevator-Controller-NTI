# 0 "APP/Consol/consol.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "APP/Consol/consol.c"
# 1 "APP/Consol/consol.h" 1



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
# 13 "LIB/STD_TYPES.h" 2
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
# 5 "APP/Consol/consol.h" 2



void CONS_Init(void);
void CONS_HandleByte(uint8 data);
void CONS_Task(void);
void CONS_ParseCommand(const uint8 *command);
void CONS_SendTelemetry(void);
Calls_t *CONS_GetCalls(void);
# 2 "APP/Consol/consol.c" 2
# 1 "/usr/avr/sys-root/include/string.h" 1 3 4
# 46 "/usr/avr/sys-root/include/string.h" 3 4
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 47 "/usr/avr/sys-root/include/string.h" 2 3 4
# 125 "/usr/avr/sys-root/include/string.h" 3 4

# 125 "/usr/avr/sys-root/include/string.h" 3 4
extern int ffs(int __val) __attribute__((__const__));





extern int ffsl(long __val) __attribute__((__const__));





__extension__ extern int ffsll(long long __val) __attribute__((__const__));
# 150 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memccpy(void *, const void *, int, size_t);
# 162 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memchr(const void *, int, size_t) __attribute__((__pure__));
# 180 "/usr/avr/sys-root/include/string.h" 3 4
extern int memcmp(const void *, const void *, size_t) __attribute__((__pure__));
# 191 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memcpy(void *, const void *, size_t);
# 203 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memmem(const void *, size_t, const void *, size_t) __attribute__((__pure__));
# 213 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memmove(void *, const void *, size_t);
# 225 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memrchr(const void *, int, size_t) __attribute__((__pure__));
# 235 "/usr/avr/sys-root/include/string.h" 3 4
extern void *memset(void *, int, size_t);
# 248 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strcat(char *, const char *);
# 262 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strchr(const char *, int) __attribute__((__pure__));
# 274 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strchrnul(const char *, int) __attribute__((__pure__));
# 287 "/usr/avr/sys-root/include/string.h" 3 4
extern int strcmp(const char *, const char *) __attribute__((__pure__));
# 305 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strcpy(char *, const char *);
# 320 "/usr/avr/sys-root/include/string.h" 3 4
extern int strcasecmp(const char *, const char *) __attribute__((__pure__));
# 333 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strcasestr(const char *, const char *) __attribute__((__pure__));
# 344 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strcspn(const char *__s, const char *__reject) __attribute__((__pure__));
# 364 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strdup(const char *s1);
# 377 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strlcat(char *, const char *, size_t);
# 388 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strlcpy(char *, const char *, size_t);
# 399 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strlen(const char *) __attribute__((__pure__));
# 411 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strlwr(char *);
# 422 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strncat(char *, const char *, size_t);
# 434 "/usr/avr/sys-root/include/string.h" 3 4
extern int strncmp(const char *, const char *, size_t) __attribute__((__pure__));
# 449 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strncpy(char *, const char *, size_t);
# 464 "/usr/avr/sys-root/include/string.h" 3 4
extern int strncasecmp(const char *, const char *, size_t) __attribute__((__pure__));
# 478 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strnlen(const char *, size_t) __attribute__((__pure__));
# 491 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strpbrk(const char *__s, const char *__accept) __attribute__((__pure__));
# 505 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strrchr(const char *, int) __attribute__((__pure__));
# 515 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strrev(char *);
# 533 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strsep(char **, const char *);
# 544 "/usr/avr/sys-root/include/string.h" 3 4
extern size_t strspn(const char *__s, const char *__accept) __attribute__((__pure__));
# 557 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strstr(const char *, const char *) __attribute__((__pure__));
# 576 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strtok(char *, const char *);
# 593 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strtok_r(char *, const char *, char **);
# 606 "/usr/avr/sys-root/include/string.h" 3 4
extern char *strupr(char *);



extern int strcoll(const char *s1, const char *s2);
extern char *strerror(int errnum);
extern size_t strxfrm(char *dest, const char *src, size_t n);
# 3 "APP/Consol/consol.c" 2
# 1 "./MCAL/UART/UART_interface.h" 1
# 16 "./MCAL/UART/UART_interface.h"

# 16 "./MCAL/UART/UART_interface.h"
typedef void (*UART_RxCallback_t)(uint8 data);





STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetRxCallback(UART_RxCallback_t Copy_pfCallback);
# 4 "APP/Consol/consol.c" 2
# 1 "./MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 30 "./MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void));
# 5 "APP/Consol/consol.c" 2
# 1 "APP/Consol/../dispatch/dispatch.h" 1





STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type);

STD_ReturnType DSP_ClearFloor(Calls_t *calls, uint8 floor);

Dir_t DSP_NextDirection(const Calls_t *calls, uint8 currentFloor, Dir_t currentDirection);

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction);
# 6 "APP/Consol/consol.c" 2

static uint8 g_rxBuffer[32U];
static uint8 g_rxLen = 0U;
static uint8 g_page = 0U;
static Calls_t g_calls = {0U, 0U, 0U};

static uint8 CONS_ParseFloor(const uint8 *command)
{
    if (command[0] < '0' || command[0] > '3' || command[1] != ' ') {
        return 4u;
    }

    return (uint8)(command[0] - '0');
}

void CONS_Init(void)
{
    g_rxLen = 0U;
    g_page = 0U;
    g_calls = (Calls_t){0U, 0U, 0U};
    UART_Init(9600UL);
    UART_SetRxInterrupt(1U);
    UART_SetRxCallback(CONS_HandleByte);
    INTERRUPT_EnableGlobal();
}

void CONS_HandleByte(uint8 data)
{
    if (data == '\r' || data == '\n')
    {
        if (g_rxLen > 0U)
        {
            g_rxBuffer[g_rxLen] = '\0';
            CONS_ParseCommand(g_rxBuffer);
            g_rxLen = 0U;
        }
        return;
    }

    if (g_rxLen < (32U - 1U))
    {
        g_rxBuffer[g_rxLen++] = data;
    }
}

void CONS_Task(void)
{
    if (UART_IsDataReady() == E_OK)
    {
        uint8 ch = 0U;
        UART_ReceiveByte(&ch);
        CONS_HandleByte(ch);
    }
}

void CONS_ParseCommand(const uint8 *command)
{
    if (command == 
# 63 "APP/Consol/consol.c" 3 4
                  ((void *)0)
# 63 "APP/Consol/consol.c"
                      )
    {
        return;
    }

    if (strncmp((const char *)command, "PAGE ", 5U) == 0)
    {
        uint8 page = (uint8)(command[5] - '0');
        if (page <= 1U)
        {
            g_page = page;
        }
        return;
    }

    if (strncmp((const char *)command, "CALL ", 5U) == 0)
    {
        uint8 floor = CONS_ParseFloor(&command[5]);
        const uint8 *kind = &command[7];

        if (floor >= 4u) {
            return;
        }

        if (strcmp((const char *)kind, "UP") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_HALL_UP);
        } else if (strcmp((const char *)kind, "DOWN") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_HALL_DOWN);
        } else if (strcmp((const char *)kind, "CAR") == 0) {
            DSP_AddCall(&g_calls, floor, CALL_CAR);
        }
        return;
    }

    if (strncmp((const char *)command, "CC", 2U) == 0 || strncmp((const char *)command, "HU", 2U) == 0 || strncmp((const char *)command, "HD", 2U) == 0)
    {
        CONS_SendTelemetry();
    }
}

void CONS_SendTelemetry(void)
{
    UART_SendString((const uint8 *)"OK\r\n");
}

Calls_t *CONS_GetCalls(void)
{
    return &g_calls;
}
