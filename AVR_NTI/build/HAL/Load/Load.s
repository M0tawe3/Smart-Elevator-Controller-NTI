	.file	"Load.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LOAD_Init,"ax",@progbits
.global	LOAD_Init
	.type	LOAD_Init, @function
LOAD_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	call ADC_Init
	sts g_overloadLatched,__zero_reg__
	sts g_loadReadValid,__zero_reg__
/* epilogue start */
	ret
	.size	LOAD_Init, .-LOAD_Init
	.section	.text.LOAD_ReadKg,"ax",@progbits
.global	LOAD_ReadKg
	.type	LOAD_ReadKg, @function
LOAD_ReadKg:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(1)
	call ADC_ReadChannel
	or r24,r25
	breq .L3
	sts g_loadReadValid,__zero_reg__
	ldi r24,0
	ldi r25,0
.L2:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L3:
	ldi r24,lo8(1)
	sts g_loadReadValid,r24
	ldd r18,Y+1
	ldd r19,Y+2
	cpi r19,4
	brlo .L5
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
.L5:
	ldi r26,lo8(-24)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
	rjmp .L2
	.size	LOAD_ReadKg, .-LOAD_ReadKg
	.section	.text.LOAD_IsOverloaded,"ax",@progbits
.global	LOAD_IsOverloaded
	.type	LOAD_IsOverloaded, @function
LOAD_IsOverloaded:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call LOAD_ReadKg
	lds r18,g_loadReadValid
	cpi r18,lo8(0)
	breq .L10
	cpi r24,-124
	ldi r18,3
	cpc r25,r18
	brlo .L8
	ldi r24,lo8(1)
	sts g_overloadLatched,r24
.L9:
	lds r24,g_overloadLatched
	ret
.L8:
	cpi r24,83
	sbci r25,3
	brsh .L9
	sts g_overloadLatched,__zero_reg__
	rjmp .L9
.L10:
	ldi r24,lo8(1)
/* epilogue start */
	ret
	.size	LOAD_IsOverloaded, .-LOAD_IsOverloaded
	.section	.bss.g_loadReadValid,"aw",@nobits
	.type	g_loadReadValid, @object
	.size	g_loadReadValid, 1
g_loadReadValid:
	.zero	1
	.section	.bss.g_overloadLatched,"aw",@nobits
	.type	g_overloadLatched, @object
	.size	g_overloadLatched, 1
g_overloadLatched:
	.zero	1
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
