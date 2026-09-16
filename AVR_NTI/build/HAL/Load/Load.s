	.file	"Load.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LOAD_Init,"ax",@progbits
.global	LOAD_Init
	.type	LOAD_Init, @function
LOAD_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	jmp ADC_Init
	.size	LOAD_Init, .-LOAD_Init
	.section	.text.LOAD_ReadKg,"ax",@progbits
.global	LOAD_ReadKg
	.type	LOAD_ReadKg, @function
LOAD_ReadKg:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(1)
	call ADC_ReadChannel
	or r24,r25
	brne .L4
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-24)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
.L2:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L4:
	ldi r24,0
	ldi r25,0
	rjmp .L2
	.size	LOAD_ReadKg, .-LOAD_ReadKg
	.section	.text.LOAD_IsOverloaded,"ax",@progbits
.global	LOAD_IsOverloaded
	.type	LOAD_IsOverloaded, @function
LOAD_IsOverloaded:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call LOAD_ReadKg
	movw r18,r24
	ldi r24,lo8(1)
	cpi r18,-123
	sbci r19,3
	brsh .L6
	ldi r24,0
.L6:
/* epilogue start */
	ret
	.size	LOAD_IsOverloaded, .-LOAD_IsOverloaded
	.ident	"GCC: (SUSE Linux) 15.3.0"
