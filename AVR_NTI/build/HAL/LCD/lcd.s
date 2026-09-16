	.file	"lcd.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LCD_Command,"ax",@progbits
	.type	LCD_Command, @function
LCD_Command:
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
	std Y+1,r24
	call I2C_SendStart
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L2
	ldi r24,lo8(62)
	call I2C_SendSlaveAddressWithWrite
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L2
	ldi r24,0
	call I2C_SendByte
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L2
	ldd r24,Y+1
	call I2C_SendByte
	std Y+2,r24
	std Y+3,r25
.L2:
	call I2C_SendStop
	ldd r24,Y+2
	ldd r25,Y+3
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_Command, .-LCD_Command
	.section	.text.Debug_Fail,"ax",@progbits
.global	Debug_Fail
	.type	Debug_Fail, @function
Debug_Fail:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(3)
	jmp GPIO_SetPinValue
	.size	Debug_Fail, .-Debug_Fail
	.section	.text.LCD_Init,"ax",@progbits
.global	LCD_Init
	.type	LCD_Init, @function
LCD_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(56)
	call LCD_Command
	or r24,r25
	breq .L5
	call Debug_Fail
.L5:
	ldi r24,lo8(56)
	call LCD_Command
	or r24,r25
	breq .L6
	call Debug_Fail
.L6:
	ldi r24,lo8(12)
	call LCD_Command
	or r24,r25
	breq .L7
	call Debug_Fail
.L7:
	ldi r24,lo8(1)
	call LCD_Command
	or r24,r25
	breq .L8
	call Debug_Fail
.L8:
	ldi r24,lo8(6)
	call LCD_Command
	or r24,r25
	breq .L9
	call Debug_Fail
.L9:
	ldi r24,lo8(2)
	call LCD_Command
	or r24,r25
	breq .L4
	jmp Debug_Fail
.L4:
/* epilogue start */
	ret
	.size	LCD_Init, .-LCD_Init
	.section	.text.LCD_WriteData,"ax",@progbits
.global	LCD_WriteData
	.type	LCD_WriteData, @function
LCD_WriteData:
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
	std Y+1,r24
	call I2C_SendStart
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L27
	ldi r24,lo8(62)
	call I2C_SendSlaveAddressWithWrite
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L27
	ldi r24,lo8(64)
	call I2C_SendByte
	std Y+2,r24
	std Y+3,r25
	or r24,r25
	brne .L27
	ldd r24,Y+1
	call I2C_SendByte
	std Y+2,r24
	std Y+3,r25
.L27:
	call I2C_SendStop
	ldd r24,Y+2
	ldd r25,Y+3
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_WriteData, .-LCD_WriteData
	.section	.text.LCD_Update,"ax",@progbits
.global	LCD_Update
	.type	LCD_Update, @function
LCD_Update:
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
	std Y+1,r24
	std Y+2,r22
	std Y+3,r23
	ldi r24,lo8(70)
	call LCD_WriteData
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayMS
	ldi r24,lo8(76)
	call LCD_WriteData
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayMS
	ldd r24,Y+1
	subi r24,lo8(-(48))
	call LCD_WriteData
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayMS
	ldi r24,lo8(32)
	call LCD_WriteData
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayMS
	ldd r24,Y+2
	ldd r25,Y+3
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L29
	sbiw r24,2
	brne .L30
	ldi r24,lo8(118)
.L31:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	jmp LCD_WriteData
.L29:
	ldi r24,lo8(94)
	rjmp .L31
.L30:
	ldi r24,lo8(45)
	rjmp .L31
	.size	LCD_Update, .-LCD_Update
	.ident	"GCC: (SUSE Linux) 15.3.0"
