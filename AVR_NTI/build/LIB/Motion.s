	.file	"Motion.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.MOT_GoTo,"ax",@progbits
.global	MOT_GoTo
	.type	MOT_GoTo, @function
MOT_GoTo:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L3
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(s_floorCm))
	sbci r31,hi8(-(s_floorCm))
	ld r24,Z
	ldd r25,Z+1
	sts s_targetPositionCm,r24
	sts s_targetPositionCm+1,r25
	sts s_accelCounter,__zero_reg__
	sts s_accelCounter+1,__zero_reg__
	sts s_relevelCount,__zero_reg__
	ldi r24,lo8(1)
	sts s_motionActive,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	MOT_GoTo, .-MOT_GoTo
	.section	.text.MOT_Stop,"ax",@progbits
.global	MOT_Stop
	.type	MOT_Stop, @function
MOT_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts s_motionActive,__zero_reg__
	sts s_accelCounter,__zero_reg__
	sts s_accelCounter+1,__zero_reg__
	jmp HST_Brake
	.size	MOT_Stop, .-MOT_Stop
	.section	.text.MOT_AtTarget,"ax",@progbits
.global	MOT_AtTarget
	.type	MOT_AtTarget, @function
MOT_AtTarget:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,s_targetPositionCm
	lds r19,s_targetPositionCm+1
	cp r24,r18
	cpc r25,r19
	brlo .L6
	movw r20,r24
	sub r20,r18
	sbc r21,r19
	movw r18,r20
.L7:
	ldi r24,lo8(1)
	cpi r18,4
	sbci r19,0
	brlo .L8
	ldi r24,0
.L8:
/* epilogue start */
	ret
.L6:
	sub r18,r24
	sbc r19,r25
	rjmp .L7
	.size	MOT_AtTarget, .-MOT_AtTarget
	.section	.text.MOT_Step,"ax",@progbits
.global	MOT_Step
	.type	MOT_Step, @function
MOT_Step:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	or r24,r25
	breq .L9
	lds r24,s_motionActive
	cpi r24,lo8(0)
	breq .L9
	ldd r24,Y+14
	subi r24,lo8(-(-14))
	cpi r24,lo8(2)
	brlo .L11
	ldd r24,Y+18
	cpi r24,lo8(0)
	breq .L12
.L11:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	jmp MOT_Stop
.L12:
	ld r16,Y
	ldd r17,Y+1
	lds r24,s_targetPositionCm
	lds r25,s_targetPositionCm+1
	cp r16,r24
	cpc r17,r25
	brsh .L13
	movw r18,r24
	sub r18,r16
	sbc r19,r17
	movw r16,r18
	ldi r24,lo8(1)
.L14:
	cpi r16,4
	cpc r17,__zero_reg__
	brsh .L16
.L15:
	call HST_Brake
	std Y+16,__zero_reg__
	std Y+12,__zero_reg__
	ldd r24,Y+17
	ori r24,lo8(1<<5)
	std Y+17,r24
	sts s_motionActive,__zero_reg__
.L9:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L13:
	breq .L15
	brlo .L15
	sub r16,r24
	sbc r17,r25
	ldi r24,lo8(2)
	rjmp .L14
.L16:
	ldd r25,Y+17
	andi r25,lo8(~(1<<5))
	std Y+17,r25
	std Y+12,r24
	ldi r25,0
	call HST_SetDir
	cpi r16,16
	cpc r17,__zero_reg__
	brsh .L17
	ldi r24,lo8(9)
	std Y+14,r24
	ldi r24,lo8(15)
.L18:
	std Y+16,r24
	ldd r22,Y+4
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	jmp HST_SetDuty
.L17:
	cpi r16,61
	sbci r17,0
	brsh .L19
	ldi r24,lo8(8)
	std Y+14,r24
	ldi r24,lo8(30)
	rjmp .L18
.L19:
	ldi r24,lo8(7)
	std Y+14,r24
	lds r24,s_accelCounter
	lds r25,s_accelCounter+1
	cpi r24,50
	cpc r25,__zero_reg__
	brsh .L20
	adiw r24,1
	sts s_accelCounter,r24
	sts s_accelCounter+1,r25
	lsl r24
	rjmp .L18
.L20:
	ldi r24,lo8(100)
	rjmp .L18
	.size	MOT_Step, .-MOT_Step
	.section	.text.MOT_RelevelCheck,"ax",@progbits
.global	MOT_RelevelCheck
	.type	MOT_RelevelCheck, @function
MOT_RelevelCheck:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	breq .L27
	ld r18,Y
	ldd r19,Y+1
	lds r24,s_targetPositionCm
	lds r25,s_targetPositionCm+1
	cp r18,r24
	cpc r19,r25
	brlo .L29
	movw r20,r18
	sub r20,r24
	sbc r21,r25
	movw r24,r20
.L30:
	sbiw r24,4
	brlo .L27
	lds r24,s_relevelCount
	subi r24,lo8(-(1))
	sts s_relevelCount,r24
	cpi r24,lo8(3)
	brlo .L31
	call MOT_Stop
	ldi r24,lo8(7)
	std Y+18,r24
	ldi r24,lo8(14)
	std Y+14,r24
.L27:
/* epilogue start */
	pop r29
	pop r28
	ret
.L29:
	sub r24,r18
	sbc r25,r19
	rjmp .L30
.L31:
	ldi r24,lo8(1)
	sts s_motionActive,r24
	rjmp .L27
	.size	MOT_RelevelCheck, .-MOT_RelevelCheck
	.section	.bss.s_motionActive,"aw",@nobits
	.type	s_motionActive, @object
	.size	s_motionActive, 1
s_motionActive:
	.zero	1
	.section	.bss.s_relevelCount,"aw",@nobits
	.type	s_relevelCount, @object
	.size	s_relevelCount, 1
s_relevelCount:
	.zero	1
	.section	.bss.s_accelCounter,"aw",@nobits
	.type	s_accelCounter, @object
	.size	s_accelCounter, 2
s_accelCounter:
	.zero	2
	.section	.bss.s_targetPositionCm,"aw",@nobits
	.type	s_targetPositionCm, @object
	.size	s_targetPositionCm, 2
s_targetPositionCm:
	.zero	2
	.section	.rodata.s_floorCm,"a"
	.type	s_floorCm, @object
	.size	s_floorCm, 8
s_floorCm:
	.word	0
	.word	300
	.word	600
	.word	900
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
.global __do_clear_bss
