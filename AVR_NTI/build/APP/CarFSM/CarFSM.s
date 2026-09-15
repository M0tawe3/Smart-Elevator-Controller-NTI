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
	sts g_carState,__zero_reg__
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
	cp r24, __zero_reg__
	breq .L3
	ldi r24,lo8(3)
.L10:
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
	rjmp .L9
.L3:
	cp r22, __zero_reg__
	breq .L4
	ldi r24,lo8(2)
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
/* epilogue start */
	ret
.L4:
	cp r20, __zero_reg__
	breq .L6
	sts g_carState,__zero_reg__
	sts g_carState+1,__zero_reg__
.L9:
	jmp HST_Brake
.L6:
	cp r18, __zero_reg__
	breq .L7
	ldi r24,lo8(4)
	rjmp .L10
.L7:
	ldi r24,lo8(1)
	ldi r25,0
	sts g_carState,r24
	sts g_carState+1,__zero_reg__
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
	.section	.bss.g_carState,"aw",@nobits
	.type	g_carState, @object
	.size	g_carState, 2
g_carState:
	.zero	2
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_4.0.0_52) 15.1.0"
.global __do_clear_bss
