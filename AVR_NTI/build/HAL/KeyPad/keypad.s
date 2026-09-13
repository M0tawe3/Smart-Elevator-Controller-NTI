	.file	"keypad.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.keypad_init,"ax",@progbits
.global	keypad_init
	.type	keypad_init, @function
keypad_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(15)
	jmp GPIO_SetPortDirection
	.size	keypad_init, .-keypad_init
	.section	.text.keypad_get_keypressed,"ax",@progbits
.global	keypad_get_keypressed
	.type	keypad_get_keypressed, @function
keypad_get_keypressed:
	push r12
	push r13
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 9 */
.L__stack_usage = 9
	std Y+2,r24
	movw r12,r22
	or r22,r23
	breq .L3
	ldi r22,lo8(15)
	call GPIO_SetPortDirection
	ldi r16,0
	ldi r17,0
.L7:
	ldi r22,lo8(1)
	mov r0,r16
	rjmp 2f
	1:
	lsl r22
	2:
	dec r0
	brpl 1b
	com r22
	ldd r24,Y+2
	call GPIO_SetPortValue
	mov r15,__zero_reg__
.L6:
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	ldi r22,lo8(4)
	add r22,r15
	ldd r24,Y+2
	call GPIO_GetPinValue
	ldd r24,Y+1
	cpse r24,__zero_reg__
	rjmp .L4
	lsl r16
	rol r17
	lsl r16
	rol r17
	subi r16,lo8(-(keypad_map))
	sbci r17,hi8(-(keypad_map))
	movw r30,r16
	add r30,r15
	adc r31,__zero_reg__
	ld r24,Z
	movw r30,r12
	st Z,r24
	ldi r24,0
	ldi r25,0
.L2:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r13
	pop r12
	ret
.L4:
	inc r15
	ldi r31,lo8(4)
	cpse r15,r31
	rjmp .L6
	subi r16,-1
	sbci r17,-1
	cpi r16,4
	cpc r17,__zero_reg__
	brne .L7
.L3:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L2
	.size	keypad_get_keypressed, .-keypad_get_keypressed
.global	keypad_map
	.section	.data.keypad_map,"aw"
	.type	keypad_map, @object
	.size	keypad_map, 16
keypad_map:
	.base64	"AQIDQQ=="
	.base64	"BAUGQg=="
	.base64	"BwgJQw=="
	.string	"*"
	.ascii	"#D"
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
