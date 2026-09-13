	.file	"INTERRUPT.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.INTERRUPT_EnableGlobal,"ax",@progbits
.global	INTERRUPT_EnableGlobal
	.type	INTERRUPT_EnableGlobal, @function
INTERRUPT_EnableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	ori r24,lo8(-128)
	out __SREG__,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_EnableGlobal, .-INTERRUPT_EnableGlobal
	.section	.text.INTERRUPT_DisableGlobal,"ax",@progbits
.global	INTERRUPT_DisableGlobal
	.type	INTERRUPT_DisableGlobal, @function
INTERRUPT_DisableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	andi r24,lo8(127)
	out __SREG__,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_DisableGlobal, .-INTERRUPT_DisableGlobal
	.section	.text.EXTI_SetSense,"ax",@progbits
.global	EXTI_SetSense
	.type	EXTI_SetSense, @function
EXTI_SetSense:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L4
	cpi r24,lo8(2)
	breq .L5
	cpse r24,__zero_reg__
	rjmp .L10
	in r24,0x35
	andi r22,lo8(3)
.L11:
	or r24,r22
	out 0x35,r24
.L7:
	ldi r24,0
	ldi r25,0
	ret
.L4:
	in r24,0x35
	lsl r22
	lsl r22
	andi r22,lo8(12)
	rjmp .L11
.L5:
	cpi r22,lo8(2)
	brne .L8
	in r24,0x34
	andi r24,lo8(-65)
.L12:
	out 0x34,r24
	rjmp .L7
.L8:
	cpi r22,lo8(3)
	brne .L10
	in r24,0x34
	ori r24,lo8(64)
	rjmp .L12
.L10:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetSense, .-EXTI_SetSense
	.section	.text.EXTI_ClearFlag,"ax",@progbits
.global	EXTI_ClearFlag
	.type	EXTI_ClearFlag, @function
EXTI_ClearFlag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L14
	cpi r24,lo8(2)
	breq .L15
	cpse r24,__zero_reg__
	rjmp .L18
	in r24,0x3a
	ori r24,lo8(64)
.L19:
	out 0x3a,r24
	ldi r24,0
	ldi r25,0
	ret
.L14:
	in r24,0x3a
	ori r24,lo8(-128)
	rjmp .L19
.L15:
	in r24,0x3a
	ori r24,lo8(32)
	rjmp .L19
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_ClearFlag, .-EXTI_ClearFlag
	.section	.text.EXTI_Enable,"ax",@progbits
.global	EXTI_Enable
	.type	EXTI_Enable, @function
EXTI_Enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L21
	cpi r24,lo8(2)
	breq .L22
	cpse r24,__zero_reg__
	rjmp .L25
	in r24,0x3a
	ori r24,lo8(64)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(64)
.L26:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L21:
	in r24,0x3a
	ori r24,lo8(-128)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(-128)
	rjmp .L26
.L22:
	in r24,0x3a
	ori r24,lo8(32)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(32)
	rjmp .L26
.L25:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Enable, .-EXTI_Enable
	.section	.text.EXTI_Disable,"ax",@progbits
.global	EXTI_Disable
	.type	EXTI_Disable, @function
EXTI_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L28
	cpi r24,lo8(2)
	breq .L29
	cpse r24,__zero_reg__
	rjmp .L32
	in r24,0x3b
	andi r24,lo8(-65)
.L33:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L28:
	in r24,0x3b
	andi r24,lo8(127)
	rjmp .L33
.L29:
	in r24,0x3b
	andi r24,lo8(-33)
	rjmp .L33
.L32:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Disable, .-EXTI_Disable
	.section	.text.EXTI_SetCallback,"ax",@progbits
.global	EXTI_SetCallback
	.type	EXTI_SetCallback, @function
EXTI_SetCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	brsh .L36
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(EXTI_Callbacks))
	sbci r31,hi8(-(EXTI_Callbacks))
	st Z,r22
	std Z+1,r23
	ldi r24,0
	ldi r25,0
	ret
.L36:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetCallback, .-EXTI_SetCallback
	.section	.text.__vector_1,"ax",@progbits
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_Callbacks
	lds r31,EXTI_Callbacks+1
	sbiw r30,0
	breq .L37
	icall
.L37:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_1, .-__vector_1
	.section	.text.__vector_2,"ax",@progbits
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_Callbacks+2
	lds r31,EXTI_Callbacks+3
	sbiw r30,0
	breq .L42
	icall
.L42:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_2, .-__vector_2
	.section	.text.__vector_3,"ax",@progbits
.global	__vector_3
	.type	__vector_3, @function
__vector_3:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_Callbacks+4
	lds r31,EXTI_Callbacks+5
	sbiw r30,0
	breq .L47
	icall
.L47:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_3, .-__vector_3
	.section	.bss.EXTI_Callbacks,"aw",@nobits
	.type	EXTI_Callbacks, @object
	.size	EXTI_Callbacks, 6
EXTI_Callbacks:
	.zero	6
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
