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
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r22,lo8(-128)
	ldi r23,lo8(37)
	ldi r24,0
	ldi r25,0
	call UART_Init
	call TIMER0_Init
	ldi r24,lo8(1)
	call SPI_InitMaster
.L2:
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_SelectSlave
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(85)
	call SPI_Transceive
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_ReleaseSlave
	ldd r24,Y+1
	call UART_SendByte
	ldi r24,lo8(-56)
	ldi r25,0
	call TIMER0_DelayMS
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 15.3.0"
