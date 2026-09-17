	.file	"UART.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.UART_Init,"ax",@progbits
.global	UART_Init
	.type	UART_Init, @function
UART_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	sbci r23,hi8(0)
	sbci r22,lo8(0)
	breq .L3
	movw r18,r22
	movw r20,r24
	ldi r24,4
	1:
	lsl r18
	rol r19
	rol r20
	rol r21
	dec r24
	brne 1b
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,1
	sbci r19,0
	out 0x20,r19
	out 0x9,r18
	in r24,0x20
	ori r24,lo8(-122)
	out 0x20,r24
	in r24,0xa
	ori r24,lo8(24)
	out 0xa,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_Init, .-UART_Init
	.section	.text.UART_SendByte,"ax",@progbits
.global	UART_SendByte
	.type	UART_SendByte, @function
UART_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L5:
	sbis 0xb,5
	rjmp .L5
	out 0xc,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SendByte, .-UART_SendByte
	.section	.text.UART_ReceiveByte,"ax",@progbits
.global	UART_ReceiveByte
	.type	UART_ReceiveByte, @function
UART_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L11
.L10:
	sbis 0xb,7
	rjmp .L10
	in r18,0xc
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L11:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_ReceiveByte, .-UART_ReceiveByte
	.section	.text.UART_SendString,"ax",@progbits
.global	UART_SendString
	.type	UART_SendString, @function
UART_SendString:
	push r16
	push r17
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r16,r24
	ldi r28,0
	or r24,r25
	brne .L16
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L14
.L17:
	call UART_SendByte
	subi r28,lo8(-(1))
.L16:
	movw r30,r16
	add r30,r28
	adc r31,__zero_reg__
	ld r24,Z
	cpse r24,__zero_reg__
	rjmp .L17
	ldi r24,0
	ldi r25,0
.L14:
/* epilogue start */
	pop r28
	pop r17
	pop r16
	ret
	.size	UART_SendString, .-UART_SendString
	.section	.text.UART_IsDataReady,"ax",@progbits
.global	UART_IsDataReady
	.type	UART_IsDataReady, @function
UART_IsDataReady:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	clr r24
	sbis 0xb,7
	inc r24
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_IsDataReady, .-UART_IsDataReady
	.section	.text.UART_SetRxInterrupt,"ax",@progbits
.global	UART_SetRxInterrupt
	.type	UART_SetRxInterrupt, @function
UART_SetRxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpse r24,__zero_reg__
	rjmp .L21
	cbi 0xa,7
.L22:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L21:
	sbi 0xa,7
	rjmp .L22
	.size	UART_SetRxInterrupt, .-UART_SetRxInterrupt
	.section	.text.UART_SetTxInterrupt,"ax",@progbits
.global	UART_SetTxInterrupt
	.type	UART_SetTxInterrupt, @function
UART_SetTxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpse r24,__zero_reg__
	rjmp .L24
	cbi 0xa,5
.L25:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L24:
	sbi 0xa,5
	rjmp .L25
	.size	UART_SetTxInterrupt, .-UART_SetTxInterrupt
	.section	.text.UART_SetRxCallback,"ax",@progbits
.global	UART_SetRxCallback
	.type	UART_SetRxCallback, @function
UART_SetRxCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_uartRxCallback,r24
	sts g_uartRxCallback+1,r25
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetRxCallback, .-UART_SetRxCallback
	.section	.text.__vector_13,"ax",@progbits
.global	__vector_13
	.type	__vector_13, @function
__vector_13:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	in r24,0xc
	lds r30,g_uartRxCallback
	lds r31,g_uartRxCallback+1
	sbiw r30,0
	breq .L27
	icall
.L27:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_13, .-__vector_13
	.section	.bss.g_uartRxCallback,"aw",@nobits
	.type	g_uartRxCallback, @object
	.size	g_uartRxCallback, 2
g_uartRxCallback:
	.zero	2
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
