	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 2 */
.L__stack_usage = 2
	call TIMER2_Init
	ldi r22,lo8(6)
	ldi r24,0
	call ADC_Init
.L2:
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,0
	call ADC_ReadChannel
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(100)
	ldi r27,0
	call __umulhisi3
	mov r26,r25
	mov r25,r24
	mov r24,r23
	lsr r26
	ror r25
	ror r24
	lsr r26
	ror r25
	ror r24
	call TIMER2_PWM
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 15.3.0"
