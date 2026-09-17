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
	std Y+2,r25
	call I2C_SendStart
	movw r18,r24
	or r24,r25
	brne .L29
	ldi r24,lo8(62)
	call I2C_SendSlaveAddressWithWrite
	movw r18,r24
	or r24,r25
	brne .L29
	ldi r24,lo8(64)
	call I2C_SendByte
	movw r18,r24
.L29:
	std Y+3,__zero_reg__
.L30:
	ldd r30,Y+1
	ldd r31,Y+2
	ldd r24,Y+3
	add r30,r24
	adc r31,__zero_reg__
	ld r24,Z
	cpse r24,__zero_reg__
	rjmp .L32
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	jmp I2C_SendStop
.L32:
	cpi r18,0
	cpc r19,r18
	brne .L31
	call I2C_SendByte
	movw r18,r24
.L31:
	ldd r24,Y+3
	subi r24,lo8(-(1))
	std Y+3,r24
	rjmp .L30
	.size	LCD_Update, .-LCD_Update
	.section	.text.LCD_RefreshPartial,"ax",@progbits
.global	LCD_RefreshPartial
	.type	LCD_RefreshPartial, @function
LCD_RefreshPartial:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	ldi r18,lo8(g_lcdPrev)
	mov r14,r18
	ldi r18,hi8(g_lcdPrev)
	mov r15,r18
	movw r16,r24
	ldi r28,0
.L36:
	movw r30,r14
	ld r24,Z+
	movw r14,r30
	movw r30,r16
	ld r29,Z+
	movw r16,r30
	cp r24,r29
	breq .L34
	ldi r24,lo8(48)
	add r24,r28
	cpi r28,lo8(16)
	brsh .L35
	mov r24,r28
.L35:
	ori r24,lo8(-128)
	call LCD_Command
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayMS
	mov r24,r29
	call LCD_WriteData
	movw r30,r16
	ld r24,-Z
	movw r30,r14
	st -Z,r24
.L34:
	subi r28,lo8(-(1))
	cpi r28,lo8(32)
	brne .L36
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	LCD_RefreshPartial, .-LCD_RefreshPartial
	.section	.rodata.LCD_UpdateFrame.str1.1,"aMS",@progbits,1
.LC0:
	.string	"FL%u %c P:%ucm"
.LC1:
	.string	"!OVERLOAD %u"
.LC2:
	.string	"LD:%u D:%u STOP"
.LC3:
	.string	"!EMERGENCY STOP"
.LC4:
	.string	"LD:%u D:%u MOV"
.LC5:
	.string	"!OVERTRAVEL"
.LC6:
	.string	"!OVERCURRENT"
.LC7:
	.string	"!TRAVEL TIMEOUT"
.LC8:
	.string	"!DOOR TIMEOUT"
.LC9:
	.string	"!DOOR JAM"
.LC10:
	.string	"!POSITION SENSOR"
.LC11:
	.string	"!LEVEL FAIL"
	.section	.text.LCD_UpdateFrame,"ax",@progbits
.global	LCD_UpdateFrame
	.type	LCD_UpdateFrame, @function
LCD_UpdateFrame:
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,38
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 38 */
/* stack size = 54 */
.L__stack_usage = 54
	movw r8,r24
	std Y+36,r22
	std Y+37,r18
	std Y+38,r19
	mov r11,r16
	mov r7,r17
	mov r6,r12
	mov r5,r13
	or r24,r25
	brne .+2
	rjmp .L39
	cpi r20,1
	cpc r21,__zero_reg__
	brne .+2
	rjmp .L56
	cpi r20,2
	sbci r21,0
	brne .+2
	rjmp .L57
	ldi r18,lo8(45)
	std Y+35,r18
.L41:
	movw r12,r28
	ldi r18,18
	add r12,r18
	adc r13,__zero_reg__
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(32)
	ldi r23,0
	movw r24,r12
	call memset
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(32)
	ldi r23,0
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	movw r24,r16
	call memset
	std Y+34,__zero_reg__
	std Y+17,__zero_reg__
	ldd r24,Y+38
	push r24
	ldd r25,Y+37
	push r25
	ldd r18,Y+35
	mov r25,r18
	lsl r25
	sbc r25,r25
	push r25
	push r18
	ldd r18,Y+36
	push __zero_reg__
	push r18
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(17)
	mov r4,r24
	push r4
	push r13
	push r12
	call snprintf
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	movw r30,r14
	sbiw r30,1
	mov r15,r12
	mov r14,r13
	cpi r30,9
	cpc r31,__zero_reg__
	brlo .+2
	rjmp .L42
	subi r30,lo8(-(gs(.L44)))
	sbci r31,hi8(-(gs(.L44)))
	jmp __tablejump2__
	.section	.jumptables.gcc.LCD_UpdateFrame,"a",@progbits
	.p2align	1
	.type	.L44, @object
.L44:
	.word gs(.L52)
	.word gs(.L51)
	.word gs(.L50)
	.word gs(.L49)
	.word gs(.L48)
	.word gs(.L47)
	.word gs(.L46)
	.word gs(.L45)
	.word gs(.L43)
	.section	.text.LCD_UpdateFrame
.L56:
	ldi r24,lo8(94)
	std Y+35,r24
	rjmp .L41
.L57:
	ldi r25,lo8(118)
	std Y+35,r25
	rjmp .L41
.L51:
	cp r10,__zero_reg__
	breq .L53
	push r7
	push r11
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(17)
	push r24
	push r17
	push r16
	call snprintf
.L82:
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L54
.L53:
	push r5
	push r6
	push r7
	push r11
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
.L85:
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(17)
	push r24
.L84:
	push r17
	push r16
	call snprintf
	rjmp .L82
.L52:
	ldi r22,lo8(.LC3)
	ldi r23,hi8(.LC3)
	cpse r10,__zero_reg__
	rjmp .L83
.L55:
	push r5
	push r6
	push r7
	push r11
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	rjmp .L85
.L50:
	ldi r25,lo8(-106)
	ldi r22,lo8(.LC5)
	ldi r23,hi8(.LC5)
	cp r10,r25
	brsh .L55
.L83:
	movw r24,r16
	call strcpy
.L54:
	ldi r24,lo8(16)
	mov r30,r15
	mov r31,r14
	movw r26,r8
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r26,r8
	adiw r26,16
	ldi r24,lo8(16)
	movw r30,r16
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r24,r8
	call LCD_RefreshPartial
.L39:
/* epilogue start */
	adiw r28,38
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	ret
.L47:
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	cpse r10,__zero_reg__
	rjmp .L83
	rjmp .L55
.L49:
	ldi r22,lo8(.LC7)
	ldi r23,hi8(.LC7)
	cpse r10,__zero_reg__
	rjmp .L83
	rjmp .L55
.L48:
	ldi r22,lo8(.LC8)
	ldi r23,hi8(.LC8)
	cpse r10,__zero_reg__
	rjmp .L83
	rjmp .L55
.L43:
	ldi r22,lo8(.LC9)
	ldi r23,hi8(.LC9)
	cpse r10,__zero_reg__
	rjmp .L83
	rjmp .L55
.L46:
	ldi r22,lo8(.LC10)
	ldi r23,hi8(.LC10)
	cpse r10,__zero_reg__
	rjmp .L83
	rjmp .L55
.L45:
	cp r10,__zero_reg__
	brne .+2
	rjmp .L55
	ldi r22,lo8(.LC11)
	ldi r23,hi8(.LC11)
	rjmp .L83
.L42:
	push r5
	push r6
	push r7
	push r11
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	push r25
	push r24
	push __zero_reg__
	push r4
	rjmp .L84
	.size	LCD_UpdateFrame, .-LCD_UpdateFrame
	.section	.bss.g_lcdPrev,"aw",@nobits
	.type	g_lcdPrev, @object
	.size	g_lcdPrev, 32
g_lcdPrev:
	.zero	32
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
.global __do_clear_bss
