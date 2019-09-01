	.file	"poi-8LED-v2-1.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.section	.text.init_io,"ax",@progbits
.global	init_io
	.type	init_io, @function
init_io:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(15)
	out 0x17,r24
	ldi r24,lo8(28)
	out 0x18,r24
	ret
	.size	init_io, .-init_io
	.section	.text.sendByte,"ax",@progbits
.global	sendByte
	.type	sendByte, @function
sendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r18,lo8(7)
	ldi r19,0
	ldi r22,lo8(1)
	ldi r23,0
	mov r20,r24
	ldi r21,0
.L4:
	movw r24,r22
	mov r0,r18
	rjmp 2f
	1:
	lsl r24
	rol r25
	2:
	dec r0
	brpl 1b
	and r24,r20
	and r25,r21
	or r24,r25
	breq .L5
	ldi r25,lo8(2)
	rjmp .L3
.L5:
	ldi r25,0
.L3:
	mov r24,r25
	ori r24,lo8(28)
	out 0x18,r24
	ori r25,lo8(29)
	out 0x18,r25
	subi r18,1
	sbc r19,__zero_reg__
	brcc .L4
/* epilogue start */
	ret
	.size	sendByte, .-sendByte
	.section	.text.check_all,"ax",@progbits
.global	check_all
	.type	check_all, @function
check_all:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,mode
	cpi r24,lo8(23)
	brlo .L9
	ldi r24,lo8(1)
	sts mode,r24
.L9:
	lds r24,serie
	cpi r24,lo8(18)
	brlo .L10
	ldi r24,lo8(1)
	sts serie,r24
.L10:
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r24,lo8(1)
	ldi r25,lo8(15)
	add r25,r30
.L13:
	ld r18,Z
	cpi r18,lo8(23)
	brlo .L11
	st Z,r24
.L11:
	ld r18,X
	cpi r18,lo8(18)
	brlo .L12
	st X,r24
.L12:
	adiw r30,1
	adiw r26,1
	cpse r25,r30
	rjmp .L13
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L14
	sts counter,__zero_reg__
.L14:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L15
	sts pointer,r24
.L15:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L8
	sts fav_on,__zero_reg__
.L8:
	ret
	.size	check_all, .-check_all
	.section	.text.read_data,"ax",@progbits
.global	read_data
	.type	read_data, @function
read_data:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_read_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_read_block
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_read_byte
	sts pointer,r24
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_read_byte
	sts counter,r24
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall eeprom_read_byte
	sts fav_on,r24
	ldi r24,lo8(e_econom)
	ldi r25,hi8(e_econom)
	rcall eeprom_read_byte
	sts econom,r24
	rjmp check_all
	.size	read_data, .-read_data
	.section	.text.store_data,"ax",@progbits
.global	store_data
	.type	store_data, @function
store_data:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_write_byte
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_write_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_write_block
	lds r22,pointer
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_write_byte
	lds r22,counter
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_write_byte
	lds r22,fav_on
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall eeprom_write_byte
	lds r22,econom
	ldi r24,lo8(e_econom)
	ldi r25,hi8(e_econom)
	rjmp eeprom_write_byte
	.size	store_data, .-store_data
	.section	.text.__vector_2,"ax",@progbits
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
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
/* #APP */
 ;  32 "../button-api.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	rcall check_all
	rcall init_io
	in r25,0x16
	ldi r24,lo8(21)
.L21:
	sbrc r25,4
	rjmp .L25
	in r25,0x16
	ldi r30,lo8(3999)
	ldi r31,hi8(3999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	subi r24,lo8(-(-1))
	brne .L21
	ldi r24,lo8(1)
	sts power,r24
	ldi r24,lo8(20)
	sts stat,r24
	rjmp .L20
.L25:
	ldi r24,lo8(9999)
	ldi r25,hi8(9999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	sts power,__zero_reg__
.L20:
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
	.size	__vector_2, .-__vector_2
	.section	.text.process_button,"ax",@progbits
.global	process_button
	.type	process_button, @function
process_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,81
	ldi r18,70
	cpc r25,r18
	brlo .L27
	ldi r24,lo8(15)
	sts stat,r24
	or r22,r23
	breq .L28
.L31:
	ldi r24,0
	ret
.L28:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L32
.L27:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L30
	ldi r24,lo8(10)
	sts stat,r24
	or r22,r23
	brne .L31
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L32
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L49
.L32:
	sts fav_on,__zero_reg__
	rjmp .L49
.L30:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L34
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L31
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L31
	ldi r25,lo8(11)
	sts stat,r25
	or r22,r23
	brne .L31
	subi r24,lo8(-(1))
	sts counter,r24
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	lds r18,mode
	st Z,r18
	movw r30,r24
	subi r30,lo8(-(series))
	sbci r31,hi8(-(series))
	lds r18,serie
	st Z,r18
.L49:
	rcall check_all
	rjmp .L38
.L34:
	cpi r24,-35
	ldi r18,5
	cpc r25,r18
	brlo .L35
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L31
	sts power,__zero_reg__
	rjmp .L38
.L35:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L36
	ldi r24,lo8(21)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L31
	lds r24,econom
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L37
	sts econom,r24
	rjmp .L38
.L37:
	sts econom,__zero_reg__
.L38:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L48
.L36:
	cpi r24,101
	cpc r25,__zero_reg__
	brlo .L39
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L31
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L31
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(18)
	brlo .L46
	ldi r24,lo8(1)
.L46:
	sts serie,r24
	rjmp .L38
.L39:
	sbiw r24,15
	brsh .+2
	rjmp .L31
	or r22,r23
	breq .+2
	rjmp .L31
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L42
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(23)
	brlo .L47
	ldi r24,lo8(1)
.L47:
	sts mode,r24
	rjmp .L44
.L42:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L44
	ldi r24,lo8(1)
	sts pointer,r24
.L44:
	rcall check_all
	rcall store_data
.L48:
	ldi r24,lo8(1)
	ret
	.size	process_button, .-process_button
	.section	.text.check_button,"ax",@progbits
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbis 0x16,4
	rjmp .L51
	sts button_state.1663,__zero_reg__
	rjmp .L52
.L51:
	ldi r24,lo8(1)
	sts button_state.1663,r24
.L52:
	lds r22,button_state.1663
	cpi r22,lo8(1)
	brne .L53
	lds r24,hold.1662
	lds r25,hold.1662+1
	adiw r24,1
	sts hold.1662+1,r25
	sts hold.1662,r24
.L53:
	lds r24,last_button_state.1664
	cpse r24,r22
	rjmp .L56
	ldi r23,0
	lds r24,hold.1662
	lds r25,hold.1662+1
	rcall process_button
	rjmp .L54
.L56:
	ldi r24,0
.L54:
	lds r25,button_state.1663
	cpse r25,__zero_reg__
	rjmp .L55
	lds r18,last_button_state.1664
	cpse r18,__zero_reg__
	rjmp .L55
	sts hold.1662+1,__zero_reg__
	sts hold.1662,__zero_reg__
.L55:
	sts last_button_state.1664,r25
	ret
	.size	check_button, .-check_button
	.section	.text.process_signal,"ax",@progbits
.global	process_signal
	.type	process_signal, @function
process_signal:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	mov r24,r28
	ldi r25,0
	movw r30,r24
	sbiw r30,10
	cpi r30,12
	cpc r31,__zero_reg__
	brlo .+2
	rjmp .L58
	subi r30,lo8(-(gs(.L60)))
	sbci r31,hi8(-(gs(.L60)))
	ijmp
	.section	.progmem.gcc_sw_table.process_signal,"ax",@progbits
	.p2align	1
.L60:
	rjmp .L59
	rjmp .L61
	rjmp .L58
	rjmp .L62
	rjmp .L63
	rjmp .L64
	rjmp .L58
	rjmp .L58
	rjmp .L58
	rjmp .L58
	rjmp .L65
	rjmp .L66
	.section	.text.process_signal
.L62:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rjmp .L68
.L63:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(7)
	rcall sendByte
	ldi r24,lo8(7)
.L67:
	rcall sendByte
	rjmp .L58
.L66:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
.L69:
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
.L68:
	rcall sendByte
	ldi r24,0
	rjmp .L67
.L61:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rjmp .L69
.L64:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rcall sendByte
	ldi r24,lo8(4)
	rjmp .L67
.L59:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rjmp .L67
.L65:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(10)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r18,lo8(319999)
	ldi r24,hi8(319999)
	ldi r25,hlo8(319999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	sts stat,__zero_reg__
.L58:
/* epilogue start */
	pop r28
	rjmp check_button
	.size	process_signal, .-process_signal
	.section	.text.formColorPack,"ax",@progbits
.global	formColorPack
	.type	formColorPack, @function
formColorPack:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r30,r20
	ldi r20,0
	ldi r21,0
	ldi r28,lo8(1)
	ldi r29,0
	ldi r19,0
.L71:
	mov r25,r20
	cp r20,r24
	brsh .L74
	lds r26,pal
	lds r27,pal+1
	ld __tmp_reg__,X+
	ld r27,X
	mov r26,__tmp_reg__
	std Z+1,r27
	st Z,r26
	cpi r25,lo8(8)
	brsh .L72
	movw r26,r28
	mov r0,r20
	rjmp 2f
	1:
	lsl r26
	rol r27
	2:
	dec r0
	brpl 1b
	movw r16,r26
	and r16,r18
	and r17,r19
	cp r16,r26
	cpc r17,r27
	brne .L72
	std Z+1,r23
	st Z,r22
.L72:
	subi r20,-1
	sbci r21,-1
	adiw r30,2
	rjmp .L71
.L74:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	formColorPack, .-formColorPack
	.section	.text.formColorPack_scheme,"ax",@progbits
.global	formColorPack_scheme
	.type	formColorPack_scheme, @function
formColorPack_scheme:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r30,r20
	ldi r20,0
	ldi r21,0
	ldi r28,lo8(1)
	ldi r29,0
	ldi r19,0
.L76:
	mov r25,r20
	cp r20,r24
	brsh .L79
	lds r26,pal
	lds r27,pal+1
	ld __tmp_reg__,X+
	ld r27,X
	mov r26,__tmp_reg__
	std Z+1,r27
	st Z,r26
	cpi r25,lo8(8)
	brsh .L77
	movw r26,r28
	mov r0,r20
	rjmp 2f
	1:
	lsl r26
	rol r27
	2:
	dec r0
	brpl 1b
	movw r16,r26
	and r16,r18
	and r17,r19
	cp r16,r26
	cpc r17,r27
	brne .L77
	movw r26,r20
	lsl r26
	rol r27
	add r26,r22
	adc r27,r23
	ld __tmp_reg__,X+
	ld r27,X
	mov r26,__tmp_reg__
	std Z+1,r27
	st Z,r26
.L77:
	subi r20,-1
	sbci r21,-1
	adiw r30,2
	rjmp .L76
.L79:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	formColorPack_scheme, .-formColorPack_scheme
	.section	.text.flush_mask,"ax",@progbits
.global	flush_mask
	.type	flush_mask, @function
flush_mask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	ldi r24,lo8(9)
	add r24,r30
.L81:
	st Z+,__zero_reg__
	cpse r24,r30
	rjmp .L81
/* epilogue start */
	ret
	.size	flush_mask, .-flush_mask
	.section	.text.fill_mask,"ax",@progbits
.global	fill_mask
	.type	fill_mask, @function
fill_mask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	ldi r25,lo8(1)
	ldi r24,lo8(9)
	add r24,r30
.L84:
	st Z+,r25
	cpse r24,r30
	rjmp .L84
/* epilogue start */
	ret
	.size	fill_mask, .-fill_mask
	.section	.text.set_level,"ax",@progbits
.global	set_level
	.type	set_level, @function
set_level:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r18,lo8(rgb4)
	ldi r19,hi8(rgb4)
	ldi r24,lo8(-1)
	movw r30,r18
	std Z+2,r24
	ldi r28,lo8(rgb3)
	ldi r29,hi8(rgb3)
	st Y,r24
	ldi r26,lo8(rgb2)
	ldi r27,hi8(rgb2)
	st X,r24
	ldi r20,lo8(rgb)
	ldi r21,hi8(rgb)
	movw r30,r20
	st Z,r24
	movw r30,r18
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Y+2,__zero_reg__
	adiw r26,2
	st X,__zero_reg__
	sbiw r26,2
	movw r30,r20
	std Z+2,__zero_reg__
	std Y+1,__zero_reg__
	adiw r26,1
	st X,__zero_reg__
	std Z+1,__zero_reg__
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	set_level, .-set_level
	.section	.text.l_shift,"ax",@progbits
.global	l_shift
	.type	l_shift, @function
l_shift:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ld r18,Z
	mov r20,r24
	movw r26,r24
	movw r30,r24
.L88:
	adiw r30,1
	mov r19,r30
	sub r19,r20
	cp r19,r22
	brsh .L90
	ld r19,Z
	st X+,r19
	rjmp .L88
.L90:
	add r24,r22
	adc r25,__zero_reg__
	movw r30,r24
	sbiw r30,1
	st Z,r18
	ret
	.size	l_shift, .-l_shift
	.section	.text.r_shift,"ax",@progbits
.global	r_shift
	.type	r_shift, @function
r_shift:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	add r30,r22
	adc r31,__zero_reg__
	sbiw r30,1
	ld r18,Z
.L94:
	subi r22,lo8(-(-1))
	movw r30,r24
	breq .L95
	add r30,r22
	adc r31,__zero_reg__
	movw r26,r30
	sbiw r26,1
	ld r19,X
	st Z,r19
	rjmp .L94
.L95:
	st Z,r18
	ret
	.size	r_shift, .-r_shift
	.section	.text.const_light,"ax",@progbits
.global	const_light
	.type	const_light, @function
const_light:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
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
/* stack size = 18 */
.L__stack_usage = 18
	mov r11,r24
	lds r24,bbb
	cpi r24,lo8(1)
	brne .+2
	rjmp .L97
	mov r7,r22
	mov r29,r11
	mov r11,__zero_reg__
	ldi r28,lo8(r)
	mov r14,r28
	ldi r28,hi8(r)
	mov r15,r28
	ldi r24,lo8(b)
	ldi r25,hi8(b)
	ldi r17,lo8(8)
	mov r8,r17
	add r8,r24
	ldi r28,lo8(8)
	add r28,r14
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	ldi r16,lo8(8)
	mov r10,r16
	add r10,r24
	ldi r24,lo8(wave_3)
	ldi r25,hi8(wave_3)
	ldi r25,lo8(8)
	mov r9,r25
	add r9,r24
	mov r16,r29
	ldi r17,0
	movw r24,r16
	subi r24,lo8(-(mr))
	sbci r25,hi8(-(mr))
	movw r12,r24
.L98:
	cp r11,r7
	brne .+2
	rjmp .L218
	cpi r29,lo8(8)
	brsh .L99
	movw r26,r12
	ld r20,X
	movw r30,r16
	subi r30,lo8(-(mg))
	sbci r31,hi8(-(mg))
	ld r19,Z
	movw r30,r16
	subi r30,lo8(-(mb))
	sbci r31,hi8(-(mb))
	ld r18,Z
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L100:
	st Z+,r20
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r22
	st X+,r18
	movw r22,r26
	cpse r28,r30
	rjmp .L100
	rjmp .L101
.L99:
	cpi r29,lo8(10)
	brne .+2
	rjmp .L103
	brsh .L104
	cpi r29,lo8(8)
	breq .L105
	cpi r29,lo8(9)
	breq .+2
	rjmp .L102
	ldi r24,lo8(r)
	ldi r25,hi8(r)
	ldi r26,lo8(g)
	ldi r27,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r18,lo8(-2)
	ldi r19,lo8(-1)
	rjmp .L115
.L104:
	cpi r29,lo8(11)
	brne .+2
	rjmp .L107
	cpi r29,lo8(12)
	breq .+2
	rjmp .L102
	ldi r24,lo8(-1)
	sts b+7,r24
	sts b+6,r24
	sts b+5,r24
	sts b+4,r24
	sts r+3,r24
	sts r+2,r24
	sts r+1,r24
	sts r,r24
	sts r+7,__zero_reg__
	sts r+6,__zero_reg__
	sts r+5,__zero_reg__
	sts r+4,__zero_reg__
	sts g+3,__zero_reg__
	sts g+2,__zero_reg__
	sts g+1,__zero_reg__
	sts g,__zero_reg__
	sts g+7,__zero_reg__
	sts g+6,__zero_reg__
	sts g+5,__zero_reg__
	sts g+4,__zero_reg__
	rjmp .L212
.L105:
	ldi r24,lo8(r)
	ldi r25,hi8(r)
	ldi r26,lo8(g)
	ldi r27,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r18,lo8(-2)
	ldi r19,lo8(-1)
.L111:
	movw r30,r24
	cpi r18,lo8(4)
	brlo .L109
	st Z,r19
	rjmp .L204
.L109:
	st Z,__zero_reg__
.L204:
	st X,r19
	movw r30,r20
	st Z,__zero_reg__
	subi r18,lo8(-(1))
	adiw r24,1
	adiw r26,1
	subi r20,-1
	sbci r21,-1
	cpi r18,lo8(6)
	brne .L111
	rjmp .L101
.L113:
	st Z,__zero_reg__
	st X,__zero_reg__
	movw r30,r20
	st Z,r19
.L114:
	subi r18,lo8(-(1))
	adiw r24,1
	adiw r26,1
	subi r20,-1
	sbci r21,-1
	cpi r18,lo8(6)
	brne .+2
	rjmp .L101
.L115:
	movw r30,r24
	cpi r18,lo8(4)
	brlo .L113
	st Z,r19
	st X,__zero_reg__
	movw r30,r20
	st Z,__zero_reg__
	rjmp .L114
.L103:
	ldi r24,lo8(-106)
	sts b+1,r24
	sts b,r24
	sts g+1,r24
	sts g,r24
	sts r+1,r24
	sts r,r24
	sts g+2,__zero_reg__
	sts g+5,__zero_reg__
	sts g+4,__zero_reg__
	sts g+3,__zero_reg__
	sts r+2,__zero_reg__
	sts r+5,__zero_reg__
	sts r+4,__zero_reg__
	sts r+3,__zero_reg__
	ldi r24,lo8(-1)
	sts b+5,r24
	sts b+4,r24
	sts b+3,r24
	sts b+2,r24
	sts r+7,r24
	sts r+6,r24
	rjmp .L101
.L107:
	ldi r24,lo8(-1)
	sts g+7,r24
	sts g+6,r24
	sts g+5,r24
	sts g+4,r24
	sts r+3,r24
	sts r+2,r24
	sts r+1,r24
	sts r,r24
	sts r+7,__zero_reg__
	sts r+6,__zero_reg__
	sts r+5,__zero_reg__
	sts r+4,__zero_reg__
	sts g+3,__zero_reg__
	sts g+2,__zero_reg__
	sts g+1,__zero_reg__
	sts g,__zero_reg__
	sts b+7,__zero_reg__
	sts b+6,__zero_reg__
	sts b+5,__zero_reg__
	sts b+4,__zero_reg__
.L212:
	sts b+3,__zero_reg__
	sts b+2,__zero_reg__
	sts b+1,__zero_reg__
	sts b,__zero_reg__
	rjmp .L101
.L102:
	cpi r29,lo8(13)
	breq .L118
	cpi r29,lo8(14)
	breq .+2
	rjmp .L219
	lds r18,rgb2
	lds r19,rgb2+1
	lds r20,rgb2+2
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	rjmp .L122
.L118:
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r18,lo8(r)
	ldi r19,hi8(r)
	ldi r30,lo8(b)
	ldi r31,hi8(b)
.L120:
	st Z+,__zero_reg__
	movw r26,r24
	st X+,__zero_reg__
	movw r24,r26
	movw r26,r18
	st X+,__zero_reg__
	movw r18,r26
	cpse r8,r30
	rjmp .L120
	ldi r24,lo8(-1)
	sts b+7,r24
	sts r+6,r24
	sts g+5,r24
	sts b+4,r24
	sts r+3,r24
	sts g+2,r24
	sts b+1,r24
	sts r,r24
	rjmp .L101
.L122:
	st Z+,r18
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r22
	st X+,r20
	movw r22,r26
	cpse r28,r30
	rjmp .L122
	lds r24,rgbs.1857
	cpse r24,__zero_reg__
	rjmp .L123
	subi r19,lo8(-(1))
	sts rgb2+1,r19
	subi r18,lo8(-(-1))
	sts rgb2,r18
	rjmp .L206
.L123:
	cpi r24,lo8(1)
	breq .+2
	rjmp .L101
	subi r19,lo8(-(-1))
	sts rgb2+1,r19
	subi r18,lo8(-(1))
	sts rgb2,r18
	rjmp .L209
.L219:
	cpi r29,lo8(16)
	brne .+2
	rjmp .L126
	brsh .L127
	cpi r29,lo8(15)
	breq .+2
	rjmp .L125
	lds r18,rgb3
	lds r20,rgb3+1
	lds r19,rgb3+2
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	rjmp .L131
.L127:
	cpi r29,lo8(17)
	brne .+2
	rjmp .L129
	cpi r29,lo8(18)
	breq .+2
	rjmp .L125
	lds r18,tmpsch.1858
	mov r24,r18
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(mr))
	sbci r31,hi8(-(mr))
	ld r21,Z
	movw r30,r24
	subi r30,lo8(-(mg))
	sbci r31,hi8(-(mg))
	ld r20,Z
	movw r30,r24
	subi r30,lo8(-(mb))
	sbci r31,hi8(-(mb))
	ld r19,Z
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	rjmp .L142
.L131:
	st Z+,r18
	movw r26,r24
	st X+,r20
	movw r24,r26
	movw r26,r22
	st X+,r19
	movw r22,r26
	cpse r28,r30
	rjmp .L131
	lds r24,rgbs.1857
	cpse r24,__zero_reg__
	rjmp .L132
	subi r19,lo8(-(1))
	sts rgb3+2,r19
	subi r18,lo8(-(-1))
	sts rgb3,r18
.L206:
	cpi r19,lo8(-1)
	breq .+2
	rjmp .L101
	ldi r24,lo8(1)
	rjmp .L210
.L132:
	cpi r24,lo8(1)
	breq .+2
	rjmp .L101
	subi r19,lo8(-(-1))
	sts rgb3+2,r19
	subi r18,lo8(-(1))
	sts rgb3,r18
.L209:
	cpi r18,lo8(-1)
	breq .+2
	rjmp .L101
.L138:
	sts rgbs.1857,__zero_reg__
	rjmp .L101
.L126:
	lds r20,rgb4
	lds r19,rgb4+1
	lds r18,rgb4+2
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L135:
	st Z+,r20
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r22
	st X+,r18
	movw r22,r26
	cpse r28,r30
	rjmp .L135
	lds r24,rgbs.1857
	cpse r24,__zero_reg__
	rjmp .L136
	subi r19,lo8(-(1))
	sts rgb4+1,r19
	subi r18,lo8(-(-1))
	sts rgb4+2,r18
	rjmp .L206
.L136:
	cpi r24,lo8(1)
	breq .+2
	rjmp .L101
	subi r19,lo8(-(-1))
	sts rgb4+1,r19
	subi r18,lo8(-(1))
	sts rgb4+2,r18
	rjmp .L209
.L129:
	lds r20,rgb
	lds r19,rgb+1
	lds r18,rgb+2
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L139:
	st Z+,r20
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r22
	st X+,r18
	movw r22,r26
	cpse r28,r30
	rjmp .L139
	lds r24,rgbs.1857
	cpse r24,__zero_reg__
	rjmp .L140
	subi r19,lo8(-(1))
	sts rgb+1,r19
	subi r20,lo8(-(-1))
	sts rgb,r20
	rjmp .L206
.L140:
	cpi r24,lo8(1)
	brne .L141
	subi r18,lo8(-(1))
	sts rgb+2,r18
	subi r19,lo8(-(-1))
	sts rgb+1,r19
	cpi r18,lo8(-1)
	breq .+2
	rjmp .L101
	ldi r24,lo8(2)
.L210:
	sts rgbs.1857,r24
	rjmp .L101
.L141:
	cpi r24,lo8(2)
	breq .+2
	rjmp .L138
	subi r18,lo8(-(-1))
	sts rgb+2,r18
	subi r20,lo8(-(1))
	sts rgb,r20
	tst r18
	brne .+2
	rjmp .L138
	rjmp .L101
.L142:
	st Z+,r21
	movw r26,r24
	st X+,r20
	movw r24,r26
	movw r26,r22
	st X+,r19
	movw r22,r26
	cpse r28,r30
	rjmp .L142
	ldi r24,lo8(1)
	add r24,r18
	cpi r24,lo8(9)
	brlo .L211
	ldi r24,lo8(1)
.L211:
	sts tmpsch.1858,r24
	rjmp .L101
.L125:
	cpi r29,lo8(20)
	breq .L144
	brsh .L145
	cpi r29,lo8(19)
	breq .L146
	rjmp .L101
.L145:
	cpi r29,lo8(21)
	brne .+2
	rjmp .L147
	cpi r29,lo8(22)
	brne .+2
	rjmp .L148
	rjmp .L101
.L146:
	lds r24,counter.1859
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L149
	sts counter.1859,r24
	rjmp .L150
.L149:
	sts counter.1859,__zero_reg__
	ldi r22,lo8(8)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(8)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L150:
	ldi r20,lo8(r)
	ldi r21,hi8(r)
	ldi r18,lo8(wave_2)
	ldi r19,hi8(wave_2)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r27,lo8(b)
	mov r4,r27
	ldi r27,hi8(b)
	mov r5,r27
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
.L151:
	ld r22,Z+
	movw r26,r20
	st X+,r22
	movw r20,r26
	movw r26,r18
	ld r22,X+
	movw r18,r26
	movw r26,r24
	st X+,r22
	movw r24,r26
	movw r26,r4
	st X+,__zero_reg__
	movw r4,r26
	cpse r10,r30
	rjmp .L151
	rjmp .L101
.L144:
	lds r24,counter.1859
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L153
	sts counter.1859,r24
	rjmp .L154
.L153:
	sts counter.1859,__zero_reg__
	ldi r22,lo8(8)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(8)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L154:
	ldi r20,lo8(r)
	ldi r21,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	ldi r26,lo8(b)
	mov r4,r26
	ldi r26,hi8(b)
	mov r5,r26
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
.L155:
	ld r22,Z+
	movw r26,r20
	st X+,r22
	movw r20,r26
	movw r26,r18
	st X+,__zero_reg__
	movw r18,r26
	movw r26,r24
	ld r22,X+
	movw r24,r26
	movw r26,r4
	st X+,r22
	movw r4,r26
	cpse r10,r30
	rjmp .L155
	rjmp .L101
.L147:
	lds r24,counter.1859
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L156
	sts counter.1859,r24
	rjmp .L157
.L156:
	sts counter.1859,__zero_reg__
	ldi r22,lo8(8)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(8)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L157:
	ldi r20,lo8(wave_1)
	ldi r21,hi8(wave_1)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	ldi r31,lo8(b)
	mov r4,r31
	ldi r31,hi8(b)
	mov r5,r31
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L158:
	st Z+,__zero_reg__
	movw r26,r20
	ld r22,X+
	movw r20,r26
	movw r26,r18
	st X+,r22
	movw r18,r26
	movw r26,r24
	ld r22,X+
	movw r24,r26
	movw r26,r4
	st X+,r22
	movw r4,r26
	cpse r28,r30
	rjmp .L158
	rjmp .L101
.L148:
	lds r24,counter.1859
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L159
	sts counter.1859,r24
	rjmp .L160
.L159:
	sts counter.1859,__zero_reg__
	ldi r22,lo8(8)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(8)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L160:
	ldi r24,lo8(r)
	ldi r25,hi8(r)
	ldi r22,lo8(wave_1)
	ldi r23,hi8(wave_1)
	ldi r20,lo8(g)
	ldi r21,hi8(g)
	ldi r18,lo8(wave_2)
	ldi r19,hi8(wave_2)
	ldi r30,lo8(b)
	mov r4,r30
	ldi r30,hi8(b)
	mov r5,r30
	ldi r30,lo8(wave_3)
	ldi r31,hi8(wave_3)
.L161:
	ld r6,Z+
	movw r26,r24
	st X+,r6
	movw r24,r26
	movw r26,r22
	ld r6,X+
	movw r22,r26
	movw r26,r20
	st X+,r6
	movw r20,r26
	movw r26,r18
	ld r6,X+
	movw r18,r26
	movw r26,r4
	st X+,r6
	movw r4,r26
	cpse r9,r30
	rjmp .L161
.L101:
	rcall check_button
	cpi r24,lo8(1)
	brne .L162
	sts bbb,r24
	rjmp .L97
.L162:
	lds r18,econom
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r20,lo8(9)
	add r20,r14
.L166:
	cpi r18,lo8(1)
	brne .L163
	ld r19,Z
	lsr r19
	lsr r19
	st Z,r19
	movw r26,r24
	ld r19,X
	lsr r19
	lsr r19
	st X,r19
	movw r26,r22
	ld r19,X
	lsr r19
	lsr r19
	rjmp .L213
.L163:
	cpi r18,lo8(2)
	brne .L165
	ld r19,Z
	swap r19
	andi r19,lo8(15)
	st Z,r19
	movw r26,r24
	ld r19,X
	swap r19
	andi r19,lo8(15)
	st X,r19
	movw r26,r22
	ld r19,X
	swap r19
	andi r19,lo8(15)
	rjmp .L213
.L165:
	cpi r18,lo8(3)
	brne .L164
	ld r19,Z
	swap r19
	lsr r19
	lsr r19
	andi r19,lo8(3)
	st Z,r19
	movw r26,r24
	ld r19,X
	swap r19
	lsr r19
	lsr r19
	andi r19,lo8(3)
	st X,r19
	movw r26,r22
	ld r19,X
	swap r19
	lsr r19
	lsr r19
	andi r19,lo8(3)
.L213:
	st X,r19
.L164:
	adiw r30,1
	adiw r24,1
	subi r22,-1
	sbci r23,-1
	cpse r20,r30
	rjmp .L166
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	mov r4,__zero_reg__
	mov r5,__zero_reg__
.L169:
	movw r30,r4
	subi r30,lo8(-(mask))
	sbci r31,hi8(-(mask))
	ldd r24,Z+1
	tst r24
	breq .L167
	movw r30,r4
	subi r30,lo8(-(b))
	sbci r31,hi8(-(b))
	ld r2,Z
	movw r30,r4
	subi r30,lo8(-(g))
	sbci r31,hi8(-(g))
	ld r3,Z
	movw r30,r4
	subi r30,lo8(-(r))
	sbci r31,hi8(-(r))
	ld r6,Z
	ldi r24,lo8(-1)
	rcall sendByte
	mov r24,r2
	rcall sendByte
	mov r24,r3
	rcall sendByte
	mov r24,r6
	rjmp .L214
.L167:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
.L214:
	rcall sendByte
	ldi r27,-1
	sub r4,r27
	sbc r5,r27
	ldi r30,8
	cp r4,r30
	cpc r5,__zero_reg__
	brne .L169
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(1999)
	ldi r25,hi8(1999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	inc r11
	rjmp .L98
.L218:
	ldi r24,0
.L97:
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
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	ret
	.size	const_light, .-const_light
	.section	.text.const_light_legacy,"ax",@progbits
.global	const_light_legacy
	.type	const_light_legacy, @function
const_light_legacy:
	push r28
	push r29
	rcall .
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+3,r20
	std Y+2,r22
	std Y+1,r24
	rcall flush_mask
	ldd r20,Y+3
	ldd r22,Y+2
	ldd r24,Y+1
	sbrs r20,0
	rjmp .L221
	ldi r25,lo8(1)
	sts mask+1,r25
.L221:
	sbrs r20,1
	rjmp .L222
	ldi r25,lo8(1)
	sts mask+2,r25
.L222:
	sbrs r20,2
	rjmp .L223
	ldi r25,lo8(1)
	sts mask+3,r25
.L223:
	sbrs r20,3
	rjmp .L224
	ldi r25,lo8(1)
	sts mask+4,r25
.L224:
	sbrs r20,4
	rjmp .L225
	ldi r25,lo8(1)
	sts mask+5,r25
.L225:
	sbrs r20,5
	rjmp .L226
	ldi r25,lo8(1)
	sts mask+6,r25
.L226:
	sbrs r20,6
	rjmp .L227
	ldi r25,lo8(1)
	sts mask+7,r25
.L227:
	sbrs r20,7
	rjmp .L228
	ldi r25,lo8(1)
	sts mask+8,r25
.L228:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	rjmp const_light
	.size	const_light_legacy, .-const_light_legacy
	.section	.text.mode_1,"ax",@progbits
.global	mode_1
	.type	mode_1, @function
mode_1:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(-1)
	ldi r22,lo8(10)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_1, .-mode_1
	.section	.text.mode_2,"ax",@progbits
.global	mode_2
	.type	mode_2, @function
mode_2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(-1)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-1)
	ldi r22,lo8(6)
	ldi r24,0
	rjmp const_light_legacy
	.size	mode_2, .-mode_2
	.section	.text.mode_3,"ax",@progbits
.global	mode_3
	.type	mode_3, @function
mode_3:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(15)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-16)
	ldi r22,lo8(6)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_3, .-mode_3
	.section	.text.mode_4,"ax",@progbits
.global	mode_4
	.type	mode_4, @function
mode_4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(4)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(8)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(16)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(32)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(64)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-1)
	ldi r22,lo8(2)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_4, .-mode_4
	.section	.text.mode_5,"ax",@progbits
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
	rcall const_light_legacy
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(36)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(102)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-103)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(102)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(36)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_5, .-mode_5
	.section	.text.mode_6,"ax",@progbits
.global	mode_6
	.type	mode_6, @function
mode_6:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(60)
	ldi r22,lo8(11)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-25)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-61)
	ldi r22,lo8(9)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-25)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(24)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_6, .-mode_6
	.section	.text.mode_7,"ax",@progbits
.global	mode_7
	.type	mode_7, @function
mode_7:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-122)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(72)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(126)
	ldi r22,lo8(9)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(20)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(52)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(66)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(33)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(34)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(82)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(76)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-124)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(72)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-116)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-126)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_7, .-mode_7
	.section	.text.mode_8,"ax",@progbits
.global	mode_8
	.type	mode_8, @function
mode_8:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(124)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(30)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(63)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-1)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(63)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(30)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(124)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_8, .-mode_8
	.section	.text.mode_9,"ax",@progbits
.global	mode_9
	.type	mode_9, @function
mode_9:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-32)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-28)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(24)
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(39)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(7)
	ldi r22,lo8(6)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_9, .-mode_9
	.section	.text.mode_10,"ax",@progbits
.global	mode_10
	.type	mode_10, @function
mode_10:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-128)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-115)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-112)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(96)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-3)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_10, .-mode_10
	.section	.text.heart,"ax",@progbits
.global	heart
	.type	heart, @function
heart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(112)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-8)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-4)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(15)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(126)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-4)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-8)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(112)
	ldi r22,lo8(3)
	lds r24,mode
	rjmp const_light_legacy
	.size	heart, .-heart
	.section	.text.binary,"ax",@progbits
.global	binary
	.type	binary, @function
binary:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r20,a.1795
	lds r24,i.1794
	add r20,r24
	sts i.1794,r20
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	lds r24,i.1794
	cpi r24,lo8(-1)
	breq .L264
	cpse r24,__zero_reg__
	rjmp .L261
	ldi r24,lo8(1)
.L264:
	sts a.1795,r24
.L261:
	ret
	.size	binary, .-binary
	.section	.text.svetobobr,"ax",@progbits
.global	svetobobr
	.type	svetobobr, @function
svetobobr:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(48)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(6)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(112)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(3)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(12)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(112)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(73)
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(64)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(64)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(65)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(54)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(65)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(62)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(73)
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(54)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(127)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(72)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(68)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(51)
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,0
	ldi r22,lo8(5)
	lds r24,mode
	rjmp const_light_legacy
	.size	svetobobr, .-svetobobr
	.section	.text.mode_4_18,"ax",@progbits
.global	mode_4_18
	.type	mode_4_18, @function
mode_4_18:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,a.1766
	lds r25,a.1766+1
	ldi r18,lo8(8)
	ldi r19,0
	sub r18,r24
	sbc r19,r25
	ldi r24,lo8(1)
	ldi r25,0
	ldi r20,lo8(1)
.L270:
	movw r30,r24
	subi r30,lo8(-(mask))
	sbci r31,hi8(-(mask))
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L267
	cp r24,r18
	cpc r25,r19
	breq .L267
	cpi r24,lo8(8)
	brne .L268
.L267:
	st Z,r20
	rjmp .L269
.L268:
	st Z,__zero_reg__
.L269:
	adiw r24,1
	cpi r24,9
	cpc r25,__zero_reg__
	brne .L270
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1766
	lds r25,a.1766+1
	adiw r24,1
	cpi r24,9
	cpc r25,__zero_reg__
	brsh .L271
	sts a.1766+1,r25
	sts a.1766,r24
	ret
.L271:
	sts a.1766+1,__zero_reg__
	sts a.1766,__zero_reg__
	ret
	.size	mode_4_18, .-mode_4_18
	.section	.text.mode_8_18,"ax",@progbits
.global	mode_8_18
	.type	mode_8_18, @function
mode_8_18:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,a.1781
	lds r19,a.1781+1
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	ldi r24,lo8(1)
	subi r18,lo8(mask)
	sbci r19,hi8(mask)
	ldi r25,lo8(1)
.L281:
	movw r20,r18
	add r20,r30
	adc r21,r31
	sbrc r20,1
	rjmp .L278
	cpi r24,lo8(1)
	breq .L278
	cpi r24,lo8(8)
	brne .L279
.L278:
	st Z,r25
	rjmp .L280
.L279:
	st Z,__zero_reg__
.L280:
	subi r24,lo8(-(1))
	adiw r30,1
	cpi r24,lo8(9)
	brne .L281
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1781
	lds r25,a.1781+1
	adiw r24,1
	cpi r24,9
	cpc r25,__zero_reg__
	brsh .L282
	sts a.1781+1,r25
	sts a.1781,r24
	ret
.L282:
	sts a.1781+1,__zero_reg__
	sts a.1781,__zero_reg__
	ret
	.size	mode_8_18, .-mode_8_18
	.section	.text.make_serie,"ax",@progbits
.global	make_serie
	.type	make_serie, @function
make_serie:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L290
	cpi r24,lo8(3)
	breq .L291
	cpi r24,lo8(1)
	brne .L316
	rcall mode_1
	ret
.L290:
	rcall mode_2
	ret
.L291:
	rcall mode_3
	ret
.L316:
	cpi r24,lo8(5)
	breq .L295
	cpi r24,lo8(6)
	breq .L296
	cpi r24,lo8(4)
	brne .L318
	rcall mode_4
	ret
.L295:
	rcall mode_5
	ret
.L296:
	rcall mode_6
	ret
.L318:
	cpi r24,lo8(8)
	breq .L300
	brsh .L301
	cpi r24,lo8(7)
	brne .L299
	rcall mode_7
	ret
.L301:
	cpi r24,lo8(9)
	breq .L303
	cpi r24,lo8(10)
	brne .L299
	rcall mode_10
	ret
.L300:
	rcall mode_8
	ret
.L303:
	rcall mode_9
	ret
.L299:
	cpi r24,lo8(12)
	breq .L307
	brsh .L308
	cpi r24,lo8(11)
	brne .L306
	rjmp heart
.L308:
	cpi r24,lo8(13)
	breq .L310
	cpi r24,lo8(14)
	brne .L306
	rjmp mode_8_18
.L310:
	rjmp mode_4_18
.L307:
	rjmp binary
.L306:
	cpi r24,lo8(16)
	breq .L313
	cpi r24,lo8(17)
	breq .L314
	cpi r24,lo8(15)
	brne .L317
	rjmp svetobobr
.L313:
	rjmp demo
.L314:
	rjmp demo_long
.L317:
	ret
	.size	make_serie, .-make_serie
	.section	.text.demo,"ax",@progbits
.global	demo
	.type	demo, @function
demo:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r28,mode
	lds r24,dm.1801
	sts mode,r24
	lds r24,ds.1800
	rcall make_serie
	sts mode,r28
	lds r24,dm.1801
	subi r24,lo8(-(1))
	cpi r24,lo8(13)
	brsh .L320
	sts dm.1801,r24
	rjmp .L319
.L320:
	ldi r25,lo8(1)
	sts dm.1801,r25
	lds r24,ds.1800
	subi r24,lo8(-(1))
	cpi r24,lo8(15)
	brsh .L322
	sts ds.1800,r24
	rjmp .L319
.L322:
	sts ds.1800,r25
.L319:
/* epilogue start */
	pop r28
	ret
	.size	demo, .-demo
	.section	.text.demo_long,"ax",@progbits
.global	demo_long
	.type	demo_long, @function
demo_long:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r28,mode
	lds r24,dm.1806
	sts mode,r24
	lds r24,ds.1805
	rcall make_serie
	sts mode,r28
	lds r24,counter.1807
	subi r24,lo8(-(1))
	cpi r24,lo8(-1)
	breq .L325
	sts counter.1807,r24
	rjmp .L324
.L325:
	sts counter.1807,__zero_reg__
	lds r24,dm.1806
	subi r24,lo8(-(1))
	cpi r24,lo8(13)
	brsh .L327
	sts dm.1806,r24
	rjmp .L324
.L327:
	ldi r25,lo8(1)
	sts dm.1806,r25
	lds r24,ds.1805
	subi r24,lo8(-(1))
	cpi r24,lo8(15)
	brsh .L329
	sts ds.1805,r24
	rjmp .L324
.L329:
	sts ds.1805,r25
.L324:
/* epilogue start */
	pop r28
	ret
	.size	demo_long, .-demo_long
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall read_data
	rcall check_all
	ldi r24,lo8(1)
	sts power,r24
	sts stat,__zero_reg__
	rcall init_io
	sts econom,__zero_reg__
/* #APP */
 ;  132 "poi-8LED-v2-1.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r28,lo8(16)
	ldi r29,lo8(32)
.L331:
	sts bbb,__zero_reg__
/* #APP */
 ;  143 "poi-8LED-v2-1.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L332
	ldi r22,lo8(1)
	rcall const_light
	out 0x17,__zero_reg__
	out 0x18,r28
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
	out 0x3b,r29
	out 0x15,r28
/* #APP */
 ;  152 "poi-8LED-v2-1.c" 1
	sei
 ;  0 "" 2
 ;  153 "poi-8LED-v2-1.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L331
.L332:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L334
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L335
	lds r24,serie
	rcall make_serie
	rjmp .L331
.L335:
	lds r24,counter
	tst r24
	breq .L336
	lds r17,mode
	lds r24,pointer
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	ld r18,Z
	sts mode,r18
	movw r30,r24
	subi r30,lo8(-(series))
	sbci r31,hi8(-(series))
	ld r24,Z
	rcall make_serie
	sts mode,r17
	rjmp .L331
.L336:
	ldi r24,lo8(100)
.L334:
	rcall process_signal
	rjmp .L331
	.size	main, .-main
	.section	.bss.counter.1859,"aw",@nobits
	.type	counter.1859, @object
	.size	counter.1859, 1
counter.1859:
	.zero	1
	.section	.data.tmpsch.1858,"aw",@progbits
	.type	tmpsch.1858, @object
	.size	tmpsch.1858, 1
tmpsch.1858:
	.byte	1
	.section	.bss.rgbs.1857,"aw",@nobits
	.type	rgbs.1857, @object
	.size	rgbs.1857, 1
rgbs.1857:
	.zero	1
	.section	.bss.counter.1807,"aw",@nobits
	.type	counter.1807, @object
	.size	counter.1807, 1
counter.1807:
	.zero	1
	.section	.data.ds.1805,"aw",@progbits
	.type	ds.1805, @object
	.size	ds.1805, 1
ds.1805:
	.byte	1
	.section	.data.dm.1806,"aw",@progbits
	.type	dm.1806, @object
	.size	dm.1806, 1
dm.1806:
	.byte	1
	.section	.data.ds.1800,"aw",@progbits
	.type	ds.1800, @object
	.size	ds.1800, 1
ds.1800:
	.byte	1
	.section	.data.dm.1801,"aw",@progbits
	.type	dm.1801, @object
	.size	dm.1801, 1
dm.1801:
	.byte	1
	.section	.data.a.1795,"aw",@progbits
	.type	a.1795, @object
	.size	a.1795, 1
a.1795:
	.byte	1
	.section	.bss.i.1794,"aw",@nobits
	.type	i.1794, @object
	.size	i.1794, 1
i.1794:
	.zero	1
	.section	.bss.a.1781,"aw",@nobits
	.type	a.1781, @object
	.size	a.1781, 2
a.1781:
	.zero	2
	.section	.bss.a.1766,"aw",@nobits
	.type	a.1766, @object
	.size	a.1766, 2
a.1766:
	.zero	2
	.section	.bss.last_button_state.1664,"aw",@nobits
	.type	last_button_state.1664, @object
	.size	last_button_state.1664, 1
last_button_state.1664:
	.zero	1
	.section	.bss.hold.1662,"aw",@nobits
	.type	hold.1662, @object
	.size	hold.1662, 2
hold.1662:
	.zero	2
	.section	.bss.button_state.1663,"aw",@nobits
	.type	button_state.1663, @object
	.size	button_state.1663, 1
button_state.1663:
	.zero	1
.global	wave_3
	.section	.data.wave_3,"aw",@progbits
	.type	wave_3, @object
	.size	wave_3, 8
wave_3:
	.byte	50
	.byte	-106
	.byte	-1
	.byte	-106
	.byte	50
	.byte	0
	.byte	0
	.byte	0
.global	wave_2
	.section	.data.wave_2,"aw",@progbits
	.type	wave_2, @object
	.size	wave_2, 8
wave_2:
	.byte	-1
	.byte	-61
	.byte	-116
	.byte	95
	.byte	55
	.byte	25
	.byte	5
	.byte	0
.global	wave_1
	.section	.data.wave_1,"aw",@progbits
	.type	wave_1, @object
	.size	wave_1, 8
wave_1:
	.byte	-1
	.byte	-61
	.byte	-116
	.byte	95
	.byte	55
	.byte	25
	.byte	5
	.byte	0
	.section	.bss.rgb4,"aw",@nobits
	.type	rgb4, @object
	.size	rgb4, 3
rgb4:
	.zero	3
	.section	.bss.rgb3,"aw",@nobits
	.type	rgb3, @object
	.size	rgb3, 3
rgb3:
	.zero	3
	.section	.bss.rgb2,"aw",@nobits
	.type	rgb2, @object
	.size	rgb2, 3
rgb2:
	.zero	3
	.section	.bss.rgb,"aw",@nobits
	.type	rgb, @object
	.size	rgb, 3
rgb:
	.zero	3
.global	bbb
	.section	.bss.bbb,"aw",@nobits
	.type	bbb, @object
	.size	bbb, 1
bbb:
	.zero	1
	.comm	mask,9,1
	.comm	b,8,1
	.comm	g,8,1
	.comm	r,8,1
	.comm	stat,1,1
.global	e_econom
	.section	.eeprom,"aw",@progbits
	.type	e_econom, @object
	.size	e_econom, 1
e_econom:
	.zero	1
.global	e_fav_on
	.type	e_fav_on, @object
	.size	e_fav_on, 1
e_fav_on:
	.zero	1
.global	e_pointer
	.type	e_pointer, @object
	.size	e_pointer, 1
e_pointer:
	.zero	1
.global	e_counter
	.type	e_counter, @object
	.size	e_counter, 1
e_counter:
	.zero	1
.global	sm
	.type	sm, @object
	.size	sm, 16
sm:
	.zero	16
.global	fm
	.type	fm, @object
	.size	fm, 16
fm:
	.zero	16
	.comm	fav_on,1,1
	.comm	pointer,1,1
	.comm	counter,1,1
	.comm	series,16,1
	.comm	modes,16,1
.global	e_power
	.type	e_power, @object
	.size	e_power, 1
e_power:
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
.global	mb
	.section	.data.mb,"aw",@progbits
	.type	mb, @object
	.size	mb, 8
mb:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
.global	mg
	.section	.data.mg,"aw",@progbits
	.type	mg, @object
	.size	mg, 8
mg:
	.byte	0
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	0
	.byte	-1
.global	mr
	.section	.data.mr,"aw",@progbits
	.type	mr, @object
	.size	mr, 8
mr:
	.byte	0
	.byte	-1
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	-1
.global	econom
	.section	.bss.econom,"aw",@nobits
	.type	econom, @object
	.size	econom, 1
econom:
	.zero	1
	.comm	power,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.comm	pal,2,1
	.comm	scheme,16,1
	.comm	pack,16,1
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.5.0_1662) 4.9.2"
.global __do_copy_data
.global __do_clear_bss
