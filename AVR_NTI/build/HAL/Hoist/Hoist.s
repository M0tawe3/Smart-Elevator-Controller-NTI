	.file	"Hoist.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.HST_ApplyBrakeState,"ax",@progbits
	.type	HST_ApplyBrakeState, @function
HST_ApplyBrakeState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	jmp GPIO_SetPinValue
	.size	HST_ApplyBrakeState, .-HST_ApplyBrakeState
	.section	.text.HST_Init,"ax",@progbits
.global	HST_Init
	.type	HST_Init, @function
HST_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	call HST_ApplyBrakeState
	ldi r24,lo8(-126)
	out 0x2f,r24
	ldi r24,lo8(25)
	out 0x2e,r24
	ldi r24,lo8(31)
	ldi r25,lo8(3)
	out 0x26+1,r25
	out 0x26,r24
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
/* epilogue start */
	ret
	.size	HST_Init, .-HST_Init
	.section	.text.HST_Brake,"ax",@progbits
.global	HST_Brake
	.type	HST_Brake, @function
HST_Brake:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
	jmp HST_ApplyBrakeState
	.size	HST_Brake, .-HST_Brake
	.section	.text.HST_SetDir,"ax",@progbits
.global	HST_SetDir
	.type	HST_SetDir, @function
HST_SetDir:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L5
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,0
.L7:
	ldi r24,lo8(1)
	jmp GPIO_SetPinValue
.L5:
	sbiw r24,2
	brne .L6
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rjmp .L7
.L6:
	jmp HST_Brake
	.size	HST_SetDir, .-HST_SetDir
	.section	.text.HST_SetDuty,"ax",@progbits
.global	HST_SetDuty
	.type	HST_SetDuty, @function
HST_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpse r22,__zero_reg__
	jmp HST_Brake
.L9:
	cpi r24,lo8(101)
	brlo .L10
	ldi r24,lo8(100)
.L10:
	mov r18,r24
	ldi r19,0
	ldi r26,lo8(31)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	out 0x2a+1,r19
	out 0x2a,r18
/* epilogue start */
	ret
	.size	HST_SetDuty, .-HST_SetDuty
	.section	.text.HST_EmergencyStop,"ax",@progbits
.global	HST_EmergencyStop
	.type	HST_EmergencyStop, @function
HST_EmergencyStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp HST_Brake
	.size	HST_EmergencyStop, .-HST_EmergencyStop
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
