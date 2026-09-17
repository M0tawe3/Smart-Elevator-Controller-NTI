	.file	"Safety.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SAF_Evaluate,"ax",@progbits
.global	SAF_Evaluate
	.type	SAF_Evaluate, @function
SAF_Evaluate:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	breq .L1
	ldd r18,Y+17
	sbrs r18,3
	rjmp .L4
	ldi r24,lo8(1)
	std Y+18,r24
	ldi r24,lo8(15)
.L29:
	std Y+14,r24
.L1:
/* epilogue start */
	pop r29
	pop r28
	ret
.L4:
	ld r24,Y
	ldd r25,Y+1
	cpi r24,-18
	sbci r25,3
	brlo .L5
	ldi r24,lo8(3)
.L30:
	std Y+18,r24
	ldi r24,lo8(14)
	rjmp .L29
.L5:
	ldd r24,Y+4
	cpi r24,lo8(6)
	brlo .L6
	ldd r24,Y+16
	cpi r24,lo8(0)
	breq .L6
	ldi r24,lo8(9)
	rjmp .L30
.L6:
	ldd r24,Y+7
	ldd r25,Y+8
	cpi r24,-103
	ldi r19,58
	cpc r25,r19
	brlo .L7
	lds r24,s_overcurrentTimer
	lds r25,s_overcurrentTimer+1
	adiw r24,1
	sts s_overcurrentTimer,r24
	sts s_overcurrentTimer+1,r25
	sbiw r24,50
	brlo .L9
	ldi r24,lo8(6)
	rjmp .L30
.L7:
	sts s_overcurrentTimer,__zero_reg__
	sts s_overcurrentTimer+1,__zero_reg__
	cpi r24,-79
	sbci r25,54
	brsh .L9
	ldd r24,Y+18
	cpi r24,lo8(6)
	brne .L9
	std Y+18,__zero_reg__
	ldd r24,Y+14
	cpi r24,lo8(14)
	brne .L9
	ldi r24,lo8(2)
	std Y+14,r24
.L9:
	ldd r24,Y+5
	ldd r25,Y+6
	cpi r24,-123
	ldi r19,3
	cpc r25,r19
	brlo .L11
	ldd r24,Y+17
	ori r24,lo8(1<<0)
	std Y+17,r24
	ldi r24,lo8(2)
	std Y+18,r24
	ldd r24,Y+14
	cpi r24,lo8(2)
	breq .L12
	cpi r24,lo8(4)
	breq .+2
	rjmp .L1
.L12:
	ldi r24,lo8(11)
	std Y+14,r24
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
/* epilogue start */
	pop r29
	pop r28
	jmp GPIO_SetPinValue
.L11:
	sbrs r18,0
	rjmp .L14
	cpi r24,82
	sbci r25,3
	brsh .L14
	ldd r24,Y+17
	andi r24,lo8(~(1<<0))
	std Y+17,r24
	std Y+18,__zero_reg__
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldd r24,Y+14
	cpi r24,lo8(11)
.L28:
	breq .+2
	rjmp .L1
	ldi r24,lo8(2)
	rjmp .L29
.L14:
	ldd r24,Y+14
	cpi r24,lo8(11)
	breq .+2
	rjmp .L1
	ldd r24,Y+18
	cpi r24,lo8(0)
	rjmp .L28
	.size	SAF_Evaluate, .-SAF_Evaluate
	.section	.text.SAF_Active,"ax",@progbits
.global	SAF_Active
	.type	SAF_Active, @function
SAF_Active:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L36
	ldd r24,Z+17
	sbrc r24,3
	rjmp .L36
	ldd r24,Z+18
	cpse r24,__zero_reg__
	rjmp .L36
	ldd r25,Z+14
	subi r25,lo8(-(-14))
	ldi r24,lo8(1)
	cpi r25,lo8(2)
	brlo .L31
	ldi r24,0
	ret
.L36:
	ldi r24,lo8(1)
.L31:
/* epilogue start */
	ret
	.size	SAF_Active, .-SAF_Active
	.section	.bss.s_overcurrentTimer,"aw",@nobits
	.type	s_overcurrentTimer, @object
	.size	s_overcurrentTimer, 2
s_overcurrentTimer:
	.zero	2
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
