	.file	"dispatch.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.callsAbove,"ax",@progbits
	.type	callsAbove, @function
callsAbove:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L4
	cpi r22,lo8(3)
	brsh .L4
	ld r25,Z
	ldd r24,Z+1
	or r25,r24
	ldd r24,Z+2
	or r25,r24
	subi r22,lo8(-(1))
	ldi r18,lo8(-1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	and r25,r18
	mov r24,r25
	andi r24,lo8(15)
	ret
.L4:
	ldi r24,0
/* epilogue start */
	ret
	.size	callsAbove, .-callsAbove
	.section	.text.callsBelow,"ax",@progbits
	.type	callsBelow, @function
callsBelow:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L8
	ldi r24,lo8(-1)
	add r24,r22
	cpi r24,lo8(3)
	brsh .L8
	ld r25,Z
	ldd r24,Z+1
	or r25,r24
	ldd r24,Z+2
	or r24,r25
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	subi r18,lo8(-(-1))
	and r24,r18
	ret
.L8:
	ldi r24,0
/* epilogue start */
	ret
	.size	callsBelow, .-callsBelow
	.section	.text.DSP_ShouldStop,"ax",@progbits
.global	DSP_ShouldStop
	.type	DSP_ShouldStop, @function
DSP_ShouldStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	brne .+2
	rjmp .L18
	cpi r22,lo8(4)
	brlo .+2
	rjmp .L18
	movw r30,r24
	ld r18,Z
	ldi r19,0
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	sbrc r18,0
	rjmp .L22
	cpi r20,1
	cpc r21,__zero_reg__
	brne .L12
	ldd r18,Z+1
	ldi r19,0
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	sbrs r18,0
	rjmp .L31
.L22:
	ldi r25,lo8(1)
.L11:
	ldi r24,lo8(1)
	eor r24,r25
	ldi r25,0
	ret
.L12:
	cpi r20,2
	cpc r21,__zero_reg__
	brne .L24
	ldd r18,Z+2
	ldi r19,0
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	sbrc r18,0
	rjmp .L22
	ldd r18,Z+1
	ldi r19,0
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	sbrs r18,0
	rjmp .L24
	call callsBelow
	rjmp .L33
.L31:
	ldd r18,Z+2
	ldi r19,0
	mov r0,r22
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r0
	brpl 1b
	sbrs r18,0
	rjmp .L24
	call callsAbove
.L33:
	ldi r25,lo8(1)
	cp r24, __zero_reg__
	breq .L11
.L24:
	ldi r25,0
	rjmp .L11
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DSP_ShouldStop, .-DSP_ShouldStop
	.section	.text.DSP_AddCall,"ax",@progbits
.global	DSP_AddCall
	.type	DSP_AddCall, @function
DSP_AddCall:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L41
	ldi r24,lo8(1)
	ldi r25,0
	cpi r22,lo8(4)
	brsh .L40
	movw r18,r24
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r20,1
	cpc r21,__zero_reg__
	breq .L36
	cpi r20,2
	cpc r21,__zero_reg__
	breq .L37
	or r20,r21
	brne .L41
	ld r24,Z
	or r24,r18
	st Z,r24
.L38:
	ldi r24,0
	ret
.L36:
	ldd r24,Z+1
	or r24,r18
	std Z+1,r24
	rjmp .L38
.L37:
	ldd r24,Z+2
	or r24,r18
	std Z+2,r24
	rjmp .L38
.L40:
	ret
.L41:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DSP_AddCall, .-DSP_AddCall
	.section	.text.DSP_ClearFloor,"ax",@progbits
.global	DSP_ClearFloor
	.type	DSP_ClearFloor, @function
DSP_ClearFloor:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldi r24,lo8(1)
	ldi r25,0
	sbiw r30,0
	breq .L44
	cpi r22,lo8(4)
	brsh .L45
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	ld r25,Z
	and r25,r24
	st Z,r25
	ldd r25,Z+1
	and r25,r24
	std Z+1,r25
	ldd r25,Z+2
	and r24,r25
	std Z+2,r24
	ldi r24,0
	ldi r25,0
	ret
.L44:
	ret
.L45:
/* epilogue start */
	ret
	.size	DSP_ClearFloor, .-DSP_ClearFloor
	.section	.text.DSP_NextDirection,"ax",@progbits
.global	DSP_NextDirection
	.type	DSP_NextDirection, @function
DSP_NextDirection:
	push r16
	push r17
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 7 */
.L__stack_usage = 7
	movw r16,r24
	std Y+1,r22
	std Y+2,r20
	std Y+3,r21
	ldd r18,Y+2
	ldd r19,Y+3
	cpi r18,1
	cpc r19,__zero_reg__
	brne .L47
	call callsAbove
	cpse r24,__zero_reg__
	rjmp .L48
	ldd r22,Y+1
	movw r24,r16
	call callsBelow
	cp r24, __zero_reg__
	breq .L49
	ldi r18,lo8(2)
	std Y+2,r18
	std Y+3,__zero_reg__
.L48:
	ldd r24,Y+2
	ldd r25,Y+3
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L47:
	ldd r24,Y+2
	ldd r25,Y+3
	sbiw r24,2
	brne .L50
	ldd r22,Y+1
	movw r24,r16
	call callsBelow
	cpse r24,__zero_reg__
	rjmp .L48
.L50:
	ldd r22,Y+1
	movw r24,r16
	call callsAbove
	cpse r24,__zero_reg__
	rjmp .L53
.L49:
	ldd r22,Y+1
	movw r24,r16
	call callsBelow
	ldi r18,lo8(1)
	std Y+2,r18
	std Y+3,__zero_reg__
	cpse r24,__zero_reg__
	rjmp .L51
	std Y+2,__zero_reg__
	std Y+3,__zero_reg__
.L51:
	ldd r24,Y+2
	ldd r25,Y+3
	lsl r24
	rol r25
.L54:
	std Y+2,r24
	std Y+3,r25
	rjmp .L48
.L53:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L54
	.size	DSP_NextDirection, .-DSP_NextDirection
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
