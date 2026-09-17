	.file	"TIMER.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.TIMER0_Init,"ax",@progbits
.global	TIMER0_Init
	.type	TIMER0_Init, @function
TIMER0_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(13)
	out 0x33,r24
	ldi r24,lo8(77)
	out 0x3c,r24
	out 0x32,__zero_reg__
	in r24,0x39
	ori r24,lo8(2)
	out 0x39,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER0_Init, .-TIMER0_Init
	.section	.text.TIMER0_DelayMS,"ax",@progbits
.global	TIMER0_DelayMS
	.type	TIMER0_DelayMS, @function
TIMER0_DelayMS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r20,g_msCounter
	lds r21,g_msCounter+1
	lds r22,g_msCounter+2
	lds r23,g_msCounter+3
	add r20,r24
	adc r21,r25
	adc r22,__zero_reg__
	adc r23,__zero_reg__
.L3:
	lds r24,g_msCounter
	lds r25,g_msCounter+1
	lds r26,g_msCounter+2
	lds r27,g_msCounter+3
	cp r24,r20
	cpc r25,r21
	cpc r26,r22
	cpc r27,r23
	brlo .L3
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER0_DelayMS, .-TIMER0_DelayMS
	.section	.text.TIMER0_DelayS,"ax",@progbits
.global	TIMER0_DelayS
	.type	TIMER0_DelayS, @function
TIMER0_DelayS:
	push r28
	push r29
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 6 */
.L__stack_usage = 6
	std Y+1,r24
	std Y+2,r25
	std Y+3,__zero_reg__
	std Y+4,__zero_reg__
.L6:
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r18,Y+1
	ldd r19,Y+2
	cp r24,r18
	cpc r25,r19
	brne .L7
	ldi r24,0
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L7:
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	ldd r18,Y+3
	ldd r19,Y+4
	subi r18,-1
	sbci r19,-1
	std Y+3,r18
	std Y+4,r19
	rjmp .L6
	.size	TIMER0_DelayS, .-TIMER0_DelayS
	.section	.text.TIMER0_PWM,"ax",@progbits
.global	TIMER0_PWM
	.type	TIMER0_PWM, @function
TIMER0_PWM:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(101)
	brsh .L8
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	in r24,0x33
	ori r24,lo8(72)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(32)
	out 0x33,r24
	mov r18,r28
	ldi r19,0
	ldi r26,lo8(-1)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	out 0x3c,r18
	in r24,0x33
	ori r24,lo8(3)
	out 0x33,r24
	ldi r24,0
	ldi r25,0
.L8:
/* epilogue start */
	pop r28
	ret
	.size	TIMER0_PWM, .-TIMER0_PWM
	.section	.text.TIMER0_Stop,"ax",@progbits
.global	TIMER0_Stop
	.type	TIMER0_Stop, @function
TIMER0_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x33
	andi r24,lo8(-8)
	out 0x33,r24
	in r24,0x33
	andi r24,lo8(-49)
	out 0x33,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER0_Stop, .-TIMER0_Stop
	.section	.text.TIMER1_Init,"ax",@progbits
.global	TIMER1_Init
	.type	TIMER1_Init, @function
TIMER1_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x2f,__zero_reg__
	ldi r24,lo8(8)
	out 0x2e,r24
	ldi r24,lo8(-25)
	ldi r25,lo8(3)
	out 0x2a+1,r25
	out 0x2a,r24
	out 0x2c+1,__zero_reg__
	out 0x2c,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER1_Init, .-TIMER1_Init
	.section	.text.TIMER1_DelayMS,"ax",@progbits
.global	TIMER1_DelayMS
	.type	TIMER1_DelayMS, @function
TIMER1_DelayMS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp TIMER0_DelayMS
	.size	TIMER1_DelayMS, .-TIMER1_DelayMS
	.section	.text.TIMER1_PWM,"ax",@progbits
.global	TIMER1_PWM
	.type	TIMER1_PWM, @function
TIMER1_PWM:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	mov r17,r22
	cpi r22,lo8(101)
	brsh .L17
	sbiw r24,16
	cpi r24,17
	sbci r25,78
	brsh .L17
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	in r25,0x2f
	andi r25,lo8(48)
	ori r25,lo8(-126)
	out 0x2f,r25
	ldi r24,lo8(24)
	out 0x2e,r24
	movw r18,r28
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,1
	sbci r19,0
	out 0x26+1,r19
	out 0x26,r18
	in r18,0x26
	in r19,0x26+1
	mov r26,r17
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	out 0x2a+1,r19
	out 0x2a,r18
	in r24,0x2e
	ori r24,lo8(1)
	out 0x2e,r24
	ldi r24,0
	ldi r25,0
.L14:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
.L17:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L14
	.size	TIMER1_PWM, .-TIMER1_PWM
	.section	.text.TIMER1_Stop,"ax",@progbits
.global	TIMER1_Stop
	.type	TIMER1_Stop, @function
TIMER1_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x2e
	andi r24,lo8(-8)
	out 0x2e,r24
	in r24,0x2f
	andi r24,lo8(63)
	out 0x2f,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER1_Stop, .-TIMER1_Stop
	.section	.text.TIMER2_Init,"ax",@progbits
.global	TIMER2_Init
	.type	TIMER2_Init, @function
TIMER2_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x25,__zero_reg__
	out 0x24,__zero_reg__
	out 0x23,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER2_Init, .-TIMER2_Init
	.section	.text.TIMER2_PWM,"ax",@progbits
.global	TIMER2_PWM
	.type	TIMER2_PWM, @function
TIMER2_PWM:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(101)
	brsh .L20
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r24,lo8(108)
	out 0x25,r24
	mov r18,r28
	ldi r19,0
	ldi r26,lo8(-1)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	out 0x23,r18
	ldi r24,0
	ldi r25,0
.L20:
/* epilogue start */
	pop r28
	ret
	.size	TIMER2_PWM, .-TIMER2_PWM
	.section	.text.TIMER2_Stop,"ax",@progbits
.global	TIMER2_Stop
	.type	TIMER2_Stop, @function
TIMER2_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x25
	andi r24,lo8(-8)
	out 0x25,r24
	in r24,0x25
	andi r24,lo8(-49)
	out 0x25,r24
	out 0x23,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER2_Stop, .-TIMER2_Stop
	.section	.text.__vector_10,"ax",@progbits
.global	__vector_10
	.type	__vector_10, @function
__vector_10:
	__gcc_isr 1
	push r25
	push r26
	push r27
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 3...7 */
.L__stack_usage = 3 + __gcc_isr.n_pushed
	lds r24,g_msCounter
	lds r25,g_msCounter+1
	lds r26,g_msCounter+2
	lds r27,g_msCounter+3
	adiw r24,10
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts g_msCounter,r24
	sts g_msCounter+1,r25
	sts g_msCounter+2,r26
	sts g_msCounter+3,r27
	ldi r24,lo8(1)
	sts systemTicks10ms,r24
/* epilogue start */
	pop r27
	pop r26
	pop r25
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_10, .-__vector_10
.global	g_msCounter
	.section	.bss.g_msCounter,"aw",@nobits
	.type	g_msCounter, @object
	.size	g_msCounter, 4
g_msCounter:
	.zero	4
.global	systemTicks10ms
	.section	.bss.systemTicks10ms,"aw",@nobits
	.type	systemTicks10ms, @object
	.size	systemTicks10ms, 1
systemTicks10ms:
	.zero	1
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
