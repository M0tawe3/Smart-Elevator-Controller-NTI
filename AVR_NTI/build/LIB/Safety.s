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
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	brne .+2
	rjmp .L1
	ldd r18,Z+17
	sbrs r18,3
	rjmp .L4
	ldi r24,lo8(1)
	std Z+18,r24
	ldi r24,lo8(15)
.L21:
	std Z+14,r24
	ret
.L4:
	ld r24,Z
	ldd r25,Z+1
	cpi r24,-18
	sbci r25,3
	brlo .L5
	ldi r24,lo8(2)
.L22:
	std Z+18,r24
	ldi r24,lo8(14)
	rjmp .L21
.L5:
	ldd r24,Z+4
	cpi r24,lo8(6)
	brlo .L6
	ldd r24,Z+16
	cpi r24,lo8(0)
	breq .L6
	ldi r24,lo8(8)
	rjmp .L22
.L6:
	ldd r24,Z+7
	ldd r25,Z+8
	cpi r24,-103
	sbci r25,58
	brlo .L7
	lds r24,s_overcurrentTimer
	lds r25,s_overcurrentTimer+1
	adiw r24,1
	sts s_overcurrentTimer,r24
	sts s_overcurrentTimer+1,r25
	sbiw r24,50
	brlo .L8
	ldi r24,lo8(5)
	rjmp .L22
.L7:
	sts s_overcurrentTimer,__zero_reg__
	sts s_overcurrentTimer+1,__zero_reg__
.L8:
	ldd r24,Z+5
	ldd r25,Z+6
	cpi r24,-123
	ldi r19,3
	cpc r25,r19
	brlo .L9
	ldd r24,Z+17
	ori r24,lo8(1<<0)
	std Z+17,r24
	ldd r24,Z+14
	cpi r24,lo8(2)
	breq .L10
	cpi r24,lo8(4)
	brne .L1
.L10:
	ldi r24,lo8(11)
	rjmp .L21
.L9:
	sbrs r18,0
	rjmp .L1
	cpi r24,82
	sbci r25,3
	brsh .L1
	ldd r24,Z+17
	andi r24,lo8(~(1<<0))
	std Z+17,r24
.L1:
/* epilogue start */
	ret
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
	breq .L28
	ldd r24,Z+17
	sbrc r24,3
	rjmp .L28
	ldd r24,Z+18
	cpse r24,__zero_reg__
	rjmp .L28
	ldd r25,Z+14
	subi r25,lo8(-(-14))
	ldi r24,lo8(1)
	cpi r25,lo8(2)
	brlo .L23
	ldi r24,0
	ret
.L28:
	ldi r24,lo8(1)
.L23:
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
