	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER0_Init
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	call LCD_Init
	ldi r24,lo8(10)
	ldi r25,0
.L3:
	call TIMER0_DelayMS
	mov r8,__zero_reg__
	ldi r24,lo8(10)
	mov r10,r24
	mov r11,__zero_reg__
	mov r12,__zero_reg__
	mov r13,__zero_reg__
	movw r14,r12
	ldi r16,lo8(-47)
	ldi r17,0
	ldi r18,lo8(-47)
	ldi r19,lo8(1)
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(2)
	ldi r24,lo8(frame)
	ldi r25,hi8(frame)
	call LCD_UpdateFrame
	ldi r24,lo8(frame)
	ldi r25,hi8(frame)
	call LCD_RefreshPartial
	ldi r24,lo8(-106)
	ldi r25,0
	call TIMER0_DelayMS
	inc r8
	ldi r25,lo8(2)
	mov r12,r25
	ldi r18,lo8(-47)
	ldi r19,lo8(1)
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(2)
	ldi r24,lo8(frame)
	ldi r25,hi8(frame)
	call LCD_UpdateFrame
	ldi r24,lo8(frame)
	ldi r25,hi8(frame)
	call LCD_RefreshPartial
	ldi r24,lo8(-106)
	ldi r25,0
	rjmp .L3
	.size	main, .-main
.global	frame
	.section	.bss.frame,"aw",@nobits
	.type	frame, @object
	.size	frame, 32
frame:
	.zero	32
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
