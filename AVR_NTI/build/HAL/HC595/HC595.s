	.file	"HC595.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.HC595_Write,"ax",@progbits
.global	HC595_Write
	.type	HC595_Write, @function
HC595_Write:
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	call SPI_Transceive
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	HC595_Write, .-HC595_Write
	.ident	"GCC: (SUSE Linux) 15.3.0"
