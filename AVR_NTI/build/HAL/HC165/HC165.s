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
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 5 */
.L__stack_usage = 5
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_SelectSlave
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(-1)
	call SPI_Transceive
	ldd r16,Y+1
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(-1)
	call SPI_Transceive
	ldd r18,Y+1
	mov r19,r16
	movw r16,r18
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_ReleaseSlave
	movw r24,r16
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	HC165_Read, .-HC165_Read
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
