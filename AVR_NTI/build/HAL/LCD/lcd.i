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
# 5 "HAL/LCD/lcd.h" 2





void LCD_Init(void);
STD_ReturnType LCD_WriteData(uint8 byte);
void LCD_Update(const char *frame);
void LCD_RefreshPartial(const char *newFrame);
void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive,DoorState_t door, uint8 faultBlinkOn);
# 2 "HAL/LCD/lcd.c" 2
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
# 3 "HAL/LCD/lcd.c" 2
# 1 "/usr/avr/sys-root/include/stdio.h" 1 3 4
# 44 "/usr/avr/sys-root/include/stdio.h" 3 4
# 1 "/usr/avr/sys-root/include/inttypes.h" 1 3 4
# 77 "/usr/avr/sys-root/include/inttypes.h" 3 4
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 45 "/usr/avr/sys-root/include/stdio.h" 2 3 4
# 1 "/usr/lib64/gcc/avr/15/include/stdarg.h" 1 3 4
# 40 "/usr/lib64/gcc/avr/15/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 103 "/usr/lib64/gcc/avr/15/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 46 "/usr/avr/sys-root/include/stdio.h" 2 3 4




# 1 "/usr/lib64/gcc/avr/15/include/stddef.h" 1 3 4
# 51 "/usr/avr/sys-root/include/stdio.h" 2 3 4
# 244 "/usr/avr/sys-root/include/stdio.h" 3 4
struct __file {
 char *buf;
 unsigned char unget;
 uint8_t flags;
# 263 "/usr/avr/sys-root/include/stdio.h" 3 4
 int size;
 int len;
 int (*put)(char, struct __file *);
 int (*get)(struct __file *);
 void *udata;
};
# 277 "/usr/avr/sys-root/include/stdio.h" 3 4
typedef struct __file FILE;
# 407 "/usr/avr/sys-root/include/stdio.h" 3 4
extern struct __file *__iob[];
# 419 "/usr/avr/sys-root/include/stdio.h" 3 4
extern FILE *fdevopen(int (*__put)(char, FILE*), int (*__get)(FILE*));
# 436 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int fclose(FILE *__stream);
# 610 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int vfprintf(FILE *__stream, const char *__fmt, va_list __ap);





extern int vfprintf_P(FILE *__stream, const char *__fmt, va_list __ap);






extern int fputc(int __c, FILE *__stream);




extern int putc(int __c, FILE *__stream);


extern int putchar(int __c);
# 651 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int printf(const char *__fmt, ...);





extern int printf_P(const char *__fmt, ...);







extern int vprintf(const char *__fmt, va_list __ap);





extern int sprintf(char *__s, const char *__fmt, ...);





extern int sprintf_P(char *__s, const char *__fmt, ...);
# 687 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int snprintf(char *__s, size_t __n, const char *__fmt, ...);





extern int snprintf_P(char *__s, size_t __n, const char *__fmt, ...);





extern int vsprintf(char *__s, const char *__fmt, va_list ap);





extern int vsprintf_P(char *__s, const char *__fmt, va_list ap);
# 715 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int vsnprintf(char *__s, size_t __n, const char *__fmt, va_list ap);





extern int vsnprintf_P(char *__s, size_t __n, const char *__fmt, va_list ap);




extern int fprintf(FILE *__stream, const char *__fmt, ...);





extern int fprintf_P(FILE *__stream, const char *__fmt, ...);






extern int fputs(const char *__str, FILE *__stream);




extern int fputs_P(const char *__str, FILE *__stream);





extern int puts(const char *__str);




extern int puts_P(const char *__str);
# 764 "/usr/avr/sys-root/include/stdio.h" 3 4
extern size_t fwrite(const void *__ptr, size_t __size, size_t __nmemb,
         FILE *__stream);







extern int fgetc(FILE *__stream);




extern int getc(FILE *__stream);


extern int getchar(void);
# 812 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int ungetc(int __c, FILE *__stream);
# 824 "/usr/avr/sys-root/include/stdio.h" 3 4
extern char *fgets(char *__str, int __size, FILE *__stream);






extern char *gets(char *__str);
# 842 "/usr/avr/sys-root/include/stdio.h" 3 4
extern size_t fread(void *__ptr, size_t __size, size_t __nmemb,
        FILE *__stream);




extern void clearerr(FILE *__stream);
# 859 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int feof(FILE *__stream);
# 870 "/usr/avr/sys-root/include/stdio.h" 3 4
extern int ferror(FILE *__stream);






extern int vfscanf(FILE *__stream, const char *__fmt, va_list __ap);




extern int vfscanf_P(FILE *__stream, const char *__fmt, va_list __ap);







extern int fscanf(FILE *__stream, const char *__fmt, ...);




extern int fscanf_P(FILE *__stream, const char *__fmt, ...);






extern int scanf(const char *__fmt, ...);




extern int scanf_P(const char *__fmt, ...);







extern int vscanf(const char *__fmt, va_list __ap);







extern int sscanf(const char *__buf, const char *__fmt, ...);




extern int sscanf_P(const char *__buf, const char *__fmt, ...);
# 940 "/usr/avr/sys-root/include/stdio.h" 3 4
static __inline__ int fflush(FILE *stream __attribute__((unused)))
{
 return 0;
}






__extension__ typedef long long fpos_t;
extern int fgetpos(FILE *stream, fpos_t *pos);
extern FILE *fopen(const char *path, const char *mode);
extern FILE *freopen(const char *path, const char *mode, FILE *stream);
extern FILE *fdopen(int, const char *);
extern int fseek(FILE *stream, long offset, int whence);
extern int fsetpos(FILE *stream, fpos_t *pos);
extern long ftell(FILE *stream);
extern int fileno(FILE *);
extern void perror(const char *s);
extern int remove(const char *pathname);
extern int rename(const char *oldpath, const char *newpath);
extern void rewind(FILE *stream);
extern void setbuf(FILE *stream, char *buf);
extern int setvbuf(FILE *stream, char *buf, int mode, size_t size);
extern FILE *tmpfile(void);
extern char *tmpnam (char *s);
# 4 "HAL/LCD/lcd.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"

# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 5 "HAL/LCD/lcd.c" 2
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
# 6 "HAL/LCD/lcd.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 7 "HAL/LCD/lcd.c" 2
# 21 "HAL/LCD/lcd.c"
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

void LCD_Update(const char* frame){
    STD_ReturnType result = I2C_SendStart();
    if (result == E_OK) result = I2C_SendSlaveAddressWithWrite(0x3EU);
    if (result == E_OK) result = I2C_SendByte(0x40U);

    uint8 i = 0;
    while(frame[i] != '\0'){
        if (result == E_OK) result = I2C_SendByte(frame[i]);
        i++;
    }
    I2C_SendStop();

}

static char g_lcdBuf[(16U * 2U)];
static char g_lcdPrev[(16U * 2U)];

static void LCD_SetCursor(uint8 row, uint8 col)
{
    uint8 addr = (row == 0U) ? (uint8)col : (uint8)(0x40U + col);
    LCD_Command(0x80U | addr);
}

static void LCD_WriteCharAt(uint8 row, uint8 col, char ch)
{
    LCD_SetCursor(row, col);
    TIMER0_DelayMS(1U);
    LCD_WriteData((uint8)ch);
}

void LCD_RefreshPartial(const char *newFrame)
{
    for (uint8 i = 0; i < (16U * 2U); i++)
    {
        if (g_lcdPrev[i] != newFrame[i])
        {
            uint8 row = (i < 16U) ? 0U : 1U;
            uint8 col = (i < 16U) ? i : (i - 16U);

            LCD_WriteCharAt(row, col, newFrame[i]);
            g_lcdPrev[i] = newFrame[i];
        }
    }
}

void LCD_UpdateFrame(char *frame, uint8 floor, Dir_t dir, uint16 positionCm, uint16 loadKg,
                    Fault_t faultActive, DoorState_t door, uint8 faultBlinkOn)
{
    char line1[16U + 1U];
    char line2[16U + 1U];
    char dirChar = '-';

    if (frame == 
# 111 "HAL/LCD/lcd.c" 3 4
                ((void *)0)
# 111 "HAL/LCD/lcd.c"
                    )
    {
        return;
    }

    switch (dir)
    {
        case DIR_UP:
            dirChar = '^';
            break;
        case DIR_DOWN:
            dirChar = 'v';
            break;
        default:
            dirChar = '-';
            break;
    }

    memset(line1, ' ', sizeof(line1));
    memset(line2, ' ', sizeof(line2));
    line1[16U] = '\0';
    line2[16U] = '\0';

    snprintf(line1, sizeof(line1), "FL%u %c P:%ucm", (unsigned int)floor, dirChar, (unsigned int)positionCm);

    switch(faultActive)
    {
        case FLT_OVERLOAD:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!OVERLOAD %u", (unsigned int)loadKg);
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u STOP", (unsigned int)loadKg, door);
        break;

        case FLT_ESTOP:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!EMERGENCY STOP");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_OVERTRAVEL:
        if (faultBlinkOn < 150)
            snprintf(line2, sizeof(line2), "!OVERTRAVEL");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_OVERCURRENT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!OVERCURRENT");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_TRAVEL_TIMEOUT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!TRAVEL TIMEOUT");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_DOOR_TIMEOUT:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!DOOR TIMEOUT");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_DOOR_JAM:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!DOOR JAM");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_POSITION_SENSOR:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!POSITION SENSOR");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        case FLT_LEVEL_FAIL:
        if (faultBlinkOn != 0U)
            snprintf(line2, sizeof(line2), "!LEVEL FAIL");
        else
            snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
        break;

        default:
        snprintf(line2, sizeof(line2), "LD:%u D:%u MOV", (unsigned int)loadKg, door);
    }
    memset(frame, ' ', (16U * 2U));
    memcpy(&frame[0], line1, 16U);
    memcpy(&frame[16U], line2, 16U);

    LCD_RefreshPartial(frame);
}
