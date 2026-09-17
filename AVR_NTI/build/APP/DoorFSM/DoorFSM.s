	.file	"DoorFSM.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.DoorFSM_Init,"ax",@progbits
.global	DoorFSM_Init
	.type	DoorFSM_Init, @function
DoorFSM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_doorState,__zero_reg__
	sts g_doorState+1,__zero_reg__
	sts g_obstructionCount,__zero_reg__
	call DRV_Init
	jmp DRV_Stop
	.size	DoorFSM_Init, .-DoorFSM_Init
	.section	.text.DoorFSM_Open,"ax",@progbits
.global	DoorFSM_Open
	.type	DoorFSM_Open, @function
DoorFSM_Open:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	ldi r25,0
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	call DRV_SetDir
	ldi r24,lo8(60)
	jmp DRV_SetDuty
	.size	DoorFSM_Open, .-DoorFSM_Open
	.section	.text.DoorFSM_Close,"ax",@progbits
.global	DoorFSM_Close
	.type	DoorFSM_Close, @function
DoorFSM_Close:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(3)
	ldi r25,0
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	ldi r24,lo8(2)
	call DRV_SetDir
	ldi r24,lo8(60)
	jmp DRV_SetDuty
	.size	DoorFSM_Close, .-DoorFSM_Close
	.section	.text.DoorFSM_Update,"ax",@progbits
.global	DoorFSM_Update
	.type	DoorFSM_Update, @function
DoorFSM_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_doorState
	lds r19,g_doorState+1
	cpi r18,4
	cpc r19,__zero_reg__
	brne .L5
.L11:
	jmp DRV_Stop
.L5:
	cpi r24,lo8(0)
	breq .L6
	lds r24,g_obstructionCount
	subi r24,lo8(-(1))
	sts g_obstructionCount,r24
	cpi r24,lo8(3)
	brlo .L7
	ldi r24,lo8(4)
.L12:
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	rjmp .L11
.L7:
	subi r18,1
	sbci r19,0
	cpi r18,3
	sbci r19,0
	brsh .L4
	ldi r24,lo8(1)
	ldi r25,0
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	call DRV_SetDir
	ldi r24,lo8(50)
	jmp DRV_SetDuty
.L6:
	sts g_obstructionCount,__zero_reg__
	cpi r18,1
	cpc r19,__zero_reg__
	brne .L10
	ldi r24,lo8(2)
	rjmp .L12
.L10:
	cpi r18,3
	sbci r19,0
	brne .L4
	sts g_doorState,__zero_reg__
	sts g_doorState+1,__zero_reg__
	rjmp .L11
.L4:
/* epilogue start */
	ret
	.size	DoorFSM_Update, .-DoorFSM_Update
	.section	.text.DoorFSM_UpdatePosition,"ax",@progbits
.global	DoorFSM_UpdatePosition
	.type	DoorFSM_UpdatePosition, @function
DoorFSM_UpdatePosition:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_doorState
	lds r19,g_doorState+1
	cpi r18,4
	cpc r19,__zero_reg__
	brne .L14
.L26:
	jmp DRV_Stop
.L14:
	cpi r24,lo8(0)
	breq .L15
	lds r24,g_obstructionCount
	subi r24,lo8(-(1))
	sts g_obstructionCount,r24
	cpi r24,lo8(3)
	brlo .L16
	ldi r24,lo8(4)
.L27:
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	rjmp .L26
.L16:
	cpi r18,3
	cpc r19,__zero_reg__
	brne .L17
	ldi r24,lo8(1)
	ldi r25,0
	sts g_doorState,r24
	sts g_doorState+1,__zero_reg__
	call DRV_SetDir
	ldi r24,lo8(50)
	jmp DRV_SetDuty
.L15:
	sts g_obstructionCount,__zero_reg__
	cpi r18,1
	cpc r19,__zero_reg__
	brne .L18
.L22:
	cpi r22,lo8(95)
	brlo .L13
	ldi r24,lo8(2)
	rjmp .L27
.L18:
	cpi r18,3
	sbci r19,0
	brne .L13
	cpi r22,lo8(6)
	brsh .L13
	sts g_doorState,__zero_reg__
	sts g_doorState+1,__zero_reg__
	rjmp .L26
.L17:
	cpi r18,1
	sbci r19,0
	breq .L22
.L13:
/* epilogue start */
	ret
	.size	DoorFSM_UpdatePosition, .-DoorFSM_UpdatePosition
	.section	.text.DoorFSM_GetState,"ax",@progbits
.global	DoorFSM_GetState
	.type	DoorFSM_GetState, @function
DoorFSM_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_doorState
	lds r25,g_doorState+1
/* epilogue start */
	ret
	.size	DoorFSM_GetState, .-DoorFSM_GetState
	.section	.bss.g_obstructionCount,"aw",@nobits
	.type	g_obstructionCount, @object
	.size	g_obstructionCount, 1
g_obstructionCount:
	.zero	1
	.section	.bss.g_doorState,"aw",@nobits
	.type	g_doorState, @object
	.size	g_doorState, 2
g_doorState:
	.zero	2
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
