	.file	"HC165.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.BTN_Scan,"ax",@progbits
.global	BTN_Scan
	.type	BTN_Scan, @function
BTN_Scan:
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 5 */
.L__stack_usage = 5
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_SelectSlave
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(-1)
	call SPI_Transceive
	ldd r16,Y+1
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(-1)
	call SPI_Transceive
	ldd r18,Y+1
	mov r19,r16
	movw r16,r18
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call SPI_ReleaseSlave
	com r16
	com r17
	lds r18,candidateButtons
	lds r19,candidateButtons+1
	cp r18,r16
	cpc r19,r17
	brne .L2
	lds r24,candidateCount
	cpi r24,lo8(2)
	brsh .L3
	subi r24,lo8(-(1))
	sts candidateCount,r24
	cpi r24,lo8(2)
	breq .L3
.L4:
	lds r24,stableButtons
	lds r25,stableButtons+1
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L2:
	sts candidateButtons,r16
	sts candidateButtons+1,r17
	ldi r24,lo8(1)
	sts candidateCount,r24
	rjmp .L4
.L3:
	lds r24,stableButtons
	lds r25,stableButtons+1
	cp r18,r24
	cpc r19,r25
	breq .L4
	com r24
	com r25
	and r24,r18
	and r25,r19
	lds r20,pressedEdges
	lds r21,pressedEdges+1
	or r24,r20
	or r25,r21
	sts pressedEdges,r24
	sts pressedEdges+1,r25
	sts stableButtons,r18
	sts stableButtons+1,r19
	rjmp .L4
	.size	BTN_Scan, .-BTN_Scan
	.section	.text.BTN_Pressed,"ax",@progbits
.global	BTN_Pressed
	.type	BTN_Pressed, @function
BTN_Pressed:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r25,r24
	cpi r24,lo8(16)
	brsh .L11
	lds r20,pressedEdges
	lds r21,pressedEdges+1
	movw r18,r20
	rjmp 2f
	1:
	lsr r19
	ror r18
	2:
	dec r24
	brpl 1b
	mov r24,r18
	andi r24,1<<0
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	rol r19
	2:
	dec r25
	brpl 1b
	com r18
	com r19
	and r18,r20
	and r19,r21
	sts pressedEdges,r18
	sts pressedEdges+1,r19
	ret
.L11:
	ldi r24,0
/* epilogue start */
	ret
	.size	BTN_Pressed, .-BTN_Pressed
	.section	.bss.candidateCount,"aw",@nobits
	.type	candidateCount, @object
	.size	candidateCount, 1
candidateCount:
	.zero	1
	.section	.bss.pressedEdges,"aw",@nobits
	.type	pressedEdges, @object
	.size	pressedEdges, 2
pressedEdges:
	.zero	2
	.section	.bss.candidateButtons,"aw",@nobits
	.type	candidateButtons, @object
	.size	candidateButtons, 2
candidateButtons:
	.zero	2
	.section	.bss.stableButtons,"aw",@nobits
	.type	stableButtons, @object
	.size	stableButtons, 2
stableButtons:
	.zero	2
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
