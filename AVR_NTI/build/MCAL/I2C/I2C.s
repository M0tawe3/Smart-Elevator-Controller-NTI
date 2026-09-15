	.file	"I2C.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.I2C_InitMaster,"ax",@progbits
.global	I2C_InitMaster
	.type	I2C_InitMaster, @function
I2C_InitMaster:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,r22
	movw r20,r24
	cpi r18,0
	cpc r19,r18
	cpc r20,r18
	cpc r21,r18
	breq .L3
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,16
	sbci r19,0
	sbci r20,0
	sbci r21,0
	lsr r21
	ror r20
	ror r19
	ror r18
	out 0,r18
	cbi 0x1,0
	cbi 0x1,1
	in r24,0x36
	ori r24,lo8(4)
	out 0x36,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	I2C_InitMaster, .-I2C_InitMaster
	.section	.text.I2C_SendStart,"ax",@progbits
.global	I2C_SendStart
	.type	I2C_SendStart, @function
I2C_SendStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L5:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L5
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(8)
	brne .L6
	ldi r18,0
.L6:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendStart, .-I2C_SendStart
	.section	.text.I2C_SendRepeatedStart,"ax",@progbits
.global	I2C_SendRepeatedStart
	.type	I2C_SendRepeatedStart, @function
I2C_SendRepeatedStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L10:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L10
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(16)
	brne .L11
	ldi r18,0
.L11:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendRepeatedStart, .-I2C_SendRepeatedStart
	.section	.text.I2C_SendStop,"ax",@progbits
.global	I2C_SendStop
	.type	I2C_SendStop, @function
I2C_SendStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-108)
	out 0x36,r24
/* epilogue start */
	ret
	.size	I2C_SendStop, .-I2C_SendStop
	.section	.text.I2C_SendSlaveAddressWithWrite,"ax",@progbits
.global	I2C_SendSlaveAddressWithWrite
	.type	I2C_SendSlaveAddressWithWrite, @function
I2C_SendSlaveAddressWithWrite:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lsl r24
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L16:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L16
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(24)
	brne .L17
	ldi r18,0
.L17:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendSlaveAddressWithWrite, .-I2C_SendSlaveAddressWithWrite
	.section	.text.I2C_SendSlaveAddressWithRead,"ax",@progbits
.global	I2C_SendSlaveAddressWithRead
	.type	I2C_SendSlaveAddressWithRead, @function
I2C_SendSlaveAddressWithRead:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lsl r24
	ori r24,lo8(1)
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L21:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L21
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(64)
	brne .L22
	ldi r18,0
.L22:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendSlaveAddressWithRead, .-I2C_SendSlaveAddressWithRead
	.section	.text.I2C_SendByte,"ax",@progbits
.global	I2C_SendByte
	.type	I2C_SendByte, @function
I2C_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L26:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L26
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(40)
	brne .L27
	ldi r18,0
.L27:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendByte, .-I2C_SendByte
	.section	.text.I2C_ReceiveByte,"ax",@progbits
.global	I2C_ReceiveByte
	.type	I2C_ReceiveByte, @function
I2C_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	brne .L31
.L35:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L31:
	ldi r24,lo8(-60)
	cpi r22,lo8(1)
	breq .L42
	brsh .L35
	ldi r24,lo8(-124)
.L42:
	out 0x36,r24
.L36:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L36
	in r25,0x1
	andi r25,lo8(-8)
	cpi r22,lo8(1)
	brne .L37
	cpi r25,lo8(80)
.L41:
	brne .L35
	in r24,0x3
	st Z,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L37:
	cpi r25,lo8(88)
	rjmp .L41
	.size	I2C_ReceiveByte, .-I2C_ReceiveByte
	.ident	"GCC: (SUSE Linux) 15.3.0"
