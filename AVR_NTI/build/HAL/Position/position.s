	.file	"position.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.POS_cm,"ax",@progbits
.global	POS_cm
	.type	POS_cm, @function
POS_cm:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,0
	call ADC_ReadChannel
	or r24,r25
	brne .L3
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-24)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
.L1:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L3:
	ldi r24,0
	ldi r25,0
	rjmp .L1
	.size	POS_cm, .-POS_cm
	.section	.text.POS_nearestFloor,"ax",@progbits
.global	POS_nearestFloor
	.type	POS_nearestFloor, @function
POS_nearestFloor:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,-106
	cpc r25,__zero_reg__
	brlo .L6
	cpi r24,-62
	ldi r18,1
	cpc r25,r18
	brlo .L7
	cpi r24,-18
	sbci r25,2
	brsh .L8
	ldi r24,lo8(2)
	ret
.L6:
	ldi r24,0
	ret
.L7:
	ldi r24,lo8(1)
	ret
.L8:
	ldi r24,lo8(3)
/* epilogue start */
	ret
	.size	POS_nearestFloor, .-POS_nearestFloor
	.section	.text.POS_InLevelZone,"ax",@progbits
.global	POS_InLevelZone
	.type	POS_InLevelZone, @function
POS_InLevelZone:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	call POS_nearestFloor
	cpi r24,lo8(1)
	breq .L15
	cpi r24,lo8(2)
	breq .L16
	cpi r24,lo8(0)
	breq .L17
	ldi r24,lo8(-124)
	ldi r25,lo8(3)
.L10:
	cp r28,r24
	cpc r29,r25
	brlo .L12
.L11:
	sub r28,r24
	sbc r29,r25
.L13:
	ldi r24,lo8(1)
	sbiw r28,4
	brlo .L14
	ldi r24,0
.L14:
/* epilogue start */
	pop r29
	pop r28
	ret
.L15:
	ldi r24,lo8(44)
	ldi r25,lo8(1)
	rjmp .L10
.L16:
	ldi r24,lo8(88)
	ldi r25,lo8(2)
	rjmp .L10
.L17:
	ldi r24,0
	ldi r25,0
	rjmp .L11
.L12:
	movw r18,r24
	sub r18,r28
	sbc r19,r29
	movw r28,r18
	rjmp .L13
	.size	POS_InLevelZone, .-POS_InLevelZone
	.ident	"GCC: (SUSE Linux) 15.3.0"
