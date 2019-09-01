	.file	"micropixel_8led_.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	sendByte
	.type	sendByte, @function
sendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r18,lo8(7)
	ldi r19,0
	ldi r30,lo8(1)
	ldi r31,0
	mov r22,r24
	ldi r23,0
	ldi r24,lo8(1)
	ldi r26,0
.L3:
	movw r20,r30
	mov r0,r18
	rjmp 2f
	1:
	lsl r20
	rol r21
	2:
	dec r0
	brpl 1b
	and r20,r22
	and r21,r23
	mov r25,r24
	cp __zero_reg__,r20
	cpc __zero_reg__,r21
	brlt .L2
	mov r25,r26
.L2:
	mov r20,r25
	ori r20,lo8(16)
	out 0x18,r20
	ori r25,lo8(18)
	out 0x18,r25
	subi r18,1
	sbc r19,__zero_reg__
	brcc .L3
/* epilogue start */
	ret
	.size	sendByte, .-sendByte
.global	startFrame
	.type	startFrame, @function
startFrame:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rjmp sendByte
	.size	startFrame, .-startFrame
.global	endFrame
	.type	endFrame, @function
endFrame:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rjmp sendByte
	.size	endFrame, .-endFrame
.global	sendRGB
	.type	sendRGB, @function
sendRGB:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	mov r28,r24
	mov r29,r22
	mov r17,r20
	ldi r24,lo8(-1)
	rcall sendByte
	mov r24,r17
	rcall sendByte
	mov r24,r29
	rcall sendByte
	mov r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp sendByte
	.size	sendRGB, .-sendRGB
.global	sendRGB_
	.type	sendRGB_, @function
sendRGB_:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(-1)
	rcall sendByte
	ldd r24,Y+2
	rcall sendByte
	ldd r24,Y+1
	rcall sendByte
	ld r24,Y
/* epilogue start */
	pop r29
	pop r28
	rjmp sendByte
	.size	sendRGB_, .-sendRGB_
.global	sendRGBpack
	.type	sendRGBpack, @function
sendRGBpack:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	mov r17,r24
	movw r14,r22
	rcall startFrame
	tst r17
	breq .L10
	movw r28,r14
	subi r17,lo8(-(-1))
	mov r16,r17
	ldi r17,0
	subi r16,-1
	sbci r17,-1
	lsl r16
	rol r17
	add r16,r14
	adc r17,r15
.L11:
	ld r24,Y+
	ld r25,Y+
	rcall sendRGB_
	cp r28,r16
	cpc r29,r17
	brne .L11
.L10:
	rcall endFrame
	ldi r24,lo8(2999)
	ldi r25,hi8(2999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	sendRGBpack, .-sendRGBpack
.global	formColorPack
	.type	formColorPack, @function
formColorPack:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	tst r24
	breq .L13
	mov r30,r20
	mov r31,r21
	ldi r20,0
	ldi r21,0
	ldi r16,lo8(1)
	ldi r17,0
	ldi r19,0
.L16:
	lds r26,pal
	lds r27,pal+1
	ld __tmp_reg__,X+
	ld r27,X
	mov r26,__tmp_reg__
	std Z+1,r27
	st Z,r26
	cpi r20,lo8(8)
	brsh .L15
	movw r26,r16
	mov r0,r20
	rjmp 2f
	1:
	lsl r26
	rol r27
	2:
	dec r0
	brpl 1b
	movw r14,r26
	and r14,r18
	and r15,r19
	cp r26,r14
	cpc r27,r15
	brne .L15
	std Z+1,r23
	st Z,r22
.L15:
	subi r20,-1
	sbci r21,-1
	adiw r30,2
	cp r20,r24
	brlo .L16
.L13:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	formColorPack, .-formColorPack
.global	formColorPack_scheme
	.type	formColorPack_scheme, @function
formColorPack_scheme:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	tst r24
	breq .L18
	mov r30,r20
	mov r31,r21
	mov r26,r22
	mov r27,r23
	ldi r20,0
	ldi r21,0
	ldi r16,lo8(1)
	ldi r17,0
	ldi r19,0
.L21:
	lds r28,pal
	lds r29,pal+1
	ld r22,Y
	ldd r23,Y+1
	std Z+1,r23
	st Z,r22
	cpi r20,lo8(8)
	brsh .L20
	movw r22,r16
	mov r0,r20
	rjmp 2f
	1:
	lsl r22
	rol r23
	2:
	dec r0
	brpl 1b
	movw r14,r22
	and r14,r18
	and r15,r19
	cp r22,r14
	cpc r23,r15
	brne .L20
	ld r22,X+
	ld r23,X
	sbiw r26,1
	std Z+1,r23
	st Z,r22
.L20:
	subi r20,-1
	sbci r21,-1
	adiw r30,2
	adiw r26,2
	cp r20,r24
	brlo .L21
.L18:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	formColorPack_scheme, .-formColorPack_scheme
.global	process_button
	.type	process_button, @function
process_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,-11
	ldi r18,1
	cpc r25,r18
	brlo .L24
	or r22,r23
	breq .+2
	rjmp .L34
	lds r24,power
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brsh .L26
	sts power,r24
	rjmp .L27
.L26:
	sts power,__zero_reg__
.L27:
	lds r22,power
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_write_byte
	ldi r24,lo8(1)
	ret
.L24:
	cpi r24,101
	cpc r25,__zero_reg__
	brlo .L28
	or r22,r23
	breq .+2
	rjmp .L35
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(15)
	brsh .L29
	sts mode,r24
	rjmp .L30
.L29:
	ldi r24,lo8(1)
	sts mode,r24
.L30:
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
	ldi r24,lo8(1)
	ret
.L28:
	sbiw r24,11
	brlo .L36
	or r22,r23
	brne .L37
	lds r24,ss
	cpi r24,lo8(1)
	brne .L31
	sts ss,__zero_reg__
	sts s,r24
	rjmp .L32
.L31:
	lds r24,s
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brsh .L33
	sts s,r24
	rjmp .L32
.L33:
	ldi r24,lo8(1)
	sts s,r24
	sts ss,r24
.L32:
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
	lds r22,s
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_write_byte
	lds r22,ss
	ldi r24,lo8(e_s_serie)
	ldi r25,hi8(e_s_serie)
	rcall eeprom_write_byte
	ldi r24,lo8(1)
	ret
.L34:
	ldi r24,0
	ret
.L35:
	ldi r24,0
	ret
.L36:
	ldi r24,0
	ret
.L37:
	ldi r24,0
	ret
	.size	process_button, .-process_button
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x16
	sts button_state.1693,__zero_reg__
	sbrc r24,4
	rjmp .L39
	ldi r24,lo8(1)
	sts button_state.1693,r24
	lds r24,hold.1692
	lds r25,hold.1692+1
	adiw r24,1
	sts hold.1692+1,r25
	sts hold.1692,r24
	lds r22,last_button_state.1694
	cpi r22,lo8(1)
	brne .L44
.L42:
	ldi r23,0
	lds r24,hold.1692
	lds r25,hold.1692+1
	rcall process_button
	rjmp .L40
.L44:
	ldi r24,0
.L40:
	lds r25,button_state.1693
	cpse r25,__zero_reg__
	rjmp .L41
.L43:
	lds r18,last_button_state.1694
	cpse r18,__zero_reg__
	rjmp .L41
	sts hold.1692+1,__zero_reg__
	sts hold.1692,__zero_reg__
.L41:
	sts last_button_state.1694,r25
	ret
.L39:
	lds r22,last_button_state.1694
	tst r22
	breq .L42
	lds r25,button_state.1693
	ldi r24,0
	rjmp .L43
	.size	check_button, .-check_button
.global	const_light
	.type	const_light, @function
const_light:
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 10 */
.L__stack_usage = 10
	mov r28,r24
	lds r24,bbb
	cpi r24,lo8(1)
	brne .+2
	rjmp .L47
	tst r22
	brne .+2
	rjmp .L59
	mov r10,r20
	mov r11,r22
	mov r16,r28
	ldi r17,0
	lsl r16
	rol r17
	ldi r29,0
	mov __tmp_reg__,r31
	ldi r31,lo8(scheme+2)
	mov r14,r31
	ldi r31,hi8(scheme+2)
	mov r15,r31
	mov r31,__tmp_reg__
.L58:
	cpi r28,lo8(8)
	brsh .L48
	lds r30,pal
	lds r31,pal+1
	add r30,r16
	adc r31,r17
	ld r22,Z
	ldd r23,Z+1
	mov r18,r10
	ldi r20,lo8(pack)
	ldi r21,hi8(pack)
	ldi r24,lo8(8)
	rcall formColorPack
	rjmp .L49
.L48:
	cpi r28,lo8(9)
	breq .L51
	brsh .L52
	cpi r28,lo8(8)
	breq .L53
	rjmp .L50
.L52:
	cpi r28,lo8(10)
	brne .+2
	rjmp .L54
	cpi r28,lo8(11)
	brne .+2
	rjmp .L55
	rjmp .L50
.L53:
	lds r12,pal
	lds r13,pal+1
	movw r30,r12
	ldd r24,Z+14
	ldd r25,Z+15
	sts scheme+1,r25
	sts scheme,r24
	adiw r30,2
	movw r26,r14
	ldi r24,16
	add r12,r24
	adc r13,__zero_reg__
.L56:
	ld r24,Z+
	ld r25,Z+
	st X+,r24
	st X+,r25
	cp r30,r12
	cpc r31,r13
	brne .L56
	rjmp .L50
.L51:
	lds r26,pal
	lds r27,pal+1
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r25
	st Z,r24
	std Z+3,r25
	std Z+2,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+5,r25
	std Z+4,r24
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+7,r25
	std Z+6,r24
	std Z+9,r25
	std Z+8,r24
	adiw r26,14
	ld r24,X+
	ld r25,X
	sbiw r26,14+1
	std Z+11,r25
	std Z+10,r24
	std Z+13,r25
	std Z+12,r24
	std Z+15,r25
	std Z+14,r24
	rjmp .L50
.L54:
	lds r26,pal
	lds r27,pal+1
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r25
	st Z,r24
	std Z+3,r25
	std Z+2,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+5,r25
	std Z+4,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+7,r25
	std Z+6,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+9,r25
	std Z+8,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+11,r25
	std Z+10,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+13,r25
	std Z+12,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+15,r25
	std Z+14,r24
	rjmp .L50
.L55:
	lds r26,pal
	lds r27,pal+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+1,r25
	st Z,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+3,r25
	std Z+2,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+5,r25
	std Z+4,r24
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+7,r25
	std Z+6,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+9,r25
	std Z+8,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+11,r25
	std Z+10,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+13,r25
	std Z+12,r24
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+15,r25
	std Z+14,r24
.L50:
	mov r18,r10
	ldi r20,lo8(pack)
	ldi r21,hi8(pack)
	ldi r22,lo8(scheme)
	ldi r23,hi8(scheme)
	ldi r24,lo8(8)
	rcall formColorPack_scheme
.L49:
	rcall check_button
	cpi r24,lo8(1)
	brne .L57
	ldi r25,lo8(1)
	sts bbb,r25
	rjmp .L47
.L57:
	ldi r22,lo8(pack)
	ldi r23,hi8(pack)
	ldi r24,lo8(8)
	rcall sendRGBpack
	subi r29,lo8(-(1))
	cpse r29,r11
	rjmp .L58
	ldi r24,0
	rjmp .L47
.L59:
	ldi r24,0
.L47:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	ret
	.size	const_light, .-const_light
.global	mode_1
	.type	mode_1, @function
mode_1:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(-1)
	ldi r22,lo8(10)
	lds r24,s
	rjmp const_light
	.size	mode_1, .-mode_1
.global	mode_2
	.type	mode_2, @function
mode_2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(-1)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-1)
	ldi r22,lo8(6)
	ldi r24,0
	rjmp const_light
	.size	mode_2, .-mode_2
.global	mode_3
	.type	mode_3, @function
mode_3:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(15)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-16)
	ldi r22,lo8(6)
	lds r24,s
	rjmp const_light
	.size	mode_3, .-mode_3
.global	mode_4
	.type	mode_4, @function
mode_4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(4)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(8)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(16)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(32)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(64)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-1)
	ldi r22,lo8(2)
	lds r24,s
	rjmp const_light
	.size	mode_4, .-mode_4
.global	mode_5
	.type	mode_5, @function
mode_5:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rcall const_light
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(36)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(102)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-103)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(102)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(36)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_5, .-mode_5
.global	mode_6
	.type	mode_6, @function
mode_6:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(60)
	ldi r22,lo8(12)
	lds r24,s
	rcall const_light
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-25)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-61)
	ldi r22,lo8(9)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-25)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_6, .-mode_6
.global	mode_7
	.type	mode_7, @function
mode_7:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-122)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(72)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(126)
	ldi r22,lo8(9)
	lds r24,s
	rcall const_light
	ldi r20,lo8(20)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(52)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(66)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(33)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(34)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(82)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(76)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-124)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(72)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-116)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-126)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_7, .-mode_7
.global	mode_8
	.type	mode_8, @function
mode_8:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(124)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(30)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(63)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-1)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(63)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(30)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(124)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_8, .-mode_8
.global	mode_9
	.type	mode_9, @function
mode_9:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-32)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-28)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(24)
	ldi r22,lo8(6)
	lds r24,s
	rcall const_light
	ldi r20,lo8(39)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(6)
	lds r24,s
	rjmp const_light
	.size	mode_9, .-mode_9
.global	mode_10
	.type	mode_10, @function
mode_10:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-128)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-115)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-112)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-3)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_10, .-mode_10
.global	heart
	.type	heart, @function
heart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(112)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-8)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-4)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-4)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(-8)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(112)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	heart, .-heart
.global	binary
	.type	binary, @function
binary:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r20,i.1689
	ldi r24,lo8(1)
	add r24,r20
	sts i.1689,r24
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	binary, .-binary
.global	svetobobr
	.type	svetobobr, @function
svetobobr:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(48)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(6)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(112)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(3)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(112)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(73)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(64)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(64)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(65)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(54)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(65)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(54)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(72)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(68)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(51)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(5)
	lds r24,s
	rjmp const_light
	.size	svetobobr, .-svetobobr
.global	demo
	.type	demo, @function
demo:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,mmm.1723
	rcall make_serie
	lds r24,nnn.1724
	subi r24,lo8(-(1))
	sts nnn.1724,r24
	cpi r24,lo8(11)
	brlo .L76
	lds r24,s
	subi r24,lo8(-(1))
	sts s,r24
	ldi r24,lo8(1)
	sts nnn.1724,r24
.L76:
	lds r24,s
	cpi r24,lo8(12)
	brlo .L77
	lds r24,mmm.1723
	subi r24,lo8(-(1))
	sts mmm.1723,r24
	ldi r24,lo8(1)
	sts s,r24
.L77:
	lds r24,mmm.1723
	cpi r24,lo8(14)
	brlo .L75
	sts mmm.1723,__zero_reg__
.L75:
	ret
	.size	demo, .-demo
.global	make_serie
	.type	make_serie, @function
make_serie:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	cpi r24,lo8(2)
	breq .L81
	cpi r24,lo8(3)
	breq .L82
	cpi r24,lo8(1)
	brne .L102
	rcall mode_1
	rjmp .L85
.L81:
	rcall mode_2
	rjmp .L85
.L82:
	rcall mode_3
	rjmp .L85
.L102:
	cpi r24,lo8(5)
	breq .L86
	cpi r24,lo8(6)
	breq .L87
	cpi r24,lo8(4)
	brne .L85
	rcall mode_4
	rjmp .L90
.L86:
	rcall mode_5
	rjmp .L90
.L87:
	rcall mode_6
	rjmp .L90
.L85:
	cpi r28,lo8(8)
	breq .L91
	brsh .L92
	cpi r28,lo8(7)
	breq .L93
	rjmp .L90
.L92:
	cpi r28,lo8(9)
	breq .L94
	cpi r28,lo8(10)
	breq .L95
	rjmp .L90
.L93:
/* epilogue start */
	pop r28
	rjmp mode_7
.L91:
/* epilogue start */
	pop r28
	rjmp mode_8
.L94:
/* epilogue start */
	pop r28
	rjmp mode_9
.L95:
/* epilogue start */
	pop r28
	rjmp mode_10
.L90:
	cpi r28,lo8(12)
	breq .L97
	brsh .L98
	cpi r28,lo8(11)
	breq .L99
	rjmp .L79
.L98:
	cpi r28,lo8(13)
	breq .L100
	cpi r28,lo8(14)
	breq .L101
	rjmp .L79
.L100:
/* epilogue start */
	pop r28
	rjmp svetobobr
.L99:
/* epilogue start */
	pop r28
	rjmp heart
.L97:
/* epilogue start */
	pop r28
	rjmp binary
.L101:
/* epilogue start */
	pop r28
	rjmp demo
.L79:
/* epilogue start */
	pop r28
	ret
	.size	make_serie, .-make_serie
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	mov r17,r24
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	mov r29,r24
	sts s,r24
	ldi r24,lo8(e_s_serie)
	ldi r25,hi8(e_s_serie)
	rcall eeprom_read_byte
	mov r28,r24
	sts ss,r24
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_read_byte
	mov r25,r24
	sts power,r24
	cpi r17,lo8(15)
	brlo .L104
	ldi r24,lo8(1)
	sts mode,r24
.L104:
	cpi r29,lo8(12)
	brlo .L105
	ldi r24,lo8(1)
	sts s,r24
.L105:
	cpi r28,lo8(2)
	brlo .L106
	sts ss,__zero_reg__
.L106:
	cpi r25,lo8(2)
	brlo .L107
	ldi r24,lo8(1)
	sts power,r24
.L107:
	ldi r24,lo8(-1)
	out 0x17,r24
	out 0x18,__zero_reg__
	clr r15
	inc r15
	ldi r28,lo8(h_palette)
	ldi r29,hi8(h_palette)
	ldi r16,lo8(palette)
	ldi r17,hi8(palette)
.L108:
	sts bbb,__zero_reg__
	lds r24,mode
	rcall make_serie
	lds r24,ss
	cpi r24,lo8(1)
	brne .L109
	lds r24,s
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brsh .L110
	sts s,r24
	rjmp .L109
.L110:
	sts s,r15
.L109:
	lds r24,power
	cpi r24,lo8(1)
	brne .L111
	sts pal+1,r17
	sts pal,r16
	rjmp .L108
.L111:
	sts pal+1,r29
	sts pal,r28
	rjmp .L108
	.size	main, .-main
	.data
	.type	nnn.1724, @object
	.size	nnn.1724, 1
nnn.1724:
	.byte	1
	.type	mmm.1723, @object
	.size	mmm.1723, 1
mmm.1723:
	.byte	1
	.local	last_button_state.1694
	.comm	last_button_state.1694,1,1
	.local	hold.1692
	.comm	hold.1692,2,1
	.local	button_state.1693
	.comm	button_state.1693,1,1
	.local	i.1689
	.comm	i.1689,1,1
.global	bbb
	.section .bss
	.type	bbb, @object
	.size	bbb, 1
bbb:
	.zero	1
	.comm	pal,2,1
	.comm	scheme,20,1
	.comm	pack,20,1
.global	e_power
	.section	.eeprom,"aw",@progbits
	.type	e_power, @object
	.size	e_power, 1
e_power:
	.zero	1
.global	e_s_serie
	.type	e_s_serie, @object
	.size	e_s_serie, 1
e_s_serie:
	.zero	1
.global	e_serie
	.type	e_serie, @object
	.size	e_serie, 1
e_serie:
	.zero	1
.global	e_mode
	.type	e_mode, @object
	.size	e_mode, 1
e_mode:
	.zero	1
	.comm	power,1,1
	.comm	ss,1,1
	.comm	s,1,1
	.comm	mode,1,1
.global	h_palette
	.data
	.type	h_palette, @object
	.size	h_palette, 16
h_palette:
	.word	OOO
	.word	ROOH
	.word	RGOH
	.word	OGOH
	.word	OGBH
	.word	OOBH
	.word	ROBH
	.word	WWWH
.global	WWWH
	.type	WWWH, @object
	.size	WWWH, 3
WWWH:
	.byte	60
	.byte	60
	.byte	60
.global	ROBH
	.type	ROBH, @object
	.size	ROBH, 3
ROBH:
	.byte	60
	.byte	0
	.byte	60
.global	OGBH
	.type	OGBH, @object
	.size	OGBH, 3
OGBH:
	.byte	0
	.byte	60
	.byte	60
.global	RGOH
	.type	RGOH, @object
	.size	RGOH, 3
RGOH:
	.byte	60
	.byte	60
	.byte	0
.global	OOBH
	.type	OOBH, @object
	.size	OOBH, 3
OOBH:
	.byte	0
	.byte	0
	.byte	-1
.global	OGOH
	.type	OGOH, @object
	.size	OGOH, 3
OGOH:
	.byte	0
	.byte	60
	.byte	0
.global	ROOH
	.type	ROOH, @object
	.size	ROOH, 3
ROOH:
	.byte	60
	.byte	0
	.byte	0
.global	palette
	.type	palette, @object
	.size	palette, 16
palette:
	.word	OOO
	.word	ROO
	.word	RGO
	.word	OGO
	.word	OGB
	.word	OOB
	.word	ROB
	.word	WWW
.global	COM
	.section .bss
	.type	COM, @object
	.size	COM, 3
COM:
	.zero	3
.global	WWW
	.data
	.type	WWW, @object
	.size	WWW, 3
WWW:
	.byte	-1
	.byte	-1
	.byte	-1
.global	ROB
	.type	ROB, @object
	.size	ROB, 3
ROB:
	.byte	-1
	.byte	0
	.byte	-1
.global	OGB
	.type	OGB, @object
	.size	OGB, 3
OGB:
	.byte	0
	.byte	-1
	.byte	-1
.global	RGO
	.type	RGO, @object
	.size	RGO, 3
RGO:
	.byte	-1
	.byte	-1
	.byte	0
.global	OOB
	.type	OOB, @object
	.size	OOB, 3
OOB:
	.byte	0
	.byte	0
	.byte	-1
.global	OGO
	.type	OGO, @object
	.size	OGO, 3
OGO:
	.byte	0
	.byte	-1
	.byte	0
.global	ROO
	.type	ROO, @object
	.size	ROO, 3
ROO:
	.byte	-1
	.byte	0
	.byte	0
.global	OOO
	.section .bss
	.type	OOO, @object
	.size	OOO, 3
OOO:
	.zero	3
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
.global __do_clear_bss
