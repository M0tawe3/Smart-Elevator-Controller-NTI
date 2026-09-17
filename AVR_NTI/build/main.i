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
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 8 "main.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 9 "main.c" 2
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
# 10 "main.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 11 "main.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 30 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void));
# 12 "main.c" 2
# 1 "HAL/LCD/lcd.h" 1
# 10 "HAL/LCD/lcd.h"
void LCD_Init(void);
STD_ReturnType LCD_WriteData(uint8 byte);
void LCD_Update(const char *frame);
void LCD_RefreshPartial(const char *newFrame);
void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive,DoorState_t door, uint8 faultBlinkOn);
# 13 "main.c" 2
# 1 "HAL/HC595/HC595.h" 1
# 9 "HAL/HC595/HC595.h"
void SEG_Show(uint8 floor, Dir_t dir);
# 14 "main.c" 2
# 1 "HAL/HC165/HC165.h" 1






uint16 BTN_Scan(void);


uint8 BTN_Pressed(uint8 n);
# 15 "main.c" 2
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
# 16 "main.c" 2
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
# 17 "main.c" 2
# 1 "HAL/Load/Load.h" 1
# 9 "HAL/Load/Load.h"
void LOAD_Init(void);
uint16 LOAD_ReadKg(void);
uint8 LOAD_IsOverloaded(void);
# 18 "main.c" 2
# 1 "HAL/Position/position.h" 1
# 11 "HAL/Position/position.h"
uint16 POS_cm(void);
uint8 POS_nearestFloor(uint16 cm);
uint8 POS_InLevelZone(uint16 cm);
# 19 "main.c" 2
# 1 "HAL/Buzzer/Buzzer.h" 1





void BUZ_Init(void);
void BUZ_Chime(void);
void BUZ_Alarm(void);
void BUZ_Stop(void);
# 20 "main.c" 2
# 1 "APP/CarFSM/CarFSM.h" 1
# 12 "APP/CarFSM/CarFSM.h"
void CarFSM_Init(void);
void CarFSM_Update(uint8 overload, uint8 doorOpen, uint8 doorClosed, uint8 obstruction);
CarState_t CarFSM_GetState(void);
# 21 "main.c" 2
# 1 "APP/DoorFSM/DoorFSM.h" 1





void DoorFSM_Init(void);
void DoorFSM_Open(void);
void DoorFSM_Close(void);
void DoorFSM_Update(uint8 obstructionDetected);
void DoorFSM_UpdatePosition(uint8 obstructionDetected, uint8 doorPct);
DoorState_t DoorFSM_GetState(void);
# 22 "main.c" 2
# 1 "APP/Consol/consol.h" 1







void CONS_Init(void);
void CONS_HandleByte(uint8 data);
void CONS_Task(void);
void CONS_ParseCommand(const uint8 *command);
void CONS_SendTelemetry(void);
# 23 "main.c" 2
# 1 "APP/Fault_log/fault_log.h" 1







void FL_Init(void);
void FL_Clear(void);
void FL_AddFault(uint8 faultCode);
uint8 FL_GetCount(void);
uint8 FL_ReadNewest(void);
uint8 FL_ReadOldest(void);
uint8 FL_ReadAt(uint8 index);
# 24 "main.c" 2
# 1 "APP/Motion/Motion.h" 1




# 1 "HAL/Hoist/Hoist.h" 1
# 6 "APP/Motion/Motion.h" 2

STD_ReturnType MOT_GoTo(uint8 targetFloor, uint16 currentCm);
void MOT_Stop(void);
uint8 MOT_AtTarget(uint16 currentCm);
void MOT_Step(CarData_t *car);
void MOT_RelevelCheck(CarData_t *car);
# 25 "main.c" 2
# 1 "APP/Safety/Safety.h" 1





void SAF_Evaluate(CarData_t *car);
uint8 SAF_Active(const CarData_t *car);
# 26 "main.c" 2
# 1 "APP/dispatch/dispatch.h" 1





STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type);

STD_ReturnType DSP_ClearFloor(Calls_t *calls, uint8 floor);

Dir_t DSP_NextDirection(const Calls_t *calls, uint8 currentFloor, Dir_t currentDirection);

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction);
# 27 "main.c" 2

static char g_lcdFrame[(16U * 2U)];
static volatile uint8 g_emergencyStopTrip = 0U;

static void EmergencyStopCallback(void)
{
    g_emergencyStopTrip = 1U;
    HST_EmergencyStop();
}

static void System_Init(void)
{

    TIMER0_Init();
    INTERRUPT_EnableGlobal();



    SPI_InitMaster(1u);
    I2C_InitMaster(100000UL);
    TIMER0_DelayMS(10U);

    GPIO_SetPinDirection(2u, 2u, 1u);
    GPIO_SetPinDirection(2u, 3u, 1u);
    GPIO_SetPinDirection(2u, 4u, 1u);
    GPIO_SetPinDirection(2u, 5u, 1u);
    GPIO_SetPinDirection(2u, 7u, 1u);
    GPIO_SetPinValue(2u, 2u, 1u);
    GPIO_SetPinValue(2u, 3u, 0u);

    ADC_Init(1u, 6u);

    GPIO_SetPinDirection(3u, 2u, 2u);
    GPIO_SetPinDirection(3u, 3u, 2u);
    GPIO_SetPinDirection(3u, 6u, 2u);
    EXTI_SetSense(0u, 3u);
    EXTI_SetCallback(0u, EmergencyStopCallback);
    EXTI_Enable(0u);


    LCD_Init();
    HST_Init();
    DRV_Init();
    BUZ_Init();
    FL_Init();
    CONS_Init();
    CarFSM_Init();
    DoorFSM_Init();


    SEG_Show(0U, DIR_NONE);
}

static void Car_UpdateFromSensors(CarData_t *car)
{
    uint16 currentAdc;
    uint16 doorAdc;

    if (car == 
# 85 "main.c" 3 4
              ((void *)0)
# 85 "main.c"
                  )
    {
        return;
    }

    car->positionCm = POS_cm();
    car->loadKg = LOAD_ReadKg();
    if (ADC_ReadChannel(2u, &currentAdc) == E_OK)
    {

        car->currentmA = (uint16)(((uint32)currentAdc * 20000UL) / 1023UL);
    }
    else
    {
        car->currentmA = 0U;
    }
    car->currentFloor = POS_nearestFloor(car->positionCm);
    if (ADC_ReadChannel(3u, &doorAdc) == E_OK)
    {
        car->doorPct = (uint8)(((uint32)doorAdc * 100UL) / 1023UL);
    }
    else
    {
        car->doorPct = 0U;
    }
    car->doorState = DoorFSM_GetState();
    car->state = CarFSM_GetState();
    car->dir = (uint8)DIR_NONE;

}

static void UpdateCallBitmapFromHardware(CarData_t *car)
{
    uint16 buttonState;
    uint8 emergencyStopPin;
    uint8 fireServicePin;

    if (car == 
# 122 "main.c" 3 4
              ((void *)0)
# 122 "main.c"
                  )
    {
        return;
    }

    buttonState = BTN_Scan();
    car->independent = ((buttonState & (uint16)(1U << 7U)) != 0U) ? 1U : 0U;

    (void)GPIO_GetPinValue(3u, 2u, &emergencyStopPin);
    (void)GPIO_GetPinValue(3u, 6u, &fireServicePin);
    car->fireService = (fireServicePin == 0u) ? 1U : 0U;

    if (emergencyStopPin == 1u)
    {
        g_emergencyStopTrip = 1U;
        HST_EmergencyStop();
    }
    else
    {

        g_emergencyStopTrip = 0U;
    }

    for (uint8 btn = 0U; btn < 16U; btn++)
    {
        if (BTN_Pressed(btn) == 0U)
        {
            continue;
        }

        switch (btn)
        {
            case 0U:
            case 1U:
            case 2U:
            case 3U:
                (void)DSP_AddCall(&car->calls, btn, CALL_CAR);
                break;

            case 4U:
                DoorFSM_Open();
                break;

            case 5U:
                DoorFSM_Close();
                break;

            case 6U:
                car->estop = 1U;
                car->activeFault = FLT_ESTOP;
                HST_EmergencyStop();
                DRV_Stop();
                break;

            case 7U:

                car->independent = 1U;
                break;

            case 8U:
                (void)DSP_AddCall(&car->calls, 0U, CALL_HALL_UP);
                break;

            case 9U:
                (void)DSP_AddCall(&car->calls, 1U, CALL_HALL_UP);
                break;

            case 10U:
                (void)DSP_AddCall(&car->calls, 1U, CALL_HALL_DOWN);
                break;

            case 11U:
                (void)DSP_AddCall(&car->calls, 2U, CALL_HALL_UP);
                break;

            case 12U:
                (void)DSP_AddCall(&car->calls, 2U, CALL_HALL_DOWN);
                break;

            case 13U:
                (void)DSP_AddCall(&car->calls, 3U, CALL_HALL_DOWN);
                break;

            default:
                break;
        }
    }

    if (g_emergencyStopTrip != 0U)
    {
        car->estop = 1U;
        car->activeFault = FLT_ESTOP;
    }
    else
    {
        car->estop = 0U;
        if (car->activeFault == FLT_ESTOP)
        {
            car->activeFault = FLT_NONE;
        }
    }
}

static uint8 FindTargetFloor(const Calls_t *calls,
                             uint8 currentFloor,
                             Dir_t direction)
{
    uint8 floor;

    if (direction == DIR_UP)
    {
        for (floor = (uint8)(currentFloor + 1U);
             floor < 4u;
             floor++)
        {
            if (DSP_ShouldStop(calls, floor, DIR_UP) == E_OK)
            {
                return floor;
            }
        }
    }
    else if (direction == DIR_DOWN)
    {
        floor = currentFloor;
        while (floor > 0U)
        {
            floor--;
            if (DSP_ShouldStop(calls, floor, DIR_DOWN) == E_OK)
            {
                return floor;
            }
        }
    }

    return currentFloor;
}

int main(void)
{
    CarData_t car;
    uint16 tickCounter = 0U;
    uint8 faultBlink = 0U;
    uint8 previousLevelled = 0U;
    uint8 fireRecallStarted = 0U;
    uint8 chimeTicks = 0U;
    Dir_t currentDir = DIR_NONE;

    memset(&car, 0, sizeof(car));
    System_Init();

    while (1)
    {
        if (systemTicks10ms == 1U)
        {
            systemTicks10ms = 0U;
            tickCounter++;

            Car_UpdateFromSensors(&car);
            UpdateCallBitmapFromHardware(&car);
            {
                uint8 obstructionPin;

                (void)GPIO_GetPinValue(3u,
                                       3u,
                                       &obstructionPin);
                DoorFSM_UpdatePosition(obstructionPin == 0u ? 1U : 0U,
                                       car.doorPct);
                car.doorState = DoorFSM_GetState();
                if (car.doorState == DOOR_STATE_CLOSED)
                {
                    DRV_Stop();
                }
            }

            if (car.fireService != 0U)
            {

                car.calls.carCall = 0U;
                car.calls.hallUp = 0U;
                car.calls.hallDown = 0U;
                if (car.currentFloor != 0U &&
                    car.doorState == DOOR_STATE_CLOSED &&
                    car.estop == 0U)
                {
                    currentDir = DIR_DOWN;
                    if (fireRecallStarted == 0U)
                    {
                        car.targetFloor = 0U;
                        car.levelled = 0U;
                        (void)MOT_GoTo(0U, car.positionCm);
                        fireRecallStarted = 1U;
                    }
                }
                else
                {
                    MOT_Stop();
                    car.dir = (uint8)DIR_NONE;
                    currentDir = DIR_NONE;
                    if (car.currentFloor == 0U && car.estop == 0U &&
                        car.doorState == DOOR_STATE_CLOSED)
                    {
                        DoorFSM_Open();
                    }
                }
            }
            else if (car.estop != 0U || car.doorState != DOOR_STATE_CLOSED)
            {
                fireRecallStarted = 0U;
                currentDir = DIR_NONE;
                car.dir = (uint8)DIR_NONE;
                MOT_Stop();
            }
            else
            {
                fireRecallStarted = 0U;
                if (DSP_ShouldStop(&car.calls,
                                   car.currentFloor,
                                   currentDir) == E_OK)
                {
                    (void)DSP_ClearFloor(&car.calls, car.currentFloor);
                    MOT_Stop();
                    currentDir = DIR_NONE;
                    car.targetFloor = car.currentFloor;
                }

                currentDir = DSP_NextDirection(&car.calls,
                                               car.currentFloor,
                                               currentDir);

                if (currentDir != DIR_NONE)
                {
                    uint8 targetFloor = FindTargetFloor(&car.calls,
                                                        car.currentFloor,
                                                        currentDir);

                    if (targetFloor != car.currentFloor)
                    {
                        if (targetFloor != car.targetFloor ||
                            car.levelled != 0U)
                        {
                            car.targetFloor = targetFloor;
                            car.levelled = 0U;
                            (void)MOT_GoTo(targetFloor, car.positionCm);
                        }
                    }
                }
                else
                {
                    car.dir = (uint8)DIR_NONE;
                    MOT_Stop();
                }

                car.dir = (uint8)currentDir;
            }
            SAF_Evaluate(&car);
            MOT_Step(&car);

            if (car.estop != 0U || car.fireService != 0U ||
                car.activeFault != FLT_NONE)
            {
                chimeTicks = 0U;
                BUZ_Alarm();
            }
            else if (car.levelled != 0U && previousLevelled == 0U)
            {
                BUZ_Chime();
                chimeTicks = 10U;
            }
            else if (chimeTicks != 0U)
            {
                chimeTicks--;
                if (chimeTicks == 0U)
                {
                    BUZ_Stop();
                }
            }
            else
            {
                BUZ_Stop();
            }

            previousLevelled = car.levelled;

            if ((tickCounter % 25U) == 0U)
            {
                faultBlink = (faultBlink == 0U) ? 1U : 0U;
                SEG_Show(car.currentFloor, (Dir_t)car.dir);
                LCD_UpdateFrame(g_lcdFrame,
                                car.currentFloor,
                                (Dir_t)car.dir,
                                car.positionCm,
                                car.loadKg,
                                car.activeFault,
                                (DoorState_t)car.doorState,
                                faultBlink);
            }

            if ((tickCounter % 200U) == 0U)
            {
                CONS_SendTelemetry();
            }

            CONS_Task();
        }
    }

    return 0;
}
