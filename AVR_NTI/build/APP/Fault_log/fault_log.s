	.file	"fault_log.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.FL_Clear,"ax",@progbits
.global	FL_Clear
	.type	FL_Clear, @function
FL_Clear:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_faultLog)
	ldi r31,hi8(g_faultLog)
	ldi r24,lo8(16)
	movw r26,r30
	0:
	st X+,__zero_reg__
	dec r24
	brne 0b
	sts g_logHead,__zero_reg__
	sts g_logCount,__zero_reg__
/* epilogue start */
	ret
	.size	FL_Clear, .-FL_Clear
	.section	.text.FL_Init,"ax",@progbits
.global	FL_Init
	.type	FL_Init, @function
FL_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp FL_Clear
	.size	FL_Init, .-FL_Init
	.section	.text.FL_AddFault,"ax",@progbits
.global	FL_AddFault
	.type	FL_AddFault, @function
FL_AddFault:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_logCount
	lds r25,g_logHead
	mov r30,r25
	ldi r31,0
	subi r25,lo8(-(1))
	andi r25,lo8(15)
	subi r30,lo8(-(g_faultLog))
	sbci r31,hi8(-(g_faultLog))
	st Z,r24
	sts g_logHead,r25
	cpi r18,lo8(16)
	brsh .L4
	subi r18,lo8(-(1))
	sts g_logCount,r18
	ret
.L4:
/* epilogue start */
	ret
	.size	FL_AddFault, .-FL_AddFault
	.section	.text.FL_GetCount,"ax",@progbits
.global	FL_GetCount
	.type	FL_GetCount, @function
FL_GetCount:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_logCount
/* epilogue start */
	ret
	.size	FL_GetCount, .-FL_GetCount
	.section	.text.FL_ReadNewest,"ax",@progbits
.global	FL_ReadNewest
	.type	FL_ReadNewest, @function
FL_ReadNewest:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_logCount
	cpi r24,lo8(0)
	breq .L7
	lds r30,g_logHead
	subi r30,lo8(-(15))
	andi r30,lo8(15)
	ldi r31,0
	subi r30,lo8(-(g_faultLog))
	sbci r31,hi8(-(g_faultLog))
	ld r24,Z
.L7:
/* epilogue start */
	ret
	.size	FL_ReadNewest, .-FL_ReadNewest
	.section	.text.FL_ReadOldest,"ax",@progbits
.global	FL_ReadOldest
	.type	FL_ReadOldest, @function
FL_ReadOldest:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_logCount
	cpi r24,lo8(0)
	breq .L12
	lds r30,g_logHead
	sub r30,r24
	andi r30,lo8(15)
	ldi r31,0
	subi r30,lo8(-(g_faultLog))
	sbci r31,hi8(-(g_faultLog))
	ld r24,Z
.L12:
/* epilogue start */
	ret
	.size	FL_ReadOldest, .-FL_ReadOldest
	.section	.text.FL_ReadAt,"ax",@progbits
.global	FL_ReadAt
	.type	FL_ReadAt, @function
FL_ReadAt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,g_logCount
	cp r24,r25
	brsh .L19
	lds r30,g_logHead
	sub r30,r25
	add r30,r24
	andi r30,lo8(15)
	ldi r31,0
	subi r30,lo8(-(g_faultLog))
	sbci r31,hi8(-(g_faultLog))
	ld r24,Z
	ret
.L19:
	ldi r24,0
/* epilogue start */
	ret
	.size	FL_ReadAt, .-FL_ReadAt
	.section	.bss.g_logCount,"aw",@nobits
	.type	g_logCount, @object
	.size	g_logCount, 1
g_logCount:
	.zero	1
	.section	.bss.g_logHead,"aw",@nobits
	.type	g_logHead, @object
	.size	g_logHead, 1
g_logHead:
	.zero	1
	.section	.bss.g_faultLog,"aw",@nobits
	.type	g_faultLog, @object
	.size	g_faultLog, 16
g_faultLog:
	.zero	16
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
