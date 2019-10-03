	.file	"poi-4LED-v2-1.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
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
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L13:
	ld r25,Z
	cpi r25,lo8(23)
	brlo .L11
	st Z,r24
.L11:
	ld r25,X
	cpi r25,lo8(18)
	brlo .L12
	st X,r24
.L12:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L13
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
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbis 0x16,4
	rjmp .L51
	sts button_state.1768,__zero_reg__
	rjmp .L52
.L51:
	ldi r24,lo8(1)
	sts button_state.1768,r24
.L52:
	lds r22,button_state.1768
	cpi r22,lo8(1)
	brne .L53
	lds r24,hold.1767
	lds r25,hold.1767+1
	adiw r24,1
	sts hold.1767+1,r25
	sts hold.1767,r24
.L53:
	lds r24,last_button_state.1769
	cpse r22,r24
	rjmp .L56
	ldi r23,0
	lds r24,hold.1767
	lds r25,hold.1767+1
	rcall process_button
	rjmp .L54
.L56:
	ldi r24,0
.L54:
	lds r25,button_state.1768
	cpse r25,__zero_reg__
	rjmp .L55
	lds r18,last_button_state.1769
	cpse r18,__zero_reg__
	rjmp .L55
	sts hold.1767+1,__zero_reg__
	sts hold.1767,__zero_reg__
.L55:
	sts last_button_state.1769,r25
	ret
	.size	check_button, .-check_button
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
	.section	.progmem.gcc_sw_table,"ax",@progbits
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
	.text
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
	movw r16,r18
	and r16,r26
	and r17,r27
	cp r26,r16
	cpc r27,r17
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
	movw r26,r22
	movw r30,r20
	ldi r20,0
	ldi r21,0
	clr r14
	inc r14
	mov r15,__zero_reg__
	ldi r19,0
.L76:
	mov r25,r20
	cp r20,r24
	brsh .L79
	lds r22,pal
	lds r23,pal+1
	movw r28,r22
	ld r22,Y
	ldd r23,Y+1
	std Z+1,r23
	st Z,r22
	cpi r25,lo8(8)
	brsh .L77
	movw r22,r14
	mov r0,r20
	rjmp 2f
	1:
	lsl r22
	rol r23
	2:
	dec r0
	brpl 1b
	movw r16,r18
	and r16,r22
	and r17,r23
	cp r22,r16
	cpc r23,r17
	brne .L77
	ld r22,X+
	ld r23,X
	sbiw r26,1
	std Z+1,r23
	st Z,r22
.L77:
	subi r20,-1
	sbci r21,-1
	adiw r26,2
	adiw r30,2
	rjmp .L76
.L79:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	formColorPack_scheme, .-formColorPack_scheme
.global	flush_mask
	.type	flush_mask, @function
flush_mask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	st Z,__zero_reg__
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	std Z+3,__zero_reg__
	std Z+4,__zero_reg__
	ret
	.size	flush_mask, .-flush_mask
.global	fill_mask
	.type	fill_mask, @function
fill_mask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	ldi r24,lo8(1)
	st Z,r24
	std Z+1,r24
	std Z+2,r24
	std Z+3,r24
	std Z+4,r24
	ret
	.size	fill_mask, .-fill_mask
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
.global	l_shift
	.type	l_shift, @function
l_shift:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ld r19,Z
	ldi r18,lo8(1)
.L84:
	cp r18,r22
	brsh .L86
	ldd r20,Z+1
	st Z+,r20
	subi r18,lo8(-(1))
	rjmp .L84
.L86:
	add r24,r22
	adc r25,__zero_reg__
	movw r30,r24
	sbiw r30,1
	st Z,r19
	ret
	.size	l_shift, .-l_shift
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
.L90:
	subi r22,lo8(-(-1))
	movw r30,r24
	breq .L91
	add r30,r22
	adc r31,__zero_reg__
	movw r26,r30
	sbiw r26,1
	ld r19,X
	st Z,r19
	rjmp .L90
.L91:
	st Z,r18
	ret
	.size	r_shift, .-r_shift
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
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 7 */
/* stack size = 25 */
.L__stack_usage = 25
	std Y+1,r24
	lds r24,bbb
	cpi r24,lo8(1)
	brne .+2
	rjmp .L93
	mov r9,r22
	ldd r18,Y+1
	std Y+7,r18
	mov r8,__zero_reg__
	clr r7
	inc r7
	ldi r27,lo8(wave_1+4)
	mov r2,r27
	ldi r27,hi8(wave_1+4)
	mov r3,r27
	mov r24,r18
	ldi r25,0
	movw r22,r24
	subi r22,lo8(-(mr))
	sbci r23,hi8(-(mr))
	std Y+2,r23
	std Y+1,r22
	movw r26,r24
	subi r26,lo8(-(mg))
	sbci r27,hi8(-(mg))
	std Y+4,r27
	std Y+3,r26
	movw r30,r24
	subi r30,lo8(-(mb))
	sbci r31,hi8(-(mb))
	std Y+6,r31
	std Y+5,r30
.L94:
	cp r8,r9
	brne .+2
	rjmp .L202
	ldd r31,Y+7
	cpi r31,lo8(8)
	brsh .L95
	ldd r26,Y+1
	ldd r27,Y+2
	ld r20,X
	ldd r30,Y+3
	ldd r31,Y+4
	ld r19,Z
	ldd r26,Y+5
	ldd r27,Y+6
	ld r18,X
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r16,lo8(b)
	ldi r17,hi8(b)
.L96:
	st Z+,r20
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r16
	st X+,r18
	movw r16,r26
	ldi r22,lo8(r+4)
	ldi r23,hi8(r+4)
	cp r22,r30
	cpc r23,r31
	brne .L96
	rjmp .L135
.L95:
	ldd r23,Y+7
	cpi r23,lo8(10)
	breq .L104
	brsh .L100
	cpi r23,lo8(8)
	breq .L101
	cpi r23,lo8(9)
	brne .L98
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	rjmp .L107
.L100:
	ldd r24,Y+7
	cpi r24,lo8(11)
	breq .L104
	cpi r24,lo8(12)
	breq .L104
	rjmp .L98
.L101:
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
.L105:
	ldi r26,lo8(-1)
	st Z+,r26
	movw r26,r24
	ldi r18,lo8(-1)
	st X+,r18
	movw r24,r26
	movw r26,r20
	st X+,__zero_reg__
	movw r20,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L105
	rjmp .L135
.L107:
	ldi r18,lo8(-1)
	st Z+,r18
	movw r26,r24
	st X+,__zero_reg__
	movw r24,r26
	movw r26,r20
	st X+,__zero_reg__
	movw r20,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L107
	rjmp .L135
.L104:
	sts b+3,__zero_reg__
	sts b+2,__zero_reg__
	sts b+1,__zero_reg__
	sts b,__zero_reg__
	rjmp .L135
.L98:
	ldd r30,Y+7
	cpi r30,lo8(13)
	breq .L110
	cpi r30,lo8(14)
	breq .+2
	rjmp .L203
	lds r24,rgb2
	lds r25,rgb2+1
	lds r20,rgb2+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	rjmp .L114
.L110:
	ldi r30,lo8(b)
	ldi r31,hi8(b)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r20,lo8(r)
	ldi r21,hi8(r)
.L112:
	st Z+,__zero_reg__
	movw r26,r24
	st X+,__zero_reg__
	movw r24,r26
	movw r26,r20
	st X+,__zero_reg__
	movw r20,r26
	ldi r27,hi8(b+4)
	cpi r30,lo8(b+4)
	cpc r31,r27
	brne .L112
	ldi r30,lo8(-1)
	sts r+3,r30
	sts g+2,r30
	sts b+1,r30
	sts r,r30
	rjmp .L135
.L114:
	st Z+,r24
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r20
	movw r22,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L114
	lds r18,rgbs.1901
	cpse r18,__zero_reg__
	rjmp .L115
	subi r25,lo8(-(1))
	sts rgb2+1,r25
	subi r24,lo8(-(-1))
	sts rgb2,r24
	rjmp .L194
.L115:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L135
	subi r25,lo8(-(-1))
	sts rgb2+1,r25
	subi r24,lo8(-(1))
	sts rgb2,r24
	rjmp .L197
.L203:
	ldd r30,Y+7
	cpi r30,lo8(16)
	brne .+2
	rjmp .L118
	brsh .L119
	cpi r30,lo8(15)
	breq .+2
	rjmp .L117
	lds r24,rgb3
	lds r20,rgb3+1
	lds r25,rgb3+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	rjmp .L123
.L119:
	ldd r31,Y+7
	cpi r31,lo8(17)
	brne .+2
	rjmp .L121
	cpi r31,lo8(18)
	breq .+2
	rjmp .L117
	lds r24,tmpsch.1902
	mov r18,r24
	ldi r19,0
	movw r30,r18
	subi r30,lo8(-(mr))
	sbci r31,hi8(-(mr))
	ld r20,Z
	movw r30,r18
	subi r30,lo8(-(mg))
	sbci r31,hi8(-(mg))
	ld r25,Z
	movw r30,r18
	subi r30,lo8(-(mb))
	sbci r31,hi8(-(mb))
	ld r21,Z
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r16,lo8(b)
	ldi r17,hi8(b)
	rjmp .L133
.L123:
	st Z+,r24
	movw r26,r18
	st X+,r20
	movw r18,r26
	movw r26,r22
	st X+,r25
	movw r22,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L123
	lds r18,rgbs.1901
	cpse r18,__zero_reg__
	rjmp .L124
	subi r25,lo8(-(1))
	sts rgb3+2,r25
	subi r24,lo8(-(-1))
	sts rgb3,r24
.L194:
	cpi r25,lo8(-1)
	breq .+2
	rjmp .L135
	sts rgbs.1901,r7
	rjmp .L135
.L124:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L135
	subi r25,lo8(-(-1))
	sts rgb3+2,r25
	subi r24,lo8(-(1))
	sts rgb3,r24
.L197:
	cpi r24,lo8(-1)
	breq .+2
	rjmp .L135
.L129:
	sts rgbs.1901,__zero_reg__
	rjmp .L135
.L118:
	lds r20,rgb4
	lds r25,rgb4+1
	lds r24,rgb4+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
.L126:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r24
	movw r22,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L126
	lds r18,rgbs.1901
	cpse r18,__zero_reg__
	rjmp .L127
	subi r25,lo8(-(1))
	sts rgb4+1,r25
	subi r24,lo8(-(-1))
	sts rgb4+2,r24
	rjmp .L194
.L127:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L135
	subi r25,lo8(-(-1))
	sts rgb4+1,r25
	subi r24,lo8(-(1))
	sts rgb4+2,r24
	rjmp .L197
.L121:
	lds r20,rgb
	lds r25,rgb+1
	lds r24,rgb+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
.L130:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r24
	movw r22,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L130
	lds r18,rgbs.1901
	cpse r18,__zero_reg__
	rjmp .L131
	subi r25,lo8(-(1))
	sts rgb+1,r25
	subi r20,lo8(-(-1))
	sts rgb,r20
	rjmp .L194
.L131:
	cpi r18,lo8(1)
	brne .L132
	subi r24,lo8(-(1))
	sts rgb+2,r24
	subi r25,lo8(-(-1))
	sts rgb+1,r25
	cpi r24,lo8(-1)
	breq .+2
	rjmp .L135
	ldi r30,lo8(2)
	sts rgbs.1901,r30
	rjmp .L135
.L132:
	cpi r18,lo8(2)
	breq .+2
	rjmp .L129
	subi r24,lo8(-(-1))
	sts rgb+2,r24
	subi r20,lo8(-(1))
	sts rgb,r20
	tst r24
	brne .+2
	rjmp .L129
	rjmp .L135
.L133:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r16
	st X+,r21
	movw r16,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L133
	subi r24,lo8(-(1))
	cpi r24,lo8(9)
	brsh .L134
	sts tmpsch.1902,r24
	rjmp .L135
.L134:
	sts tmpsch.1902,r7
	rjmp .L135
.L117:
	ldd r30,Y+7
	cpi r30,lo8(20)
	breq .L136
	brsh .L137
	cpi r30,lo8(19)
	breq .L138
	rjmp .L135
.L137:
	ldd r31,Y+7
	cpi r31,lo8(21)
	brne .+2
	rjmp .L139
	cpi r31,lo8(22)
	brne .+2
	rjmp .L140
	rjmp .L135
.L138:
	lds r24,counter.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L141
	sts counter.1903,r24
	rjmp .L142
.L141:
	sts counter.1903,__zero_reg__
	ldi r22,lo8(4)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(4)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L142:
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
	ldi r20,lo8(r)
	ldi r21,hi8(r)
	ldi r18,lo8(wave_2)
	ldi r19,hi8(wave_2)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r16,lo8(b)
	ldi r17,hi8(b)
.L143:
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
	movw r26,r16
	st X+,__zero_reg__
	movw r16,r26
	cp r2,r30
	cpc r3,r31
	brne .L143
	rjmp .L135
.L136:
	lds r24,counter.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L144
	sts counter.1903,r24
	rjmp .L145
.L144:
	sts counter.1903,__zero_reg__
	ldi r22,lo8(4)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(4)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L145:
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
	ldi r20,lo8(r)
	ldi r21,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	ldi r16,lo8(b)
	ldi r17,hi8(b)
.L146:
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
	movw r26,r16
	st X+,r22
	movw r16,r26
	ldi r27,hi8(wave_1+4)
	cpi r30,lo8(wave_1+4)
	cpc r31,r27
	brne .L146
	rjmp .L135
.L139:
	lds r24,counter.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L147
	sts counter.1903,r24
	rjmp .L148
.L147:
	sts counter.1903,__zero_reg__
	ldi r22,lo8(4)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(4)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L148:
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r20,lo8(wave_1)
	ldi r21,hi8(wave_1)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	ldi r16,lo8(b)
	ldi r17,hi8(b)
.L149:
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
	movw r26,r16
	st X+,r22
	movw r16,r26
	ldi r27,hi8(r+4)
	cpi r30,lo8(r+4)
	cpc r31,r27
	brne .L149
	rjmp .L135
.L140:
	lds r24,counter.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(60)
	brsh .L150
	sts counter.1903,r24
	rjmp .L151
.L150:
	sts counter.1903,__zero_reg__
	ldi r22,lo8(4)
	ldi r24,lo8(wave_1)
	ldi r25,hi8(wave_1)
	rcall l_shift
	ldi r22,lo8(4)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	rcall r_shift
.L151:
	ldi r30,lo8(wave_3)
	ldi r31,hi8(wave_3)
	ldi r22,lo8(r)
	ldi r23,hi8(r)
	ldi r20,lo8(wave_1)
	ldi r21,hi8(wave_1)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r24,lo8(wave_2)
	ldi r25,hi8(wave_2)
	ldi r26,lo8(b)
	mov r14,r26
	ldi r26,hi8(b)
	mov r15,r26
.L152:
	ld r17,Z+
	movw r26,r22
	st X+,r17
	movw r22,r26
	movw r26,r20
	ld r17,X+
	movw r20,r26
	movw r26,r18
	st X+,r17
	movw r18,r26
	movw r26,r24
	ld r17,X+
	movw r24,r26
	movw r26,r14
	st X+,r17
	movw r14,r26
	ldi r27,hi8(wave_3+4)
	cpi r30,lo8(wave_3+4)
	cpc r31,r27
	brne .L152
.L135:
	rcall check_button
	cpi r24,lo8(1)
	brne .L153
	sts bbb,r24
	rjmp .L93
.L153:
	lds r18,econom
	ldi r24,lo8(r)
	mov r14,r24
	ldi r24,hi8(r)
	mov r15,r24
	ldi r25,lo8(g)
	mov r12,r25
	ldi r25,hi8(g)
	mov r13,r25
	ldi r19,lo8(b)
	mov r10,r19
	ldi r19,hi8(b)
	mov r11,r19
	movw r20,r10
	movw r24,r12
	movw r30,r14
.L157:
	cpi r18,lo8(1)
	brne .L154
	ld r19,Z
	lsr r19
	lsr r19
	st Z,r19
	movw r26,r24
	ld r19,X
	lsr r19
	lsr r19
	st X,r19
	movw r26,r20
	ld r19,X
	lsr r19
	lsr r19
	rjmp .L198
.L154:
	cpi r18,lo8(2)
	brne .L156
	ld r19,Z
	swap r19
	andi r19,lo8(15)
	st Z,r19
	movw r26,r24
	ld r19,X
	swap r19
	andi r19,lo8(15)
	st X,r19
	movw r26,r20
	ld r19,X
	swap r19
	andi r19,lo8(15)
	rjmp .L198
.L156:
	cpi r18,lo8(3)
	brne .L155
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
	movw r26,r20
	ld r19,X
	swap r19
	lsr r19
	lsr r19
	andi r19,lo8(3)
.L198:
	st X,r19
.L155:
	adiw r30,1
	adiw r24,1
	subi r20,-1
	sbci r21,-1
	ldi r27,hi8(r+5)
	cpi r30,lo8(r+5)
	cpc r31,r27
	brne .L157
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r16,lo8(mask+1)
	ldi r17,hi8(mask+1)
.L160:
	movw r30,r16
	ld r24,Z+
	movw r16,r30
	tst r24
	breq .L158
	movw r26,r10
	ld r6,X
	movw r30,r12
	ld r4,Z
	movw r26,r14
	ld r5,X
	ldi r24,lo8(-1)
	rcall sendByte
	mov r24,r6
	rcall sendByte
	mov r24,r4
	rcall sendByte
	mov r24,r5
	rjmp .L199
.L158:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
.L199:
	rcall sendByte
	ldi r27,-1
	sub r10,r27
	sbc r11,r27
	ldi r30,-1
	sub r12,r30
	sbc r13,r30
	ldi r31,-1
	sub r14,r31
	sbc r15,r31
	ldi r18,lo8(mask+5)
	ldi r19,hi8(mask+5)
	cp r18,r16
	cpc r19,r17
	brne .L160
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
	inc r8
	rjmp .L94
.L202:
	ldi r24,0
.L93:
/* epilogue start */
	adiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
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
.global	const_light_legacy
	.type	const_light_legacy, @function
const_light_legacy:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	mov r29,r24
	mov r17,r22
	mov r28,r20
	rcall flush_mask
	sbrs r28,0
	rjmp .L205
	ldi r24,lo8(1)
	sts mask+1,r24
.L205:
	sbrs r28,1
	rjmp .L206
	ldi r24,lo8(1)
	sts mask+2,r24
.L206:
	sbrs r28,2
	rjmp .L207
	ldi r24,lo8(1)
	sts mask+3,r24
.L207:
	sbrs r28,3
	rjmp .L208
	ldi r24,lo8(1)
	sts mask+4,r24
.L208:
	mov r22,r17
	mov r24,r29
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	const_light_legacy, .-const_light_legacy
.global	mode_1
	.type	mode_1, @function
mode_1:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(-1)
	ldi r22,lo8(12)
	lds r24,mode
	rjmp const_light_legacy
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
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(-1)
	ldi r22,lo8(6)
	ldi r24,0
	rjmp const_light_legacy
	.size	mode_2, .-mode_2
.global	mode_3
	.type	mode_3, @function
mode_3:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(3)
	ldi r22,lo8(60)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(12)
	ldi r22,lo8(60)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_3, .-mode_3
.global	mode_4
	.type	mode_4, @function
mode_4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(30)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(2)
	ldi r22,lo8(30)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(4)
	ldi r22,lo8(30)
	lds r24,mode
	rcall const_light_legacy
	ldi r20,lo8(8)
	ldi r22,lo8(30)
	lds r24,mode
	rjmp const_light_legacy
	.size	mode_4, .-mode_4
.global	make_serie
	.type	make_serie, @function
make_serie:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L227
	brsh .L228
	cpi r24,lo8(1)
	brne .L226
	rjmp mode_1
.L228:
	cpi r24,lo8(3)
	breq .L230
	cpi r24,lo8(4)
	brne .L226
	rjmp mode_4
.L227:
	rjmp mode_2
.L230:
	rjmp mode_3
.L226:
	ldi r22,lo8(1)
	ldi r24,0
	rjmp const_light
	.size	make_serie, .-make_serie
	.section	.text.startup,"ax",@progbits
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
 ;  132 "poi-4LED-v2-1.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r28,lo8(16)
	ldi r29,lo8(32)
.L233:
	sts bbb,__zero_reg__
/* #APP */
 ;  143 "poi-4LED-v2-1.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L234
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
 ;  152 "poi-4LED-v2-1.c" 1
	sei
 ;  0 "" 2
 ;  153 "poi-4LED-v2-1.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L233
.L234:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L236
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L237
	lds r24,serie
	rcall make_serie
	rjmp .L233
.L237:
	lds r24,counter
	tst r24
	breq .L238
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
	rjmp .L233
.L238:
	ldi r24,lo8(100)
.L236:
	rcall process_signal
	rjmp .L233
	.size	main, .-main
	.local	counter.1903
	.comm	counter.1903,1,1
	.data
	.type	tmpsch.1902, @object
	.size	tmpsch.1902, 1
tmpsch.1902:
	.byte	1
	.local	rgbs.1901
	.comm	rgbs.1901,1,1
	.local	last_button_state.1769
	.comm	last_button_state.1769,1,1
	.local	hold.1767
	.comm	hold.1767,2,1
	.local	button_state.1768
	.comm	button_state.1768,1,1
.global	wave_3
	.type	wave_3, @object
	.size	wave_3, 4
wave_3:
	.byte	50
	.byte	-1
	.byte	50
	.byte	0
.global	wave_2
	.type	wave_2, @object
	.size	wave_2, 4
wave_2:
	.byte	-1
	.byte	-116
	.byte	55
	.byte	5
.global	wave_1
	.type	wave_1, @object
	.size	wave_1, 4
wave_1:
	.byte	-1
	.byte	-116
	.byte	55
	.byte	5
	.local	rgb4
	.comm	rgb4,3,1
	.local	rgb3
	.comm	rgb3,3,1
	.local	rgb2
	.comm	rgb2,3,1
	.local	rgb
	.comm	rgb,3,1
.global	bbb
	.section .bss
	.type	bbb, @object
	.size	bbb, 1
bbb:
	.zero	1
	.comm	mask,5,1
	.comm	b,4,1
	.comm	g,4,1
	.comm	r,4,1
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
	.data
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
	.section .bss
	.type	econom, @object
	.size	econom, 1
econom:
	.zero	1
	.comm	power,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.comm	pal,2,1
	.comm	scheme,8,1
	.comm	pack,8,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_copy_data
.global __do_clear_bss
