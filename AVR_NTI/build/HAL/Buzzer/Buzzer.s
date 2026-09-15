	.file	"Buzzer.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.BUZ_Init,"ax",@progbits
.global	BUZ_Init
	.type	BUZ_Init, @function
BUZ_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER2_Init
	jmp TIMER2_Stop
	.size	BUZ_Init, .-BUZ_Init
	.section	.text.BUZ_Chime,"ax",@progbits
.global	BUZ_Chime
	.type	BUZ_Chime, @function
BUZ_Chime:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(35)
	jmp TIMER2_PWM
	.size	BUZ_Chime, .-BUZ_Chime
	.section	.text.BUZ_Alarm,"ax",@progbits
.global	BUZ_Alarm
	.type	BUZ_Alarm, @function
BUZ_Alarm:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(80)
	jmp TIMER2_PWM
	.size	BUZ_Alarm, .-BUZ_Alarm
	.section	.text.BUZ_Stop,"ax",@progbits
.global	BUZ_Stop
	.type	BUZ_Stop, @function
BUZ_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp TIMER2_Stop
	.size	BUZ_Stop, .-BUZ_Stop
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
