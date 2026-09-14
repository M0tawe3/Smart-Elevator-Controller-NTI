	.file	"HC165.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.HC165_Read,"ax",@progbits
.global	HC165_Read
	.type	HC165_Read, @function
HC165_Read:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+2,r24
	std Y+3,r22
	std Y+1,__zero_reg__
	ldi r20,0
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldd r22,Y+3
	ldd r24,Y+2
	call GPIO_SetPinValue
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(-1)
	call SPI_Transceive
	ldd r24,Y+1
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	HC165_Read, .-HC165_Read
	.ident	"GCC: (SUSE Linux) 15.3.0"
