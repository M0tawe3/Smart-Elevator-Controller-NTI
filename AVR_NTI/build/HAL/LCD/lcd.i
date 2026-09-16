# 0 "HAL/LCD/lcd.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/LCD/lcd.c"
# 1 "HAL/LCD/lcd.h" 1



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
    uint8_t currentFloor;
    uint8_t targetFloor;
    uint8_t doorPct;
    uint16_t loadKg;
    uint16_t currentmA;
    Calls_t calls;
    uint8_t dir;
    uint8_t lastDir;
    uint8_t state;
    uint8_t doorState;
    uint8_t hoistDuty;
    uint8_t overload : 1;
    uint8_t fireService : 1;
    uint8_t independent : 1;
    uint8_t estop : 1;
    uint8_t obstruction : 1;
    uint8_t levelled : 1;
    uint8_t reserved : 2;
    uint8_t activeFault;
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
# 5 "HAL/LCD/lcd.h" 2

void LCD_Init();

STD_ReturnType LCD_WriteData(uint8 byte);

void LCD_Update(uint8 floor, Dir_t dir, uint16 load);
# 2 "HAL/LCD/lcd.c" 2
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
# 3 "HAL/LCD/lcd.c" 2
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
# 4 "HAL/LCD/lcd.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 5 "HAL/LCD/lcd.c" 2
# 19 "HAL/LCD/lcd.c"
void Debug_Fail(){
    GPIO_SetPinValue(3u, 7u, 1u);
}

static STD_ReturnType LCD_Command(uint8 command)
{
    STD_ReturnType result = I2C_SendStart();
    if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(0x3EU);
    if (result == E_OK) result = I2C_SendByte(0x00U);
    if (result == E_OK) result = I2C_SendByte(command);
    I2C_SendStop();
    return result;
}

void LCD_Init(){
    if (LCD_Command(0x20U | 0x10U | 0x08U) != E_OK) Debug_Fail();

    if (LCD_Command(0x20U | 0x10U | 0x08U) != E_OK) Debug_Fail();


    if (LCD_Command(0x08U | 0x04U) != E_OK) Debug_Fail();
    if (LCD_Command(0x01U) != E_OK) Debug_Fail();

    if (LCD_Command(0x04U | 0x02U) != E_OK) Debug_Fail();
    if (LCD_Command(0x02U) != E_OK) Debug_Fail();

}

STD_ReturnType LCD_WriteData(uint8 data)
{
    STD_ReturnType result = I2C_SendStart();
    if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(0x3EU);
    if (result == E_OK) result = I2C_SendByte(0x40U);
    if (result == E_OK) result = I2C_SendByte(data);
    I2C_SendStop();
    return result;
}

void LCD_Update(uint8 floor, Dir_t dir, uint16 load){
    LCD_WriteData('F');
    TIMER0_DelayMS(1);
    LCD_WriteData('L');
    TIMER0_DelayMS(1);
    LCD_WriteData(floor+48);
    TIMER0_DelayMS(1);
    LCD_WriteData(' ');
    TIMER0_DelayMS(1);
    switch(dir){
        case DIR_DOWN:
        LCD_WriteData('v');
        break;
        case DIR_UP:
        LCD_WriteData('^');
        break;
        default:
        LCD_WriteData('-');
    }
    TIMER0_DelayMS(1);

}
