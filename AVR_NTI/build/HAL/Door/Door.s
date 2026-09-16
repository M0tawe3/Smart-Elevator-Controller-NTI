	.file	"Door.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.DRV_SetDuty,"ax",@progbits
.global	DRV_SetDuty
	.type	DRV_SetDuty, @function
DRV_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(101)
	brlo .L2
	ldi r24,lo8(100)
.L2:
	mov r18,r24
	ldi r19,0
	ldi r26,lo8(31)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	out 0x28+1,r19
	out 0x28,r18
/* epilogue start */
	ret
	.size	DRV_SetDuty, .-DRV_SetDuty
	.section	.text.DRV_Stop,"ax",@progbits
.global	DRV_Stop
	.type	DRV_Stop, @function
DRV_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x28+1,__zero_reg__
	out 0x28,__zero_reg__
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	jmp GPIO_SetPinValue
	.size	DRV_Stop, .-DRV_Stop
	.section	.text.DRV_Init,"ax",@progbits
.global	DRV_Init
	.type	DRV_Init, @function
DRV_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	call DRV_Stop
	ldi r24,lo8(34)
	out 0x2f,r24
	ldi r24,lo8(25)
	out 0x2e,r24
	ldi r24,lo8(31)
	ldi r25,lo8(3)
	out 0x26+1,r25
	out 0x26,r24
	out 0x28+1,__zero_reg__
	out 0x28,__zero_reg__
/* epilogue start */
	ret
	.size	DRV_Init, .-DRV_Init
	.section	.text.DRV_SetDir,"ax",@progbits
.global	DRV_SetDir
	.type	DRV_SetDir, @function
DRV_SetDir:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L6
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(2)
.L8:
	ldi r24,lo8(1)
	jmp GPIO_SetPinValue
.L6:
	sbiw r24,2
	brne .L7
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	rjmp .L8
.L7:
	jmp DRV_Stop
	.size	DRV_SetDir, .-DRV_SetDir
	.ident	"GCC: (SUSE Linux) 15.3.0"
