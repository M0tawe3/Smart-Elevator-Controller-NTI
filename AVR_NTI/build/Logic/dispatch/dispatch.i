# 0 "Logic/dispatch/dispatch.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/dispatch/dispatch.c"
# 1 "Logic/dispatch/dispatch.h" 1



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
# 5 "Logic/dispatch/dispatch.h" 2




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

STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type);

STD_ReturnType DSP_ClearFloor(Calls_t *calls, uint8 floor);

Dir_t DSP_NextDirection(const Calls_t *calls, uint8 currentFloor, Dir_t currentDirection);

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction);
# 2 "Logic/dispatch/dispatch.c" 2

static uint8 callsAbove(const Calls_t *calls, uint8 floor)
{
 uint8 allCalls;
 uint8 mask;

 if (calls == 
# 8 "Logic/dispatch/dispatch.c" 3 4
             ((void *)0) 
# 8 "Logic/dispatch/dispatch.c"
                  || floor >= (4u -1))
 {
  return 0U;
 }

 allCalls = (uint8)(calls->carCall | calls->hallUp | calls->hallDown);
 mask = (uint8)(0x0Fu & (uint8)(0xFFU << (floor + 1U)));
 return (uint8)(allCalls & mask);
}

static uint8 callsBelow(const Calls_t *calls, uint8 floor)
{
 uint8 allCalls;
 uint8 mask;

 if (calls == 
# 23 "Logic/dispatch/dispatch.c" 3 4
             ((void *)0) 
# 23 "Logic/dispatch/dispatch.c"
                  || floor >= 4u || floor == 0U)
 {
  return 0U;
 }

 allCalls = (uint8)(calls->carCall | calls->hallUp | calls->hallDown);
 mask = (uint8)((1U << floor) - 1U);
 return (uint8)(allCalls & mask);
}

static uint8 shouldStop(const Calls_t *c, uint8 f, Dir_t d)
{
    if (c->carCall & (1u << f)) return 1;
    if (d == DIR_UP && (c->hallUp & (1u << f))) return 1;
    if (d == DIR_DOWN && (c->hallDown & (1u << f))) return 1;


    if (d == DIR_UP && (c->hallDown & (1u << f)) && !callsAbove(c, f)) return 1;
    if (d == DIR_DOWN && (c->hallUp & (1u << f)) && !callsBelow(c, f)) return 1;
    return 0;
}

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction)
{
 if (calls == 
# 47 "Logic/dispatch/dispatch.c" 3 4
             ((void *)0) 
# 47 "Logic/dispatch/dispatch.c"
                  || floor >= 4u)
 {
  return E_NOK;
 }

 return (shouldStop(calls, floor, direction) != 0U) ? E_OK : E_NOK;
}

STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type)
{
 uint8 floorBit;

 if (calls == 
# 59 "Logic/dispatch/dispatch.c" 3 4
             ((void *)0) 
# 59 "Logic/dispatch/dispatch.c"
                  || floor >= 4u)
 {
  return E_NOK;
 }

 floorBit = (uint8)(1U << floor);

 switch (type)
 {
  case CALL_CAR:
   calls->carCall |= floorBit;
   break;

  case CALL_HALL_UP:
   calls->hallUp |= floorBit;
   break;

  case CALL_HALL_DOWN:
   calls->hallDown |= floorBit;
   break;

  default:
   return E_NOK;
 }

 return E_OK;
}

STD_ReturnType DSP_ClearFloor(Calls_t *calls, uint8 floor)
{
 uint8 floorBit;

 if (calls == 
# 91 "Logic/dispatch/dispatch.c" 3 4
             ((void *)0) 
# 91 "Logic/dispatch/dispatch.c"
                  || floor >= 4u)
 {
  return E_NOK;
 }

 floorBit = (uint8)(1U << floor);
 calls->carCall &= (uint8)~floorBit;
 calls->hallUp &= (uint8)~floorBit;
 calls->hallDown &= (uint8)~floorBit;

    return E_OK;
}

Dir_t DSP_NextDirection(const Calls_t *c, uint8 f, Dir_t current)
{
    if (current == DIR_UP) { if (callsAbove(c, f)) return DIR_UP;
                               if (callsBelow(c, f)) return DIR_DOWN; }
    if (current == DIR_DOWN) { if (callsBelow(c, f)) return DIR_DOWN;
                               if (callsAbove(c, f)) return DIR_UP; }
    if (callsAbove(c, f)) return DIR_UP;
    if (callsBelow(c, f)) return DIR_DOWN;
    return DIR_NONE;
}
