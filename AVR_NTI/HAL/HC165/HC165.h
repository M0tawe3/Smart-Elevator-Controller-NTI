#ifndef _HC165_H_
#define _HC165_H_

#include "STD_TYPES.h"

/* Call BTN_Scan() every 50 ms to update the debounced button state. */
uint16 BTN_Scan(void);

/* Return one for a newly pressed button bit, then consume that event. */
uint8 BTN_Pressed(uint8 n);

#endif /* _HC165_H_ */