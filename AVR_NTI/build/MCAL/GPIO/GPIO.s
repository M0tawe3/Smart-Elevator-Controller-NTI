	.file	"GPIO.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.GPIO_SetPinDirection,"ax",@progbits
.global	GPIO_SetPinDirection
	.type	GPIO_SetPinDirection, @function
GPIO_SetPinDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L12
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L12
	cpi r24,lo8(2)
	breq .L9
	cpi r24,lo8(3)
	breq .L10
	cpi r24,lo8(1)
	breq .L11
	ldi r26,lo8(58)
	ldi r27,0
	ldi r30,lo8(59)
	ldi r31,0
.L3:
	cpi r20,lo8(1)
	breq .L4
	cpi r20,lo8(2)
	breq .L5
	cpse r20,__zero_reg__
	rjmp .L12
	ld r18,X
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r18,r24
	st X,r18
	ld r25,Z
	and r24,r25
.L13:
	st Z,r24
.L6:
	ldi r24,0
	ldi r25,0
	ret
.L9:
	ldi r26,lo8(52)
	ldi r27,0
	ldi r30,lo8(53)
	ldi r31,0
	rjmp .L3
.L10:
	ldi r26,lo8(49)
	ldi r27,0
	ldi r30,lo8(50)
	ldi r31,0
	rjmp .L3
.L11:
	ldi r26,lo8(55)
	ldi r27,0
	ldi r30,lo8(56)
	ldi r31,0
	rjmp .L3
.L4:
	ld r18,X
	ldi r24,lo8(1)
	ldi r25,0
	movw r20,r24
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	mov r22,r20
	or r18,r20
	st X,r18
	ld r24,Z
	com r22
	and r22,r24
	st Z,r22
	rjmp .L6
.L5:
	ld r18,X
	ldi r24,lo8(1)
	ldi r25,0
	movw r20,r24
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	mov r24,r20
	com r24
	and r24,r18
	st X,r24
	ld r24,Z
	or r24,r20
	rjmp .L13
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPinDirection, .-GPIO_SetPinDirection
	.section	.text.GPIO_SetPinValue,"ax",@progbits
.global	GPIO_SetPinValue
	.type	GPIO_SetPinValue, @function
GPIO_SetPinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L29
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L29
	cpi r24,lo8(2)
	breq .L16
	cpi r24,lo8(3)
	brne .+2
	rjmp .L17
	cpi r24,lo8(1)
	breq .L18
	cpi r20,lo8(1)
	brne .L19
	in r24,0x1b
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L30:
	out 0x1b,r24
.L20:
	ldi r24,0
	ldi r25,0
	ret
.L19:
	brlo .+2
	rjmp .L29
	in r18,0x1b
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
	rjmp .L30
.L18:
	cpi r20,lo8(1)
	brne .L21
	in r24,0x18
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L32:
	out 0x18,r24
	rjmp .L20
.L21:
	brsh .L29
	in r18,0x18
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
	rjmp .L32
.L16:
	cpi r20,lo8(1)
	brne .L22
	in r24,0x15
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L31:
	out 0x15,r24
	rjmp .L20
.L22:
	brsh .L29
	in r18,0x15
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
	rjmp .L31
.L17:
	cpi r20,lo8(1)
	brne .L23
	in r24,0x12
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L33:
	out 0x12,r24
	rjmp .L20
.L23:
	brsh .L29
	in r18,0x12
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
	rjmp .L33
.L29:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPinValue, .-GPIO_SetPinValue
	.section	.text.GPIO_GetPinValue,"ax",@progbits
.global	GPIO_GetPinValue
	.type	GPIO_GetPinValue, @function
GPIO_GetPinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r20
	cpi r24,lo8(4)
	brsh .L42
	cpi r22,lo8(8)
	brsh .L42
	sbiw r30,0
	breq .L42
	cpi r24,lo8(2)
	breq .L36
	cpi r24,lo8(3)
	breq .L37
	cpi r24,lo8(1)
	breq .L38
	in r24,0x19
.L43:
	ldi r25,0
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r22
	brpl 1b
	andi r24,lo8(1)
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L38:
	in r24,0x16
	rjmp .L43
.L36:
	in r24,0x13
	rjmp .L43
.L37:
	in r24,0x10
	rjmp .L43
.L42:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPinValue, .-GPIO_GetPinValue
	.section	.text.GPIO_TogglePinValue,"ax",@progbits
.global	GPIO_TogglePinValue
	.type	GPIO_TogglePinValue, @function
GPIO_TogglePinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L51
	cpi r22,lo8(8)
	brsh .L51
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L46
	cpi r24,lo8(3)
	breq .L47
	cpi r24,lo8(1)
	breq .L48
	in r24,0x1b
	eor r24,r20
	out 0x1b,r24
.L49:
	ldi r24,0
	ldi r25,0
	ret
.L48:
	in r24,0x18
	eor r24,r20
	out 0x18,r24
	rjmp .L49
.L46:
	in r24,0x15
	eor r24,r20
	out 0x15,r24
	rjmp .L49
.L47:
	in r24,0x12
	eor r24,r20
	out 0x12,r24
	rjmp .L49
.L51:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_TogglePinValue, .-GPIO_TogglePinValue
	.section	.text.GPIO_SetPortDirection,"ax",@progbits
.global	GPIO_SetPortDirection
	.type	GPIO_SetPortDirection, @function
GPIO_SetPortDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L58
	cpi r24,lo8(2)
	breq .L54
	cpi r24,lo8(3)
	breq .L55
	cpi r24,lo8(1)
	breq .L56
	out 0x1a,r22
.L57:
	ldi r24,0
	ldi r25,0
	ret
.L56:
	out 0x17,r22
	rjmp .L57
.L54:
	out 0x14,r22
	rjmp .L57
.L55:
	out 0x11,r22
	rjmp .L57
.L58:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPortDirection, .-GPIO_SetPortDirection
	.section	.text.GPIO_SetPortValue,"ax",@progbits
.global	GPIO_SetPortValue
	.type	GPIO_SetPortValue, @function
GPIO_SetPortValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L65
	cpi r24,lo8(2)
	breq .L61
	cpi r24,lo8(3)
	breq .L62
	cpi r24,lo8(1)
	breq .L63
	out 0x1b,r22
.L64:
	ldi r24,0
	ldi r25,0
	ret
.L63:
	out 0x18,r22
	rjmp .L64
.L61:
	out 0x15,r22
	rjmp .L64
.L62:
	out 0x12,r22
	rjmp .L64
.L65:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPortValue, .-GPIO_SetPortValue
	.section	.text.GPIO_GetPortValue,"ax",@progbits
.global	GPIO_GetPortValue
	.type	GPIO_GetPortValue, @function
GPIO_GetPortValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r22
	cpi r24,lo8(4)
	brsh .L73
	sbiw r30,0
	breq .L73
	cpi r24,lo8(2)
	breq .L68
	cpi r24,lo8(3)
	breq .L69
	cpi r24,lo8(1)
	breq .L70
	in r24,0x19
.L74:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L70:
	in r24,0x16
	rjmp .L74
.L68:
	in r24,0x13
	rjmp .L74
.L69:
	in r24,0x10
	rjmp .L74
.L73:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.ident	"GCC: (SUSE Linux) 15.3.0"
