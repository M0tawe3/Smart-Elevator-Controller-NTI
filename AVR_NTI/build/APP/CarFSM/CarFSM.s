	.file	"CarFSM.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.CarFSM_Init,"ax",@progbits
.global	CarFSM_Init
	.type	CarFSM_Init, @function
CarFSM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(2)
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
	call DoorFSM_Init
	jmp HST_Init
	.size	CarFSM_Init, .-CarFSM_Init
	.section	.text.CarFSM_Update,"ax",@progbits
.global	CarFSM_Update
	.type	CarFSM_Update, @function
CarFSM_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(0)
	breq .L3
	ldi r24,lo8(11)
.L7:
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
	jmp HST_Brake
.L3:
	cpi r18,lo8(0)
	breq .L4
	ldi r24,lo8(14)
	rjmp .L7
.L4:
	ldi r24,lo8(4)
	cpse r22,__zero_reg__
	rjmp .L7
	ldi r24,lo8(2)
	cpse r20,__zero_reg__
	rjmp .L7
	ldi r24,lo8(7)
	ldi r25,0
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
	ldi r24,lo8(1)
	call HST_SetDir
	ldi r22,0
	ldi r24,lo8(50)
	jmp HST_SetDuty
	.size	CarFSM_Update, .-CarFSM_Update
	.section	.text.CarFSM_GetState,"ax",@progbits
.global	CarFSM_GetState
	.type	CarFSM_GetState, @function
CarFSM_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_carState
	lds r25,g_carState+1
/* epilogue start */
	ret
	.size	CarFSM_GetState, .-CarFSM_GetState
	.section	.data.g_carState,"aw"
	.type	g_carState, @object
	.size	g_carState, 2
g_carState:
	.word	2
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_copy_data
