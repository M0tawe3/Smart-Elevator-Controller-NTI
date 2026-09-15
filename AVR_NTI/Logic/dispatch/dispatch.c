#include "dispatch.h"

static uint8 callsAbove(const Calls_t *calls, uint8 floor)
{
	uint8 allCalls;
	uint8 mask;

	if (calls == NULL || floor >= (FLOOR_COUNT-1))
	{
		return 0U;
	}

	allCalls = (uint8)(calls->carCall | calls->hallUp | calls->hallDown);
	mask = (uint8)(FLOOR_MASK & (uint8)(0xFFU << (floor + 1U)));
	return (uint8)(allCalls & mask);
}

static uint8 callsBelow(const Calls_t *calls, uint8 floor)
{
	uint8 allCalls;
	uint8 mask;

	if (calls == NULL || floor >= FLOOR_COUNT || floor == 0U)
	{
		return 0U;
	}

	allCalls = (uint8)(calls->carCall | calls->hallUp | calls->hallDown);
	mask = (uint8)((1U << floor) - 1U);
	return (uint8)(allCalls & mask);
}

static uint8 shouldStop(const Calls_t *c, uint8 f, Dir_t d)
{
    if (c->carCall & (1u << f))                   return 1;
    if (d == DIR_UP   && (c->hallUp   & (1u << f))) return 1;
    if (d == DIR_DOWN && (c->hallDown & (1u << f))) return 1;
    /* opposite-direction hall call: serve it only if it is the last call
       in this direction — this is the subtle part of LOOK */
    if (d == DIR_UP   && (c->hallDown & (1u << f)) && !callsAbove(c, f)) return 1;
    if (d == DIR_DOWN && (c->hallUp   & (1u << f)) && !callsBelow(c, f)) return 1;
    return 0;
}

STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction)
{
	if (calls == NULL || floor >= FLOOR_COUNT)
	{
		return E_NOK;
	}

	return (shouldStop(calls, floor, direction) != 0U) ? E_OK : E_NOK;
}

STD_ReturnType DSP_AddCall(Calls_t *calls, uint8 floor, CallType_t type)
{
	uint8 floorBit;

	if (calls == NULL || floor >= FLOOR_COUNT)
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

	if (calls == NULL || floor >= FLOOR_COUNT)
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
    if (current == DIR_UP)   { if (callsAbove(c, f)) return DIR_UP;
                               if (callsBelow(c, f)) return DIR_DOWN; }
    if (current == DIR_DOWN) { if (callsBelow(c, f)) return DIR_DOWN;
                               if (callsAbove(c, f)) return DIR_UP;   }
    if (callsAbove(c, f)) return DIR_UP;
    if (callsBelow(c, f)) return DIR_DOWN;
    return DIR_NONE;
}

// STD_ReturnType DSP_ShouldStop(const Calls_t *calls, uint8 floor, Dir_t direction)
// {
// 	uint8 floorBit;

// 	if (calls == NULL || floor >= FLOOR_COUNT)
// 	{
// 		return E_NOK;
// 	}

// 	floorBit = (uint8)(1U << floor);

// 	if ((calls->carCall & floorBit) != 0U)
// 	{
// 		return E_OK;
// 	}

// 	if (direction == DIR_UP)
// 	{
// 		if ((calls->hallUp & floorBit) != 0U)
// 		{
// 			return E_OK;
// 		}

// 		if ((calls->hallDown & floorBit) != 0U && callsAbove(calls, floor) == 0U)
// 		{
// 			return E_OK;
// 		}
// 	}
// 	else if (direction == DIR_DOWN)
// 	{
// 		if ((calls->hallDown & floorBit) != 0U)
// 		{
// 			return E_OK;
// 		}

// 		if ((calls->hallUp & floorBit) != 0U && callsBelow(calls, floor) == 0U)
// 		{
// 			return E_OK;
// 		}
// 	}

// 	return E_NOK;
// }