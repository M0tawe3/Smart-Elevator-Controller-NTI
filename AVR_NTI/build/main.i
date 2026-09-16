# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"


# 1 "/usr/avr/sys-root/include/string.h" 1 3 4
# 46 "/usr/avr/sys-root/include/string.h" 3 4
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4

# 229 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef unsigned int size_t;
# 47 "/usr/avr/sys-root/include/string.h" 2 3 4
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
# 4 "main.c" 2

# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 160 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 344 "/usr/lib64/gcc/avr/15/include/stddef.h" 3 4
typedef int wchar_t;
# 12 "LIB/STD_TYPES.h" 2
# 22 "LIB/STD_TYPES.h"

# 22 "LIB/STD_TYPES.h"
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
# 6 "main.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 24 "MCAL/TIMER/TIMER_interface.h"
extern volatile uint8 systemTicks10ms;







STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 76 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);




STD_ReturnType TIMER2_Init(void);


STD_ReturnType TIMER2_PWM(uint8 Copy_u8DutyPercent);


STD_ReturnType TIMER2_Stop(void);
# 7 "main.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 8 "main.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 9 "main.c" 2
# 1 "HAL/LCD/lcd.h" 1
# 10 "HAL/LCD/lcd.h"
void LCD_Init(void);
STD_ReturnType LCD_WriteData(uint8 byte);
void LCD_Update(uint8 floor, Dir_t dir, uint16 load);
void LCD_RefreshPartial(const char *newFrame);
void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive,DoorState_t door, CarState_t carstate, uint8 faultBlinkOn);
# 10 "main.c" 2

char frame[32];

int main(void)
{
    TIMER0_Init();
    I2C_InitMaster(100000UL);
    TIMER0_DelayMS(10U);
    LCD_Init();
    TIMER0_DelayMS(10U);



    while (1) {
        LCD_UpdateFrame(frame, 2, DIR_UP, 465, 209, FLT_NONE, DOOR_STATE_CLOSED, CS_ARRIVED, 0);
        LCD_RefreshPartial(frame);
        TIMER0_DelayMS(150U);
        LCD_UpdateFrame(frame, 2, DIR_UP, 465, 209, FLT_NONE, DOOR_STATE_OPEN, CS_ARRIVED, 1);
        LCD_RefreshPartial(frame);
        TIMER0_DelayMS(150U);
    }
}
