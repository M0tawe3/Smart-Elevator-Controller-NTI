	.file	"slots.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.slots_init,"ax",@progbits
.global	slots_init
	.type	slots_init, @function
slots_init:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,lo8(2)
.L3:
	ldi r20,lo8(2)
	mov r22,r28
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	sbiw r24,0
	brne .L4
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L3
.L1:
/* epilogue start */
	pop r28
	ret
.L4:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L1
	.size	slots_init, .-slots_init
	.section	.text.slots_read_raw,"ax",@progbits
.global	slots_read_raw
	.type	slots_read_raw, @function
slots_read_raw:
	push r12
	push r13
	push r15
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 8 */
.L__stack_usage = 8
	movw r12,r24
	or r24,r25
	breq .L7
	ldi r16,lo8(2)
	ldi r17,0
	mov r15,__zero_reg__
.L11:
	std Y+1,__zero_reg__
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	mov r22,r16
	ldi r24,lo8(2)
	call GPIO_GetPinValue
	sbiw r24,0
	breq .L8
.L7:
	ldi r24,lo8(1)
	ldi r25,0
.L6:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r13
	pop r12
	ret
.L8:
	ldd r18,Y+1
	cpse r18,__zero_reg__
	rjmp .L10
	ldi r18,lo8(1)
	mov r0,r16
	rjmp 2f
	1:
	lsl r18
	2:
	dec r0
	brpl 1b
	or r15,r18
.L10:
	subi r16,-1
	sbci r17,-1
	cpi r16,8
	cpc r17,__zero_reg__
	brne .L11
	movw r30,r12
	st Z,r15
	rjmp .L6
	.size	slots_read_raw, .-slots_read_raw
	.section	.text.slots_read_active_low,"ax",@progbits
.global	slots_read_active_low
	.type	slots_read_active_low, @function
slots_read_active_low:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp slots_read_raw
	.size	slots_read_active_low, .-slots_read_active_low
	.ident	"GCC: (SUSE Linux) 15.3.0"
