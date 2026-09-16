	.file	"HC595.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SEG_Show,"ax",@progbits
.global	SEG_Show
	.type	SEG_Show, @function
SEG_Show:
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
	movw r16,r22
	cpi r24,lo8(4)
	brsh .L1
	mov r30,r24
	ldi r31,0
	subi r30,lo8(-(digits))
	sbci r31,hi8(-(digits))
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ld r24,Z
	call SPI_Transceive
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	cpi r16,1
	cpc r17,__zero_reg__
	breq .L3
	cpi r16,2
	sbci r17,0
	brne .L4
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(4)
.L6:
	ldi r24,lo8(2)
	call GPIO_SetPinValue
.L1:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L3:
	ldi r20,lo8(1)
.L7:
	ldi r22,lo8(4)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(5)
	rjmp .L6
.L4:
	ldi r20,0
	rjmp .L7
	.size	SEG_Show, .-SEG_Show
	.section	.rodata.digits,"a"
	.type	digits, @object
	.size	digits, 4
digits:
	.ascii	"?\006[O"
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
