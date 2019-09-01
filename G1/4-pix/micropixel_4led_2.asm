	.file	"micropixel_4led_2.c"
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
	ldi r24,lo8(5999)
	ldi r25,hi8(5999)
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
	cpi r24,lo8(11)
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
	cpi r24,lo8(16)
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
	sts button_state.1685,__zero_reg__
	sbrc r24,4
	rjmp .L39
	ldi r24,lo8(1)
	sts button_state.1685,r24
	lds r24,hold.1684
	lds r25,hold.1684+1
	adiw r24,1
	sts hold.1684+1,r25
	sts hold.1684,r24
	lds r22,last_button_state.1686
	cpi r22,lo8(1)
	brne .L44
.L42:
	ldi r23,0
	lds r24,hold.1684
	lds r25,hold.1684+1
	rcall process_button
	rjmp .L40
.L44:
	ldi r24,0
.L40:
	lds r25,button_state.1685
	cpse r25,__zero_reg__
	rjmp .L41
.L43:
	lds r18,last_button_state.1686
	cpse r18,__zero_reg__
	rjmp .L41
	sts hold.1684+1,__zero_reg__
	sts hold.1684,__zero_reg__
.L41:
	sts last_button_state.1686,r25
	ret
.L39:
	lds r22,last_button_state.1686
	tst r22
	breq .L42
	lds r25,button_state.1685
	ldi r24,0
	rjmp .L43
	.size	check_button, .-check_button
.global	const_light
	.type	const_light, @function
const_light:
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
	tst r22
	brne .+2
	rjmp .L64
	mov r16,r20
	mov r17,r22
	mov r28,r24
	mov r14,r24
	mov r15,__zero_reg__
	lsl r14
	rol r15
	ldi r29,0
.L63:
	cpi r28,lo8(8)
	brsh .L48
	lds r30,pal
	lds r31,pal+1
	add r30,r14
	adc r31,r15
	ld r22,Z
	ldd r23,Z+1
	mov r18,r16
	ldi r20,lo8(pack)
	ldi r21,hi8(pack)
	ldi r24,lo8(4)
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
	breq .L54
	cpi r28,lo8(11)
	brne .+2
	rjmp .L55
	rjmp .L50
.L53:
	lds r26,pal
	lds r27,pal+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	adiw r26,4
	ld r24,X+
	ld r25,X
	sbiw r26,4+1
	std Z+1,r25
	st Z,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+3,r25
	std Z+2,r24
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+5,r25
	std Z+4,r24
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
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
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	std Z+5,r25
	std Z+4,r24
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L54:
	lds r26,pal
	lds r27,pal+1
	adiw r26,6
	ld r18,X+
	ld r19,X
	sbiw r26,6+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r19
	st Z,r18
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+3,r25
	std Z+2,r24
	std Z+5,r19
	std Z+4,r18
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L55:
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
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	std Z+5,r25
	std Z+4,r24
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L50:
	cpi r28,lo8(13)
	breq .L58
	brsh .L59
	cpi r28,lo8(12)
	breq .L60
	rjmp .L57
.L59:
	cpi r28,lo8(14)
	breq .L61
	cpi r28,lo8(15)
	brne .+2
	rjmp .L62
	rjmp .L57
.L60:
	lds r26,pal
	lds r27,pal+1
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r25
	st Z,r24
	adiw r26,2
	ld r18,X+
	ld r19,X
	sbiw r26,2+1
	std Z+3,r19
	std Z+2,r18
	std Z+5,r25
	std Z+4,r24
	adiw r26,2
	ld r24,X+
	ld r25,X
	sbiw r26,2+1
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L58:
	lds r26,pal
	lds r27,pal+1
	adiw r26,10
	ld r24,X+
	ld r25,X
	sbiw r26,10+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r25
	st Z,r24
	adiw r26,2
	ld r18,X+
	ld r19,X
	sbiw r26,2+1
	std Z+3,r19
	std Z+2,r18
	std Z+5,r25
	std Z+4,r24
	adiw r26,12
	ld r24,X+
	ld r25,X
	sbiw r26,12+1
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L61:
	lds r26,pal
	lds r27,pal+1
	adiw r26,6
	ld r24,X+
	ld r25,X
	sbiw r26,6+1
	ldi r30,lo8(scheme)
	ldi r31,hi8(scheme)
	std Z+1,r25
	st Z,r24
	adiw r26,4
	ld r18,X+
	ld r19,X
	sbiw r26,4+1
	std Z+3,r19
	std Z+2,r18
	std Z+5,r25
	std Z+4,r24
	adiw r26,4
	ld r24,X+
	ld r25,X
	sbiw r26,4+1
	std Z+7,r25
	std Z+6,r24
	rjmp .L57
.L62:
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
	adiw r26,14
	ld r24,X+
	ld r25,X
	sbiw r26,14+1
	std Z+3,r25
	std Z+2,r24
	adiw r26,2
	ld r18,X+
	ld r19,X
	sbiw r26,2+1
	std Z+5,r19
	std Z+4,r18
	std Z+7,r25
	std Z+6,r24
.L57:
	mov r18,r16
	ldi r20,lo8(pack)
	ldi r21,hi8(pack)
	ldi r22,lo8(scheme)
	ldi r23,hi8(scheme)
	ldi r24,lo8(4)
	rcall formColorPack_scheme
.L49:
	rcall check_button
	cpi r24,lo8(1)
	breq .L47
	ldi r22,lo8(pack)
	ldi r23,hi8(pack)
	ldi r24,lo8(4)
	rcall sendRGBpack
	subi r29,lo8(-(1))
	cpse r29,r17
	rjmp .L63
	ldi r24,0
	rjmp .L47
.L64:
	ldi r24,0
.L47:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	const_light, .-const_light
.global	mode_1
	.type	mode_1, @function
mode_1:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(15)
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
	ldi r20,lo8(15)
	ldi r22,lo8(10)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(10)
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
	rjmp const_light
	.size	mode_3, .-mode_3
.global	mode_4
	.type	mode_4, @function
mode_4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(15)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
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
	rjmp const_light
	.size	mode_4, .-mode_4
.global	mode_5
	.type	mode_5, @function
mode_5:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(12)
	ldi r22,lo8(7)
	lds r24,s
	rcall const_light
	ldi r20,lo8(3)
	ldi r22,lo8(7)
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
	ldi r20,lo8(9)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(6)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(4)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(6)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(9)
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	mode_6, .-mode_6
.global	mode_7
	.type	mode_7, @function
mode_7:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,lo8(20)
.L73:
	ldi r20,lo8(5)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(10)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	subi r28,lo8(-(-1))
	brne .L73
	ldi r28,lo8(2)
.L74:
	ldi r20,0
	ldi r22,lo8(30)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(15)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(30)
	lds r24,s
	rcall const_light
	subi r28,lo8(-(-1))
	brne .L74
/* epilogue start */
	pop r28
	ret
	.size	mode_7, .-mode_7
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
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(14)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(14)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(14)
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,s
	rjmp const_light
	.size	heart, .-heart
.global	binary
	.type	binary, @function
binary:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,lo8(1)
.L80:
	mov r20,r28
	ldi r22,lo8(3)
	lds r24,s
	rcall const_light
	cpse r24,__zero_reg__
	rjmp .L78
	subi r28,lo8(-(1))
	cpi r28,lo8(10)
	brne .L80
.L78:
/* epilogue start */
	pop r28
	ret
	.size	binary, .-binary
.global	svetobobr
	.type	svetobobr, @function
svetobobr:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(10)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(5)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(8)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(7)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(11)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(4)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(4)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(6)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(9)
	ldi r22,lo8(1)
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
	ldi r20,lo8(15)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(6)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(9)
	ldi r22,lo8(1)
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
	ldi r20,lo8(15)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,s
	rcall const_light
	ldi r20,lo8(15)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	lds r24,s
	rcall const_light
	ldi r20,0
	ldi r22,lo8(4)
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
	lds r24,mmm.1716
	cpi r24,lo8(2)
	breq .L85
	cpi r24,lo8(3)
	breq .L86
	cpi r24,lo8(1)
	brne .L84
	rcall mode_1
	rjmp .L84
.L85:
	rcall mode_2
	rjmp .L84
.L86:
	rcall mode_3
.L84:
	lds r24,mmm.1716
	cpi r24,lo8(5)
	breq .L89
	cpi r24,lo8(6)
	breq .L90
	cpi r24,lo8(4)
	brne .L88
	rcall mode_4
	rjmp .L88
.L89:
	rcall mode_5
	rjmp .L88
.L90:
	rcall mode_6
.L88:
	lds r24,nnn.1717
	subi r24,lo8(-(1))
	sts nnn.1717,r24
	cpi r24,lo8(11)
	brlo .L92
	lds r24,s
	subi r24,lo8(-(1))
	sts s,r24
	ldi r24,lo8(1)
	sts nnn.1717,r24
.L92:
	lds r24,s
	cpi r24,lo8(16)
	brlo .L93
	lds r24,mmm.1716
	subi r24,lo8(-(1))
	sts mmm.1716,r24
	ldi r24,lo8(1)
	sts s,r24
.L93:
	lds r24,mmm.1716
	cpi r24,lo8(7)
	brlo .L83
	sts mmm.1716,__zero_reg__
.L83:
	ret
	.size	demo, .-demo
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
	cpi r17,lo8(11)
	brlo .L96
	ldi r24,lo8(1)
	sts mode,r24
.L96:
	cpi r29,lo8(16)
	brlo .L97
	ldi r24,lo8(1)
	sts s,r24
.L97:
	cpi r28,lo8(2)
	brlo .L98
	sts ss,__zero_reg__
.L98:
	cpi r25,lo8(2)
	brlo .L99
	ldi r24,lo8(1)
	sts power,r24
.L99:
	ldi r24,lo8(-1)
	out 0x17,r24
	out 0x18,__zero_reg__
	clr r15
	inc r15
	ldi r28,lo8(h_palette)
	ldi r29,hi8(h_palette)
	ldi r16,lo8(palette)
	ldi r17,hi8(palette)
.L100:
	lds r24,mode
	cpi r24,lo8(2)
	breq .L102
	cpi r24,lo8(3)
	breq .L103
	cpi r24,lo8(1)
	brne .L101
	rcall mode_1
	rjmp .L101
.L102:
	rcall mode_2
	rjmp .L101
.L103:
	rcall mode_3
.L101:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L106
	cpi r24,lo8(6)
	breq .L107
	cpi r24,lo8(4)
	brne .L105
	rcall mode_4
	rjmp .L105
.L106:
	rcall mode_5
	rjmp .L105
.L107:
	rcall mode_6
.L105:
	lds r24,mode
	cpi r24,lo8(8)
	breq .L110
	brsh .L111
	cpi r24,lo8(7)
	breq .L112
	rjmp .L109
.L111:
	cpi r24,lo8(9)
	breq .L113
	cpi r24,lo8(10)
	breq .L114
	rjmp .L109
.L113:
	rcall svetobobr
	rjmp .L109
.L112:
	rcall heart
	rjmp .L109
.L110:
	rcall binary
	rjmp .L109
.L114:
	rcall demo
.L109:
	lds r24,ss
	cpi r24,lo8(1)
	brne .L115
	lds r24,s
	subi r24,lo8(-(1))
	cpi r24,lo8(16)
	brsh .L116
	sts s,r24
	rjmp .L115
.L116:
	sts s,r15
.L115:
	lds r24,power
	cpi r24,lo8(1)
	brne .L117
	sts pal+1,r17
	sts pal,r16
	rjmp .L100
.L117:
	sts pal+1,r29
	sts pal,r28
	rjmp .L100
	.size	main, .-main
	.data
	.type	nnn.1717, @object
	.size	nnn.1717, 1
nnn.1717:
	.byte	1
	.type	mmm.1716, @object
	.size	mmm.1716, 1
mmm.1716:
	.byte	1
	.local	last_button_state.1686
	.comm	last_button_state.1686,1,1
	.local	hold.1684
	.comm	hold.1684,2,1
	.local	button_state.1685
	.comm	button_state.1685,1,1
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
