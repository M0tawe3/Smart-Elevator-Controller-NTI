# 0 "HAL/Door/Door.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Door/Door.c"
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 1 3
# 99 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/sfr_defs.h" 1 3
# 126 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/sfr_defs.h" 3
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/inttypes.h" 1 3
# 37 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/inttypes.h" 3
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stdint.h" 1 3 4
# 9 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 1 3 4
# 125 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 38 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/inttypes.h" 2 3
# 77 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 127 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/sfr_defs.h" 2 3
# 100 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3
# 230 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/iom32.h" 1 3
# 720 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/iom32.h" 3
       
# 721 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3
# 785 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/portpins.h" 1 3
# 786 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/common.h" 1 3
# 788 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/version.h" 1 3
# 790 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3






# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/fuse.h" 1 3
# 248 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 797 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3


# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/lock.h" 1 3
# 800 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/avr/include/avr/io.h" 2 3
# 2 "HAL/Door/Door.c" 2
# 1 "HAL/Door/Door.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
# 1 "C:/avr-gcc/avr8-gnu-toolchain-win32_x86_64/lib/gcc/avr/15.1.0/include/stddef.h" 1 3 4
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

    
# 20 "HAL/Door/Door.c" 3
   (*(volatile uint8_t *)((0x2F) + 0x20)) 
# 20 "HAL/Door/Door.c"
          = (1U << 
# 20 "HAL/Door/Door.c" 3
                   5
# 20 "HAL/Door/Door.c"
                         ) | (1U << 
# 20 "HAL/Door/Door.c" 3
                                    1
# 20 "HAL/Door/Door.c"
                                         );
    
# 21 "HAL/Door/Door.c" 3
   (*(volatile uint8_t *)((0x2E) + 0x20)) 
# 21 "HAL/Door/Door.c"
          = (1U << 
# 21 "HAL/Door/Door.c" 3
                   4
# 21 "HAL/Door/Door.c"
                        ) | (1U << 
# 21 "HAL/Door/Door.c" 3
                                   3
# 21 "HAL/Door/Door.c"
                                        ) | (1U << 
# 21 "HAL/Door/Door.c" 3
                                                   0
# 21 "HAL/Door/Door.c"
                                                       );
    
# 22 "HAL/Door/Door.c" 3
   (*(volatile uint16_t *)((0x26) + 0x20)) 
# 22 "HAL/Door/Door.c"
        = 799U;
    
# 23 "HAL/Door/Door.c" 3
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
    
# 52 "HAL/Door/Door.c" 3
   (*(volatile uint16_t *)((0x28) + 0x20)) 
# 52 "HAL/Door/Door.c"
         = (uint16)compareVal;
}

void DRV_Stop(void)
{
    
# 57 "HAL/Door/Door.c" 3
   (*(volatile uint16_t *)((0x28) + 0x20)) 
# 57 "HAL/Door/Door.c"
         = 0U;
    GPIO_SetPinValue(1u, 2u, 0u);
    GPIO_SetPinValue(1u, 3u, 0u);
}
