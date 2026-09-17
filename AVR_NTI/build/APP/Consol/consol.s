	.file	"consol.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.CONS_Init,"ax",@progbits
.global	CONS_Init
	.type	CONS_Init, @function
CONS_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_rxLen,__zero_reg__
	sts g_calls,__zero_reg__
	sts g_calls+1,__zero_reg__
	sts g_calls+2,__zero_reg__
	ldi r22,lo8(-128)
	ldi r23,lo8(37)
	ldi r24,0
	ldi r25,0
	call UART_Init
	ldi r24,lo8(1)
	call UART_SetRxInterrupt
	ldi r24,lo8(gs(CONS_HandleByte))
	ldi r25,hi8(gs(CONS_HandleByte))
	call UART_SetRxCallback
	jmp INTERRUPT_EnableGlobal
	.size	CONS_Init, .-CONS_Init
	.section	.rodata.CONS_SendTelemetry.str1.1,"aMS",@progbits,1
.LC0:
	.string	"OK\r\n"
	.section	.text.CONS_SendTelemetry,"ax",@progbits
.global	CONS_SendTelemetry
	.type	CONS_SendTelemetry, @function
CONS_SendTelemetry:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	jmp UART_SendString
	.size	CONS_SendTelemetry, .-CONS_SendTelemetry
	.section	.rodata.CONS_ParseCommand.str1.1,"aMS",@progbits,1
.LC1:
	.string	"PAGE "
.LC2:
	.string	"CALL "
.LC3:
	.string	"UP"
.LC4:
	.string	"DOWN"
.LC5:
	.string	"CAR"
.LC6:
	.string	"CC"
.LC7:
	.string	"HU"
.LC8:
	.string	"HD"
	.section	.text.CONS_ParseCommand,"ax",@progbits
.global	CONS_ParseCommand
	.type	CONS_ParseCommand, @function
CONS_ParseCommand:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	sbiw r24,0
	breq .L3
	ldi r20,lo8(5)
	ldi r21,0
	ldi r22,lo8(.LC1)
	ldi r23,hi8(.LC1)
	call strncmp
	or r24,r25
	breq .L3
	ldi r20,lo8(5)
	ldi r21,0
	ldi r22,lo8(.LC2)
	ldi r23,hi8(.LC2)
	movw r24,r28
	call strncmp
	or r24,r25
	brne .L5
	ldd r17,Y+5
	subi r17,lo8(-(-48))
	cpi r17,lo8(4)
	brsh .L3
	ldd r24,Y+6
	cpi r24,lo8(32)
	brne .L3
	adiw r28,7
	ldi r22,lo8(.LC3)
	ldi r23,hi8(.LC3)
	movw r24,r28
	call strcmp
	ldi r20,lo8(1)
	ldi r21,0
	or r24,r25
	breq .L21
	ldi r22,lo8(.LC4)
	ldi r23,hi8(.LC4)
	movw r24,r28
	call strcmp
	or r24,r25
	brne .L7
	ldi r20,lo8(2)
	ldi r21,0
.L21:
	mov r22,r17
	ldi r24,lo8(g_calls)
	ldi r25,hi8(g_calls)
/* epilogue start */
	pop r29
	pop r28
	pop r17
	jmp DSP_AddCall
.L7:
	ldi r22,lo8(.LC5)
	ldi r23,hi8(.LC5)
	movw r24,r28
	call strcmp
	ldi r20,0
	ldi r21,0
	or r24,r25
	breq .L21
.L3:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
.L5:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	movw r24,r28
	call strncmp
	or r24,r25
	breq .L8
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(.LC7)
	ldi r23,hi8(.LC7)
	movw r24,r28
	call strncmp
	or r24,r25
	breq .L8
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(.LC8)
	ldi r23,hi8(.LC8)
	movw r24,r28
	call strncmp
	or r24,r25
	brne .L3
.L8:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	jmp CONS_SendTelemetry
	.size	CONS_ParseCommand, .-CONS_ParseCommand
	.section	.text.CONS_HandleByte,"ax",@progbits
.global	CONS_HandleByte
	.type	CONS_HandleByte, @function
CONS_HandleByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_rxLen
	cpi r24,lo8(13)
	breq .L23
	cpi r24,lo8(10)
	brne .L24
.L23:
	cpi r30,lo8(0)
	breq .L22
	ldi r31,0
	subi r30,lo8(-(g_rxBuffer))
	sbci r31,hi8(-(g_rxBuffer))
	st Z,__zero_reg__
	ldi r24,lo8(g_rxBuffer)
	ldi r25,hi8(g_rxBuffer)
	call CONS_ParseCommand
	sts g_rxLen,__zero_reg__
	ret
.L24:
	cpi r30,lo8(31)
	brsh .L22
	ldi r25,lo8(1)
	add r25,r30
	sts g_rxLen,r25
	ldi r31,0
	subi r30,lo8(-(g_rxBuffer))
	sbci r31,hi8(-(g_rxBuffer))
	st Z,r24
.L22:
/* epilogue start */
	ret
	.size	CONS_HandleByte, .-CONS_HandleByte
	.section	.text.CONS_Task,"ax",@progbits
.global	CONS_Task
	.type	CONS_Task, @function
CONS_Task:
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	call UART_IsDataReady
	or r24,r25
	brne .L32
	std Y+1,__zero_reg__
	movw r24,r28
	adiw r24,1
	call UART_ReceiveByte
	ldd r24,Y+1
	call CONS_HandleByte
.L32:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	CONS_Task, .-CONS_Task
	.section	.text.CONS_GetCalls,"ax",@progbits
.global	CONS_GetCalls
	.type	CONS_GetCalls, @function
CONS_GetCalls:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(g_calls)
	ldi r25,hi8(g_calls)
/* epilogue start */
	ret
	.size	CONS_GetCalls, .-CONS_GetCalls
	.section	.bss.g_calls,"aw",@nobits
	.type	g_calls, @object
	.size	g_calls, 3
g_calls:
	.zero	3
	.section	.bss.g_rxLen,"aw",@nobits
	.type	g_rxLen, @object
	.size	g_rxLen, 1
g_rxLen:
	.zero	1
	.section	.bss.g_rxBuffer,"aw",@nobits
	.type	g_rxBuffer, @object
	.size	g_rxBuffer, 32
g_rxBuffer:
	.zero	32
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
.global __do_clear_bss
