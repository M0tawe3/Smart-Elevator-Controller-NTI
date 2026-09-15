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
	ldi r22,lo8(-128)
	ldi r23,lo8(37)
	ldi r24,0
	ldi r25,0
	call UART_Init
	call TIMER0_Init
	ldi r24,0
	call SPI_InitMaster
.L2:
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call HC165_Read
	call UART_SendByte
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 15.3.0"
