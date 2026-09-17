	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.EmergencyStopCallback,"ax",@progbits
	.type	EmergencyStopCallback, @function
EmergencyStopCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	sts g_emergencyStopTrip,r24
	jmp HST_EmergencyStop
	.size	EmergencyStopCallback, .-EmergencyStopCallback
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,44
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 44 */
/* stack size = 44 */
.L__stack_usage = 44
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	ldi r24,lo8(33)
	movw r30,r16
	0:
	st Z+,__zero_reg__
	dec r24
	brne 0b
	call TIMER0_Init
	call INTERRUPT_EnableGlobal
	ldi r24,lo8(1)
	call SPI_InitMaster
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	call ADC_Init
	ldi r20,lo8(2)
	ldi r22,lo8(2)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r22,lo8(3)
	ldi r24,0
	call EXTI_SetSense
	ldi r22,lo8(gs(EmergencyStopCallback))
	ldi r23,hi8(gs(EmergencyStopCallback))
	ldi r24,0
	call EXTI_SetCallback
	ldi r24,0
	call EXTI_Enable
	call LCD_Init
	call HST_Init
	call DRV_Init
	call BUZ_Init
	call FL_Init
	call CONS_Init
	call CarFSM_Init
	call DoorFSM_Init
	ldi r22,0
	ldi r23,0
	ldi r24,0
	call SEG_Show
	mov r8,__zero_reg__
	mov r9,__zero_reg__
	mov r5,__zero_reg__
	mov r11,__zero_reg__
	mov r4,__zero_reg__
	std Y+42,__zero_reg__
	movw r2,r4
	std Y+43,r16
	std Y+44,r17
	movw r24,r28
	adiw r24,36
	std Y+38,r24
	std Y+39,r25
	movw r30,r28
	adiw r30,34
	std Y+40,r30
	std Y+41,r31
	movw r6,r28
	ldi r31,10
	add r6,r31
	adc r7,__zero_reg__
.L3:
	lds r24,systemTicks10ms
	cpi r24,lo8(1)
	brne .L3
	sts systemTicks10ms,__zero_reg__
	ldi r24,-1
	sub r2,r24
	sbc r3,r24
	call POS_cm
	std Y+1,r24
	std Y+2,r25
	call LOAD_ReadKg
	std Y+6,r24
	std Y+7,r25
	movw r22,r28
	subi r22,-36
	sbci r23,-1
	ldi r24,lo8(2)
	call ADC_ReadChannel
	ldd r14,Y+38
	ldd r15,Y+39
	ldi r18,0
	ldi r19,0
	or r24,r25
	brne .L4
	ldd r18,Y+36
	ldd r19,Y+37
	ldi r26,lo8(32)
	ldi r27,lo8(78)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
.L4:
	std Y+8,r18
	std Y+9,r19
	ldd r24,Y+1
	ldd r25,Y+2
	call POS_nearestFloor
	std Y+3,r24
	movw r22,r28
	subi r22,-34
	sbci r23,-1
	ldi r24,lo8(3)
	call ADC_ReadChannel
	ldd r16,Y+40
	ldd r13,Y+41
	ldi r18,0
	or r24,r25
	brne .L5
	ldd r18,Y+34
	ldd r19,Y+35
	ldi r26,lo8(100)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
.L5:
	std Y+5,r18
	call DoorFSM_GetState
	std Y+16,r24
	call CarFSM_GetState
	std Y+15,r24
	std Y+13,__zero_reg__
	call BTN_Scan
	lsl r24
	mov r24,r25
	rol r24
	sbc r25,r25
	neg r25
	ldd r25,Y+18
	bst r24,0
	bld r25,2
	std Y+18,r25
	movw r20,r14
	ldi r22,lo8(2)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	mov r20,r16
	mov r21,r13
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	ldi r25,lo8(1)
	ldd r24,Y+34
	cpse r24,__zero_reg__
	ldi r25,0
.L6:
	ldd r24,Y+18
	bst r25,0
	bld r24,1
	std Y+18,r24
	ldd r24,Y+36
	cpi r24,lo8(1)
	brne .L7
	sts g_emergencyStopTrip,r24
	call HST_EmergencyStop
.L8:
	ldi r17,0
	rjmp .L24
.L7:
	sts g_emergencyStopTrip,__zero_reg__
	rjmp .L8
.L21:
	ldi r20,0
	ldi r21,0
	mov r22,r17
	movw r24,r6
	call DSP_AddCall
	subi r17,lo8(-(1))
.L24:
	mov r24,r17
	call BTN_Pressed
	cpi r24,lo8(0)
	brne .+2
	rjmp .L9
	cpi r17,lo8(14)
	brlo .+2
	rjmp .L9
	mov r30,r17
	ldi r31,0
	subi r30,lo8(-(gs(.L11)))
	sbci r31,hi8(-(gs(.L11)))
	jmp __tablejump2__
	.section	.jumptables.gcc.main,"a",@progbits
	.p2align	1
	.type	.L11, @object
.L11:
	.word gs(.L21)
	.word gs(.L21)
	.word gs(.L21)
	.word gs(.L21)
	.word gs(.L20)
	.word gs(.L19)
	.word gs(.L18)
	.word gs(.L17)
	.word gs(.L16)
	.word gs(.L15)
	.word gs(.L14)
	.word gs(.L13)
	.word gs(.L12)
	.word gs(.L10)
	.section	.text.startup.main
.L20:
	call DoorFSM_Open
	ldi r17,lo8(5)
	rjmp .L24
.L19:
	call DoorFSM_Close
	ldi r17,lo8(6)
	rjmp .L24
.L18:
	ldd r24,Y+18
	ori r24,lo8(1<<3)
	std Y+18,r24
	ldi r25,lo8(1)
	std Y+19,r25
	call HST_EmergencyStop
	call DRV_Stop
	ldi r17,lo8(7)
	rjmp .L24
.L17:
	ldd r24,Y+18
	ori r24,lo8(1<<2)
	std Y+18,r24
	ldi r17,lo8(8)
	rjmp .L24
.L16:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(9)
	rjmp .L24
.L15:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(1)
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(10)
	rjmp .L24
.L14:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(1)
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(11)
	rjmp .L24
.L13:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(2)
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(12)
	rjmp .L24
.L12:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(2)
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(13)
	rjmp .L24
.L10:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(3)
	movw r24,r6
	call DSP_AddCall
	ldi r17,lo8(14)
	rjmp .L24
.L9:
	subi r17,lo8(-(1))
	cpi r17,lo8(16)
	breq .+2
	rjmp .L24
	lds r25,g_emergencyStopTrip
	ldd r24,Y+18
	cpi r25,lo8(0)
	brne .+2
	rjmp .L25
	ori r24,lo8(1<<3)
	std Y+18,r24
	ldi r30,lo8(1)
	std Y+19,r30
.L26:
	mov r20,r16
	mov r21,r13
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	ldi r24,lo8(1)
	ldd r25,Y+34
	cpse r25,__zero_reg__
	ldi r24,0
.L27:
	ldd r22,Y+5
	call DoorFSM_UpdatePosition
	call DoorFSM_GetState
	std Y+16,r24
	cpse r24,__zero_reg__
	rjmp .L28
	call DRV_Stop
.L28:
	ldd r24,Y+18
	sbrs r24,1
	rjmp .L29
	std Y+10,__zero_reg__
	std Y+11,__zero_reg__
	std Y+12,__zero_reg__
	ldd r25,Y+3
	cpi r25,lo8(0)
	brne .+2
	rjmp .L30
	mov r25,r24
	andi r25,1<<3
	ldd r18,Y+16
	or r25,r18
	breq .+2
	rjmp .L30
	cp r11,__zero_reg__
	brne .+2
	rjmp .L31
.L33:
	clr r11
	inc r11
	ldi r25,lo8(2)
	mov r8,r25
	mov r9,__zero_reg__
.L32:
	ldd r24,Y+43
	ldd r25,Y+44
	call SAF_Evaluate
	ldd r24,Y+43
	ldd r25,Y+44
	call MOT_Step
	ldd r25,Y+18
	mov r18,r25
	andi r18,lo8(10)
	ldd r24,Y+19
	or r24,r18
	brne .+2
	rjmp .L47
	call BUZ_Alarm
.L52:
	mov r5,__zero_reg__
.L48:
	ldd r4,Y+18
	movw r24,r2
	ldi r22,lo8(25)
	ldi r23,0
	call __udivmodhi4
	or r24,r25
	brne .L53
	ldd r25,Y+42
	ldi r30,lo8(1)
	eor r25,r30
	std Y+42,r25
	ldd r22,Y+13
	ldi r23,0
	ldd r24,Y+3
	call SEG_Show
	ldd r12,Y+16
	mov r13,__zero_reg__
	ldd r14,Y+19
	mov r15,__zero_reg__
	ldd r16,Y+6
	ldd r17,Y+7
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r20,Y+13
	ldi r21,0
	ldd r10,Y+42
	ldd r22,Y+3
	ldi r24,lo8(g_lcdFrame)
	ldi r25,hi8(g_lcdFrame)
	call LCD_UpdateFrame
.L53:
	movw r24,r2
	ldi r22,lo8(-56)
	ldi r23,0
	call __udivmodhi4
	or r24,r25
	brne .L54
	call CONS_SendTelemetry
.L54:
	bst r4,5
	clr r4
	bld r4,0
	call CONS_Task
	rjmp .L3
.L25:
	andi r24,lo8(~(1<<3))
	std Y+18,r24
	ldd r24,Y+19
	cpi r24,lo8(1)
	breq .+2
	rjmp .L26
	std Y+19,__zero_reg__
	rjmp .L26
.L31:
	std Y+4,__zero_reg__
	andi r24,lo8(~(1<<5))
	std Y+18,r24
	ldd r22,Y+1
	ldd r23,Y+2
	ldi r24,0
	call MOT_GoTo
	rjmp .L33
.L30:
	call MOT_Stop
	std Y+13,__zero_reg__
	ldd r24,Y+3
	ldd r25,Y+16
	or r24,r25
	ldd r25,Y+18
	andi r25,lo8(8)
	or r24,r25
	brne .L85
	call DoorFSM_Open
.L85:
	mov r8,__zero_reg__
	mov r9,__zero_reg__
	rjmp .L32
.L29:
	andi r24,lo8(8)
	ldd r11,Y+16
	or r11,r24
	breq .L35
	std Y+13,__zero_reg__
	call MOT_Stop
	mov r11,__zero_reg__
	rjmp .L85
.L35:
	movw r20,r8
	ldd r22,Y+3
	movw r24,r6
	call DSP_ShouldStop
	mov r15,r6
	mov r14,r7
	or r24,r25
	brne .L36
	ldd r22,Y+3
	movw r24,r6
	call DSP_ClearFloor
	call MOT_Stop
	ldd r24,Y+3
	std Y+4,r24
	mov r8,__zero_reg__
	mov r9,__zero_reg__
.L36:
	movw r20,r8
	ldd r22,Y+3
	mov r24,r15
	mov r25,r14
	call DSP_NextDirection
	movw r8,r24
	sbiw r24,0
	breq .L37
	ldd r16,Y+3
	ldi r17,lo8(1)
	add r17,r16
	sbiw r24,1
	breq .L39
	ldi r24,2
	cp r8,r24
	cpc r9,__zero_reg__
	brne .L42
	mov r17,r16
	rjmp .L43
.L41:
	ldi r20,lo8(1)
	ldi r21,0
	mov r22,r17
	mov r24,r15
	mov r25,r14
	call DSP_ShouldStop
	or r24,r25
	breq .L40
	subi r17,lo8(-(1))
.L39:
	cpi r17,lo8(4)
	brlo .L41
.L42:
	mov r17,r16
.L40:
	ldd r24,Y+3
	cp r24,r17
	breq .L45
	ldd r24,Y+4
	cpse r24,r17
	rjmp .L46
	ldd r24,Y+18
	sbrs r24,5
	rjmp .L45
.L46:
	std Y+4,r17
	ldd r24,Y+18
	andi r24,lo8(~(1<<5))
	std Y+18,r24
	ldd r22,Y+1
	ldd r23,Y+2
	mov r24,r17
	call MOT_GoTo
.L45:
	std Y+13,r8
	rjmp .L32
.L44:
	subi r17,lo8(-(-1))
	ldi r20,lo8(2)
	ldi r21,0
	mov r22,r17
	mov r24,r15
	mov r25,r14
	call DSP_ShouldStop
	or r24,r25
	breq .L40
.L43:
	cpse r17,__zero_reg__
	rjmp .L44
	rjmp .L42
.L37:
	std Y+13,__zero_reg__
	call MOT_Stop
	rjmp .L45
.L47:
	sbrs r25,5
	rjmp .L49
	cpse r4,__zero_reg__
	rjmp .L49
	call BUZ_Chime
	ldi r24,lo8(10)
	mov r5,r24
	rjmp .L48
.L49:
	cp r5,__zero_reg__
	breq .L50
	dec r5
	breq .+2
	rjmp .L48
	call BUZ_Stop
	rjmp .L48
.L50:
	call BUZ_Stop
	rjmp .L52
	.size	main, .-main
	.section	.bss.g_emergencyStopTrip,"aw",@nobits
	.type	g_emergencyStopTrip, @object
	.size	g_emergencyStopTrip, 1
g_emergencyStopTrip:
	.zero	1
	.section	.bss.g_lcdFrame,"aw",@nobits
	.type	g_lcdFrame, @object
	.size	g_lcdFrame, 32
g_lcdFrame:
	.zero	32
	.ident	"GCC: (SUSE Linux) 15.3.0"
.global __do_clear_bss
