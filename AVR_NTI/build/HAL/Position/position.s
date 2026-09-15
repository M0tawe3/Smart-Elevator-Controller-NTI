	.file	"position.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.get_position,"ax",@progbits
.global	get_position
	.type	get_position, @function
get_position:
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
	std Y+3,r24
	std Y+4,r25
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,0
	call ADC_ReadChannel
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
	cpi r18,44
	ldi r24,1
	cpc r19,r24
	brlo .L3
	ldi r24,lo8(1)
	cpi r18,88
	ldi r30,2
	cpc r19,r30
	brlo .L2
	ldi r24,lo8(3)
	cpi r18,-124
	sbci r19,3
	brsh .L2
	ldi r24,lo8(2)
	rjmp .L2
.L3:
	ldi r24,0
.L2:
	ldd r30,Y+3
	ldd r31,Y+4
	st Z,r24
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
	.size	get_position, .-get_position
	.ident	"GCC: (SUSE Linux) 15.3.0"
