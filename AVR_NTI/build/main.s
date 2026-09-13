	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.led_isr,"ax",@progbits
.global	led_isr
	.type	led_isr, @function
led_isr:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(7)
	ldi r24,0
	jmp GPIO_TogglePinValue
	.size	led_isr, .-led_isr
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,0
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,0
	call GPIO_SetPinDirection
	ldi r22,lo8(1)
	ldi r24,0
	call EXTI_SetSense
	ldi r22,lo8(gs(led_isr))
	ldi r23,hi8(gs(led_isr))
	ldi r24,0
	call EXTI_SetCallback
	ldi r24,0
	call EXTI_Enable
	call INTERRUPT_EnableGlobal
.L3:
	ldi r22,lo8(4)
	ldi r24,0
	call GPIO_TogglePinValue
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	rjmp .L3
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 15.3.0"
