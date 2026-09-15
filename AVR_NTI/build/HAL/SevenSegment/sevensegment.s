	.file	"sevensegment.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.seven_segment_init,"ax",@progbits
.global	seven_segment_init
	.type	seven_segment_init, @function
seven_segment_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(-1)
	jmp GPIO_SetPortDirection
	.size	seven_segment_init, .-seven_segment_init
	.section	.text.seven_segment_write,"ax",@progbits
.global	seven_segment_write
	.type	seven_segment_write, @function
seven_segment_write:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r22,lo8(10)
	brsh .L3
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(digits))
	sbci r31,hi8(-(digits))
	ld r22,Z
	jmp GPIO_SetPortValue
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	seven_segment_write, .-seven_segment_write
.global	digits
	.section	.data.digits,"aw"
	.type	digits, @object
	.size	digits, 10
digits:
	.base64	"PwZbT2ZtfQd/bw=="
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
.global __do_copy_data
