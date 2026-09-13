# 0 "MCAL/INTERRUPT/INTERRUPT.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/INTERRUPT/INTERRUPT.c"
# 9 "MCAL/INTERRUPT/INTERRUPT.c"
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
# 10 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 30 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void));
# 11 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_private.h" 1
# 12 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "/usr/avr/sys-root/include/avr/interrupt.h" 1 3 4
# 38 "/usr/avr/sys-root/include/avr/interrupt.h" 3 4
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
# 39 "/usr/avr/sys-root/include/avr/interrupt.h" 2 3 4
# 13 "MCAL/INTERRUPT/INTERRUPT.c" 2


# 14 "MCAL/INTERRUPT/INTERRUPT.c"
static void (*EXTI_Callbacks[3])(void) = {
# 14 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                         ((void *)0)
# 14 "MCAL/INTERRUPT/INTERRUPT.c"
                                             , 
# 14 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                               ((void *)0)
# 14 "MCAL/INTERRUPT/INTERRUPT.c"
                                                   , 
# 14 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                                     ((void *)0)
# 14 "MCAL/INTERRUPT/INTERRUPT.c"
                                                         };
# 23 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType INTERRUPT_EnableGlobal(void)
{
    (((*(volatile uint8 *)0x5F)) |= (1u << (7)));
    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void)
{
    (((*(volatile uint8 *)0x5F)) &= ~(1u << (7)));
    return E_OK;
}
# 43 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense)
{
    switch (Copy_u8Int)
    {
    case 0u:
        (*(volatile uint8 *)0x55) |= (Copy_u8Sense & 0x03);
        return E_OK;
    case 1u:
        (*(volatile uint8 *)0x55) |= ((Copy_u8Sense & 0x03) << 2);
        return E_OK;
    case 2u:
        if (Copy_u8Sense == 2u)
        {
            (((*(volatile uint8 *)0x54)) &= ~(1u << (
# 56 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
           6
# 56 "MCAL/INTERRUPT/INTERRUPT.c"
           )));
            return E_OK;
        }
        else if (Copy_u8Sense == 3u)
        {
            (((*(volatile uint8 *)0x54)) |= (1u << (
# 61 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
           6
# 61 "MCAL/INTERRUPT/INTERRUPT.c"
           )));
            return E_OK;
        }
        else
            return E_NOK;

    default:
        return E_NOK;
    }
}
# 91 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case 0u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 96 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       6
# 96 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 1u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 99 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       7
# 99 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 2u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 102 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       5
# 102 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    default:
        return E_NOK;
    }
}
# 118 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_Enable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case 0u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 123 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       6
# 123 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        (((*(volatile uint8 *)0x5B)) |= (1u << (
# 124 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       6
# 124 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 1u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 127 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       7
# 127 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        (((*(volatile uint8 *)0x5B)) |= (1u << (
# 128 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       7
# 128 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 2u:
        (((*(volatile uint8 *)0x5A)) |= (1u << (
# 131 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       5
# 131 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        (((*(volatile uint8 *)0x5B)) |= (1u << (
# 132 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       5
# 132 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    default:
        return E_NOK;
    }
}

STD_ReturnType EXTI_Disable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case 0u:
        (((*(volatile uint8 *)0x5B)) &= ~(1u << (
# 144 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       6
# 144 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 1u:
        (((*(volatile uint8 *)0x5B)) &= ~(1u << (
# 147 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       7
# 147 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    case 2u:
        (((*(volatile uint8 *)0x5B)) &= ~(1u << (
# 150 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
       5
# 150 "MCAL/INTERRUPT/INTERRUPT.c"
       )));
        return E_OK;
    default:
        return E_NOK;
    }
}

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void))
{
    if (Copy_u8Int < 3)
    {
        EXTI_Callbacks[Copy_u8Int] = Copy_pfCallback;
        return E_OK;
    }
    else
        return E_NOK;
}








# 174 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
void __vector_1 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_1 (void)

# 175 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_Callbacks[0u] != 
# 176 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                    ((void *)0)
# 176 "MCAL/INTERRUPT/INTERRUPT.c"
                                        )
    {
        EXTI_Callbacks[0u]();
    }
}


# 182 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
void __vector_2 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_2 (void)

# 183 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_Callbacks[1u] != 
# 184 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                    ((void *)0)
# 184 "MCAL/INTERRUPT/INTERRUPT.c"
                                        )
    {
        EXTI_Callbacks[1u]();
    }
}


# 190 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
void __vector_3 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_3 (void)

# 191 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_Callbacks[2u] != 
# 192 "MCAL/INTERRUPT/INTERRUPT.c" 3 4
                                    ((void *)0)
# 192 "MCAL/INTERRUPT/INTERRUPT.c"
                                        )
    {
        EXTI_Callbacks[2u]();
    }
}
