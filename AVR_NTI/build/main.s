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
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER0_Init
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	call LCD_Init
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	ldi r20,lo8(-56)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(2)
	call LCD_Update
.L2:
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 15.3.0"
