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
	rjmp .L10
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L10
	ldi r25,lo8(-1)
	add r25,r24
	cpi r25,lo8(3)
	brsh .L9
	mov r18,r24
	ldi r19,lo8(-3)
	mulsu r19,r18
	movw r30,r0
	clr __zero_reg__
	movw r26,r30
	adiw r26,59
	adiw r30,58
.L3:
	cpi r20,lo8(1)
	breq .L4
	cpi r20,lo8(2)
	breq .L5
	cpse r20,__zero_reg__
	rjmp .L10
	ld r18,Z
	ldi r24,lo8(1)
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r18,r24
	st Z,r18
	ld r25,X
	and r24,r25
.L11:
	st X,r24
.L6:
	ldi r24,0
	ldi r25,0
	ret
.L9:
	ldi r30,lo8(58)
	ldi r31,0
	ldi r26,lo8(59)
	ldi r27,0
	rjmp .L3
.L4:
	ld r18,Z
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
	st Z,r18
	ld r24,X
	com r22
	and r22,r24
	st X,r22
	rjmp .L6
.L5:
	ld r18,Z
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
	st Z,r24
	ld r24,X
	or r24,r20
	rjmp .L11
.L10:
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
	rjmp .L27
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L27
	cpi r24,lo8(2)
	breq .L14
	cpi r24,lo8(3)
	brne .+2
	rjmp .L15
	cpi r24,lo8(1)
	breq .L16
	cpi r20,lo8(1)
	brne .L17
	in r24,0x1b
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L28:
	out 0x1b,r24
.L18:
	ldi r24,0
	ldi r25,0
	ret
.L17:
	brlo .+2
	rjmp .L27
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
	rjmp .L28
.L16:
	cpi r20,lo8(1)
	brne .L19
	in r24,0x18
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L30:
	out 0x18,r24
	rjmp .L18
.L19:
	brsh .L27
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
	rjmp .L30
.L14:
	cpi r20,lo8(1)
	brne .L20
	in r24,0x15
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L29:
	out 0x15,r24
	rjmp .L18
.L20:
	brsh .L27
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
	rjmp .L29
.L15:
	cpi r20,lo8(1)
	brne .L21
	in r24,0x12
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	or r24,r18
.L31:
	out 0x12,r24
	rjmp .L18
.L21:
	brsh .L27
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
	rjmp .L31
.L27:
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
	brsh .L40
	cpi r22,lo8(8)
	brsh .L40
	sbiw r30,0
	breq .L40
	cpi r24,lo8(2)
	breq .L34
	cpi r24,lo8(3)
	breq .L35
	cpi r24,lo8(1)
	breq .L36
	in r24,0x19
.L41:
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
.L36:
	in r24,0x16
	rjmp .L41
.L34:
	in r24,0x13
	rjmp .L41
.L35:
	in r24,0x10
	rjmp .L41
.L40:
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
	brsh .L49
	cpi r22,lo8(8)
	brsh .L49
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
	breq .L44
	cpi r24,lo8(3)
	breq .L45
	cpi r24,lo8(1)
	breq .L46
	in r24,0x1b
	eor r24,r20
	out 0x1b,r24
.L47:
	ldi r24,0
	ldi r25,0
	ret
.L46:
	in r24,0x18
	eor r24,r20
	out 0x18,r24
	rjmp .L47
.L44:
	in r24,0x15
	eor r24,r20
	out 0x15,r24
	rjmp .L47
.L45:
	in r24,0x12
	eor r24,r20
	out 0x12,r24
	rjmp .L47
.L49:
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
	brsh .L56
	cpi r24,lo8(2)
	breq .L52
	cpi r24,lo8(3)
	breq .L53
	cpi r24,lo8(1)
	breq .L54
	out 0x1a,r22
.L55:
	ldi r24,0
	ldi r25,0
	ret
.L54:
	out 0x17,r22
	rjmp .L55
.L52:
	out 0x14,r22
	rjmp .L55
.L53:
	out 0x11,r22
	rjmp .L55
.L56:
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
	brsh .L63
	cpi r24,lo8(2)
	breq .L59
	cpi r24,lo8(3)
	breq .L60
	cpi r24,lo8(1)
	breq .L61
	out 0x1b,r22
.L62:
	ldi r24,0
	ldi r25,0
	ret
.L61:
	out 0x18,r22
	rjmp .L62
.L59:
	out 0x15,r22
	rjmp .L62
.L60:
	out 0x12,r22
	rjmp .L62
.L63:
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
	brsh .L71
	sbiw r30,0
	breq .L71
	cpi r24,lo8(2)
	breq .L66
	cpi r24,lo8(3)
	breq .L67
	cpi r24,lo8(1)
	breq .L68
	in r24,0x19
.L72:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L68:
	in r24,0x16
	rjmp .L72
.L66:
	in r24,0x13
	rjmp .L72
.L67:
	in r24,0x10
	rjmp .L72
.L71:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
