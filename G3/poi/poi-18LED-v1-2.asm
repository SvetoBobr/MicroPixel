	.file	"poi-18LED-v1-2.c"
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
	cpi r24,lo8(20)
	brlo .L9
	ldi r24,lo8(1)
	sts mode,r24
.L9:
	lds r24,serie
	cpi r24,lo8(12)
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
	cpi r25,lo8(20)
	brlo .L11
	st Z,r24
.L11:
	ld r25,X
	cpi r25,lo8(12)
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
	cpi r24,-103
	ldi r18,58
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
	cpi r24,89
	ldi r18,27
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
	cpi r24,lo8(12)
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
	cpi r24,lo8(20)
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
	sts button_state.1777,__zero_reg__
	rjmp .L52
.L51:
	ldi r24,lo8(1)
	sts button_state.1777,r24
.L52:
	lds r22,button_state.1777
	cpi r22,lo8(1)
	brne .L53
	lds r24,hold.1776
	lds r25,hold.1776+1
	adiw r24,1
	sts hold.1776+1,r25
	sts hold.1776,r24
.L53:
	lds r24,last_button_state.1778
	cpse r22,r24
	rjmp .L56
	ldi r23,0
	lds r24,hold.1776
	lds r25,hold.1776+1
	rcall process_button
	rjmp .L54
.L56:
	ldi r24,0
.L54:
	lds r25,button_state.1777
	cpse r25,__zero_reg__
	rjmp .L55
	lds r18,last_button_state.1778
	cpse r18,__zero_reg__
	rjmp .L55
	sts hold.1776+1,__zero_reg__
	sts hold.1776,__zero_reg__
.L55:
	sts last_button_state.1778,r25
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
.L71:
	mov r25,r20
	cp r20,r24
	brsh .L74
	lds r22,pal
	lds r23,pal+1
	movw r28,r22
	ld r22,Y
	ldd r23,Y+1
	std Z+1,r23
	st Z,r22
	cpi r25,lo8(8)
	brsh .L72
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
	brne .L72
	ld r22,X+
	ld r23,X
	sbiw r26,1
	std Z+1,r23
	st Z,r22
.L72:
	subi r20,-1
	sbci r21,-1
	adiw r26,2
	adiw r30,2
	rjmp .L71
.L74:
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
.L76:
	st Z+,__zero_reg__
	ldi r24,hi8(mask+19)
	cpi r30,lo8(mask+19)
	cpc r31,r24
	brne .L76
/* epilogue start */
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
.L79:
	st Z+,r24
	ldi r25,hi8(mask+19)
	cpi r30,lo8(mask+19)
	cpc r31,r25
	brne .L79
/* epilogue start */
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
	sbiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 9 */
/* stack size = 27 */
.L__stack_usage = 27
	std Y+1,r24
	lds r24,bbb
	cpi r24,lo8(1)
	brne .+2
	rjmp .L83
	mov r7,r22
	ldd r18,Y+1
	std Y+9,r18
	mov r6,__zero_reg__
	ldi r20,lo8(-106)
	mov r5,r20
	ldi r21,lo8(wave_1+18)
	mov r2,r21
	ldi r21,hi8(wave_1+18)
	mov r3,r21
	ldi r22,lo8(r+18)
	mov r8,r22
	ldi r22,hi8(r+18)
	mov r9,r22
	mov r24,r18
	ldi r25,0
	movw r26,r24
	subi r26,lo8(-(mr))
	sbci r27,hi8(-(mr))
	std Y+4,r27
	std Y+3,r26
	movw r30,r24
	subi r30,lo8(-(mg))
	sbci r31,hi8(-(mg))
	std Y+6,r31
	std Y+5,r30
	movw r18,r24
	subi r18,lo8(-(mb))
	sbci r19,hi8(-(mb))
	std Y+8,r19
	std Y+7,r18
.L84:
	cp r6,r7
	brne .+2
	rjmp .L203
	ldd r19,Y+9
	cpi r19,lo8(8)
	brsh .L85
	ldd r26,Y+3
	ldd r27,Y+4
	ld r20,X
	ldd r30,Y+5
	ldd r31,Y+6
	ld r19,Z
	ldd r26,Y+7
	ldd r27,Y+8
	ld r18,X
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
.L86:
	st Z+,r20
	movw r26,r24
	st X+,r19
	movw r24,r26
	movw r26,r22
	st X+,r18
	movw r22,r26
	cp r8,r30
	cpc r9,r31
	brne .L86
	rjmp .L125
.L85:
	ldd r27,Y+9
	cpi r27,lo8(10)
	brne .+2
	rjmp .L89
	brsh .L90
	cpi r27,lo8(8)
	breq .L91
	cpi r27,lo8(9)
	breq .+2
	rjmp .L88
	ldi r18,lo8(r)
	ldi r19,hi8(r)
	ldi r26,lo8(g)
	ldi r27,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r24,lo8(-2)
	rjmp .L101
.L90:
	ldd r30,Y+9
	cpi r30,lo8(11)
	brne .+2
	rjmp .L93
	cpi r30,lo8(12)
	breq .+2
	rjmp .L88
	lds r24,rgb2
	lds r25,rgb2+1
	lds r20,rgb2+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	rjmp .L104
.L91:
	ldi r18,lo8(r)
	ldi r19,hi8(r)
	ldi r26,lo8(g)
	ldi r27,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r24,lo8(-2)
.L97:
	cpi r24,lo8(14)
	brlo .L95
	ldi r22,lo8(-1)
	movw r30,r18
	st Z,r22
	st X,r22
	rjmp .L191
.L95:
	movw r30,r18
	st Z,__zero_reg__
	ldi r31,lo8(-1)
	st X,r31
.L191:
	movw r30,r20
	st Z,__zero_reg__
	subi r24,lo8(-(1))
	subi r18,-1
	sbci r19,-1
	adiw r26,1
	subi r20,-1
	sbci r21,-1
	cpi r24,lo8(16)
	brne .L97
	rjmp .L125
.L99:
	movw r30,r18
	st Z,__zero_reg__
	st X,__zero_reg__
	ldi r22,lo8(-1)
	movw r30,r20
	st Z,r22
.L100:
	subi r24,lo8(-(1))
	subi r18,-1
	sbci r19,-1
	adiw r26,1
	subi r20,-1
	sbci r21,-1
	cpi r24,lo8(16)
	brne .+2
	rjmp .L125
.L101:
	cpi r24,lo8(14)
	brlo .L99
	ldi r22,lo8(-1)
	movw r30,r18
	st Z,r22
	st X,__zero_reg__
	movw r30,r20
	st Z,__zero_reg__
	rjmp .L100
.L89:
	ldi r24,lo8(r)
	ldi r25,hi8(r)
	ldi r26,lo8(g)
	ldi r27,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r18,lo8(6)
.L102:
	movw r30,r24
	st Z,r5
	std Z+6,__zero_reg__
	ldi r19,lo8(-1)
	std Z+12,r19
	st X,r5
	adiw r26,6
	st X,__zero_reg__
	sbiw r26,6
	adiw r26,12
	st X,__zero_reg__
	sbiw r26,12
	movw r30,r20
	st Z,r5
	std Z+6,r19
	std Z+12,__zero_reg__
	subi r18,lo8(-(-1))
	adiw r24,1
	adiw r26,1
	subi r20,-1
	sbci r21,-1
	cpse r18,__zero_reg__
	rjmp .L102
	rjmp .L125
.L93:
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r20,lo8(b)
	ldi r21,hi8(b)
.L103:
	ldi r18,lo8(-1)
	st Z,r18
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	movw r26,r24
	st X,__zero_reg__
	adiw r26,1
	st X,__zero_reg__
	sbiw r26,1
	adiw r26,2
	st X,r18
	movw r26,r20
	st X,__zero_reg__
	adiw r26,1
	st X,r18
	sbiw r26,1
	adiw r26,2
	st X,__zero_reg__
	adiw r30,3
	adiw r24,3
	subi r20,-3
	sbci r21,-1
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L103
	rjmp .L125
.L104:
	st Z+,r24
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r20
	movw r22,r26
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L104
	lds r18,rgbs.1972
	cpse r18,__zero_reg__
	rjmp .L105
	subi r25,lo8(-(1))
	sts rgb2+1,r25
	subi r24,lo8(-(-1))
	sts rgb2,r24
	rjmp .L193
.L105:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L125
	subi r25,lo8(-(-1))
	sts rgb2+1,r25
	subi r24,lo8(-(1))
	sts rgb2,r24
	rjmp .L196
.L88:
	ldd r30,Y+9
	cpi r30,lo8(14)
	brne .+2
	rjmp .L108
	brsh .L109
	cpi r30,lo8(13)
	breq .+2
	rjmp .L107
	lds r24,rgb3
	lds r20,rgb3+1
	lds r25,rgb3+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
	rjmp .L113
.L109:
	ldd r31,Y+9
	cpi r31,lo8(15)
	brne .+2
	rjmp .L111
	cpi r31,lo8(16)
	breq .+2
	rjmp .L107
	lds r24,tmpsch.1973
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
	rjmp .L123
.L113:
	st Z+,r24
	movw r26,r18
	st X+,r20
	movw r18,r26
	movw r26,r22
	st X+,r25
	movw r22,r26
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L113
	lds r18,rgbs.1972
	cpse r18,__zero_reg__
	rjmp .L114
	subi r25,lo8(-(1))
	sts rgb3+2,r25
	subi r24,lo8(-(-1))
	sts rgb3,r24
.L193:
	cpi r25,lo8(-1)
	breq .+2
	rjmp .L125
	ldi r24,lo8(1)
	rjmp .L197
.L114:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L125
	subi r25,lo8(-(-1))
	sts rgb3+2,r25
	subi r24,lo8(-(1))
	sts rgb3,r24
.L196:
	cpi r24,lo8(-1)
	breq .+2
	rjmp .L125
.L119:
	sts rgbs.1972,__zero_reg__
	rjmp .L125
.L108:
	lds r20,rgb4
	lds r25,rgb4+1
	lds r24,rgb4+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
.L116:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r24
	movw r22,r26
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L116
	lds r18,rgbs.1972
	cpse r18,__zero_reg__
	rjmp .L117
	subi r25,lo8(-(1))
	sts rgb4+1,r25
	subi r24,lo8(-(-1))
	sts rgb4+2,r24
	rjmp .L193
.L117:
	cpi r18,lo8(1)
	breq .+2
	rjmp .L125
	subi r25,lo8(-(-1))
	sts rgb4+1,r25
	subi r24,lo8(-(1))
	sts rgb4+2,r24
	rjmp .L196
.L111:
	lds r20,rgb
	lds r25,rgb+1
	lds r24,rgb+2
	ldi r30,lo8(r)
	ldi r31,hi8(r)
	ldi r18,lo8(g)
	ldi r19,hi8(g)
	ldi r22,lo8(b)
	ldi r23,hi8(b)
.L120:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r22
	st X+,r24
	movw r22,r26
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L120
	lds r18,rgbs.1972
	cpse r18,__zero_reg__
	rjmp .L121
	subi r25,lo8(-(1))
	sts rgb+1,r25
	subi r20,lo8(-(-1))
	sts rgb,r20
	rjmp .L193
.L121:
	cpi r18,lo8(1)
	brne .L122
	subi r24,lo8(-(1))
	sts rgb+2,r24
	subi r25,lo8(-(-1))
	sts rgb+1,r25
	cpi r24,lo8(-1)
	breq .+2
	rjmp .L125
	ldi r24,lo8(2)
.L197:
	sts rgbs.1972,r24
	rjmp .L125
.L122:
	cpi r18,lo8(2)
	breq .+2
	rjmp .L119
	subi r24,lo8(-(-1))
	sts rgb+2,r24
	subi r20,lo8(-(1))
	sts rgb,r20
	tst r24
	brne .+2
	rjmp .L119
	rjmp .L125
.L123:
	st Z+,r20
	movw r26,r18
	st X+,r25
	movw r18,r26
	movw r26,r16
	st X+,r21
	movw r16,r26
	ldi r27,hi8(r+18)
	cpi r30,lo8(r+18)
	cpc r31,r27
	brne .L123
	subi r24,lo8(-(1))
	cpi r24,lo8(9)
	brlo .L198
	ldi r24,lo8(1)
.L198:
	sts tmpsch.1973,r24
	rjmp .L125
.L107:
	ldd r30,Y+9
	cpi r30,lo8(18)
	brne .+2
	rjmp .L126
	cpi r30,lo8(19)
	brne .+2
	rjmp .L127
	cpi r30,lo8(17)
	breq .+2
	rjmp .L125
	lds r24,counter.1974
	subi r24,lo8(-(1))
	cpi r24,lo8(30)
	brsh .L129
	sts counter.1974,r24
	rjmp .L130
.L129:
	sts counter.1974,__zero_reg__
	lds r24,wave_1
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
.L131:
	ldd r25,Z+1
	st Z+,r25
	ldi r18,hi8(wave_1+17)
	cpi r30,lo8(wave_1+17)
	cpc r31,r18
	brne .L131
	sts wave_1+17,r24
	lds r24,wave_2+17
	ldi r30,lo8(wave_2+17)
	ldi r31,hi8(wave_2+17)
.L132:
	ld r25,-Z
	std Z+1,r25
	ldi r26,lo8(wave_2)
	ldi r27,hi8(wave_2)
	cp r26,r30
	cpc r27,r31
	brne .L132
	sts wave_2,r24
.L130:
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
.L133:
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
	brne .L133
	rjmp .L125
.L126:
	lds r24,counter.1974
	subi r24,lo8(-(1))
	cpi r24,lo8(30)
	brsh .L134
	sts counter.1974,r24
	rjmp .L135
.L134:
	sts counter.1974,__zero_reg__
	lds r24,wave_1
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
.L136:
	ldd r25,Z+1
	st Z+,r25
	ldi r18,lo8(wave_1+17)
	ldi r19,hi8(wave_1+17)
	cp r18,r30
	cpc r19,r31
	brne .L136
	sts wave_1+17,r24
	lds r24,wave_2+17
	ldi r30,lo8(wave_2+17)
	ldi r31,hi8(wave_2+17)
.L137:
	ld r25,-Z
	std Z+1,r25
	ldi r26,lo8(wave_2)
	ldi r27,hi8(wave_2)
	cp r26,r30
	cpc r27,r31
	brne .L137
	sts wave_2,r24
.L135:
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
.L138:
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
	cp r2,r30
	cpc r3,r31
	brne .L138
	rjmp .L125
.L127:
	lds r24,counter.1974
	subi r24,lo8(-(1))
	cpi r24,lo8(30)
	brsh .L139
	sts counter.1974,r24
	rjmp .L140
.L139:
	sts counter.1974,__zero_reg__
	lds r24,wave_1
	ldi r30,lo8(wave_1)
	ldi r31,hi8(wave_1)
.L141:
	ldd r25,Z+1
	st Z+,r25
	ldi r18,lo8(wave_1+17)
	ldi r19,hi8(wave_1+17)
	cp r18,r30
	cpc r19,r31
	brne .L141
	sts wave_1+17,r24
	lds r24,wave_2+17
	ldi r30,lo8(wave_2+17)
	ldi r31,hi8(wave_2+17)
.L142:
	ld r25,-Z
	std Z+1,r25
	ldi r19,hi8(wave_2)
	cpi r30,lo8(wave_2)
	cpc r31,r19
	brne .L142
	sts wave_2,r24
.L140:
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
.L143:
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
	cp r8,r30
	cpc r9,r31
	brne .L143
.L125:
	rcall check_button
	cpi r24,lo8(1)
	brne .L144
	sts bbb,r24
	rjmp .L83
.L144:
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
.L148:
	cpi r18,lo8(1)
	brne .L145
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
	rjmp .L199
.L145:
	cpi r18,lo8(2)
	brne .L147
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
	rjmp .L199
.L147:
	cpi r18,lo8(3)
	brne .L146
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
.L199:
	st X,r19
.L146:
	adiw r30,1
	adiw r24,1
	subi r20,-1
	sbci r21,-1
	ldi r27,hi8(r+19)
	cpi r30,lo8(r+19)
	cpc r31,r27
	brne .L148
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
.L151:
	movw r30,r16
	ld r24,Z+
	movw r16,r30
	tst r24
	breq .L149
	movw r26,r10
	ld r27,X
	std Y+1,r27
	movw r30,r12
	ld r31,Z
	std Y+2,r31
	movw r26,r14
	ld r4,X
	ldi r24,lo8(-1)
	rcall sendByte
	ldd r24,Y+1
	rcall sendByte
	ldd r24,Y+2
	rcall sendByte
	mov r24,r4
	rjmp .L200
.L149:
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
.L200:
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
	ldi r18,lo8(mask+19)
	ldi r19,hi8(mask+19)
	cp r18,r16
	cpc r19,r17
	brne .L151
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	inc r6
	rjmp .L84
.L203:
	ldi r24,0
.L83:
/* epilogue start */
	adiw r28,9
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
.global	mode_1
	.type	mode_1, @function
mode_1:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall fill_mask
	ldi r22,lo8(10)
	lds r24,mode
	rjmp const_light
	.size	mode_1, .-mode_1
.global	mode_2
	.type	mode_2, @function
mode_2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall fill_mask
	ldi r22,lo8(10)
	lds r24,mode
	rcall const_light
	ldi r22,lo8(10)
	ldi r24,0
	rjmp const_light
	.size	mode_2, .-mode_2
.global	mode_3
	.type	mode_3, @function
mode_3:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	movw r30,r28
	ldi r24,lo8(1)
	ldi r25,lo8(1)
.L209:
	cpi r24,lo8(10)
	brsh .L207
	std Z+1,r25
	rjmp .L208
.L207:
	std Z+1,__zero_reg__
.L208:
	subi r24,lo8(-(1))
	adiw r30,1
	cpi r24,lo8(19)
	brne .L209
	ldi r22,lo8(10)
	lds r24,mode
	rcall const_light
	ldi r24,lo8(1)
	ldi r25,lo8(1)
.L212:
	cpi r24,lo8(10)
	brsh .L210
	std Y+1,__zero_reg__
	rjmp .L211
.L210:
	std Y+1,r25
.L211:
	subi r24,lo8(-(1))
	adiw r28,1
	cpi r24,lo8(19)
	brne .L212
	ldi r22,lo8(10)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	rjmp const_light
	.size	mode_3, .-mode_3
.global	mode_4
	.type	mode_4, @function
mode_4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,a.1860
	lds r25,a.1860+1
	ldi r18,lo8(18)
	ldi r19,0
	sub r18,r24
	sbc r19,r25
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	ldi r24,lo8(1)
	ldi r25,0
	ldi r21,lo8(1)
.L219:
	cpi r24,lo8(1)
	breq .L216
	cp r18,r24
	cpc r19,r25
	breq .L216
	cpi r24,lo8(18)
	brne .L217
.L216:
	st Z,r21
	rjmp .L218
.L217:
	st Z,__zero_reg__
.L218:
	adiw r30,1
	adiw r24,1
	cpi r24,19
	cpc r25,__zero_reg__
	brne .L219
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1860
	lds r25,a.1860+1
	adiw r24,1
	cpi r24,19
	cpc r25,__zero_reg__
	brsh .L220
	sts a.1860+1,r25
	sts a.1860,r24
	ret
.L220:
	sts a.1860+1,__zero_reg__
	sts a.1860,__zero_reg__
	ret
	.size	mode_4, .-mode_4
.global	mode_5
	.type	mode_5, @function
mode_5:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,a.1867
	lds r19,a.1867+1
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	ldi r24,lo8(1)
	ldi r25,0
	ldi r20,lo8(1)
.L230:
	cp r18,r24
	cpc r19,r25
	brsh .L227
	cpi r24,lo8(18)
	brne .L228
.L227:
	st Z,r20
	rjmp .L229
.L228:
	st Z,__zero_reg__
.L229:
	adiw r24,1
	adiw r30,1
	cpi r24,19
	cpc r25,__zero_reg__
	brne .L230
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1867
	lds r25,a.1867+1
	adiw r24,1
	cpi r24,19
	cpc r25,__zero_reg__
	brsh .L231
	sts a.1867+1,r25
	sts a.1867,r24
	ret
.L231:
	sts a.1867+1,__zero_reg__
	sts a.1867,__zero_reg__
	ret
	.size	mode_5, .-mode_5
.global	mode_6
	.type	mode_6, @function
mode_6:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,a.1874
	lds r25,a.1874+1
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	subi r24,lo8(mask)
	sbci r25,hi8(mask)
	ldi r18,lo8(1)
.L237:
	movw r20,r24
	add r20,r30
	adc r21,r31
	sbrs r20,1
	rjmp .L235
	st Z,r18
	rjmp .L236
.L235:
	st Z,__zero_reg__
.L236:
	adiw r30,1
	ldi r19,hi8(mask+19)
	cpi r30,lo8(mask+19)
	cpc r31,r19
	brne .L237
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1874
	lds r25,a.1874+1
	adiw r24,2
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L238
	sts a.1874+1,r25
	sts a.1874,r24
	ret
.L238:
	sts a.1874+1,__zero_reg__
	sts a.1874,__zero_reg__
	ret
	.size	mode_6, .-mode_6
.global	mode_7
	.type	mode_7, @function
mode_7:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r20,a.1881
	lds r21,a.1881+1
	ldi r18,lo8(19)
	ldi r19,0
	sub r18,r20
	sbc r19,r21
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	ldi r24,lo8(1)
	ldi r25,0
	ldi r23,lo8(1)
.L246:
	cp r20,r24
	cpc r21,r25
	brsh .L242
	cp r24,r18
	cpc r25,r19
	brlo .L243
.L242:
	cpi r24,lo8(1)
	breq .L243
	cpi r24,lo8(18)
	brne .L244
.L243:
	st Z,r23
	rjmp .L245
.L244:
	st Z,__zero_reg__
.L245:
	adiw r24,1
	adiw r30,1
	cpi r24,19
	cpc r25,__zero_reg__
	brne .L246
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1881
	lds r25,a.1881+1
	adiw r24,1
	cpi r24,9
	cpc r25,__zero_reg__
	brsh .L247
	sts a.1881+1,r25
	sts a.1881,r24
	ret
.L247:
	sts a.1881+1,__zero_reg__
	sts a.1881,__zero_reg__
	ret
	.size	mode_7, .-mode_7
.global	mode_8
	.type	mode_8, @function
mode_8:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,a.1888
	lds r19,a.1888+1
	ldi r30,lo8(mask+1)
	ldi r31,hi8(mask+1)
	ldi r24,lo8(1)
	subi r18,lo8(mask)
	sbci r19,hi8(mask)
	ldi r25,lo8(1)
.L257:
	movw r20,r18
	add r20,r30
	adc r21,r31
	sbrc r20,1
	rjmp .L254
	cpi r24,lo8(1)
	breq .L254
	cpi r24,lo8(18)
	brne .L255
.L254:
	st Z,r25
	rjmp .L256
.L255:
	st Z,__zero_reg__
.L256:
	subi r24,lo8(-(1))
	adiw r30,1
	cpi r24,lo8(19)
	brne .L257
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	lds r24,a.1888
	lds r25,a.1888+1
	adiw r24,1
	cpi r24,19
	cpc r25,__zero_reg__
	brsh .L258
	sts a.1888+1,r25
	sts a.1888,r24
	ret
.L258:
	sts a.1888+1,__zero_reg__
	sts a.1888,__zero_reg__
	ret
	.size	mode_8, .-mode_8
.global	_S
	.type	_S, @function
_S:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+16,r17
	std Y+6,r17
	std Y+5,r17
	std Y+4,r17
	std Y+3,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+17,r17
	std Y+7,r17
	std Y+2,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+8,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+9,r17
	std Y+1,r17
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+10,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+11,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+12,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+16,r17
	std Y+15,r17
	std Y+14,r17
	std Y+13,r17
	std Y+3,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_S, .-_S
.global	_V
	.type	_V, @function
_V:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+4,r17
	std Y+3,r17
	std Y+2,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+8,r17
	std Y+7,r17
	std Y+6,r17
	std Y+5,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+12,r17
	std Y+11,r17
	std Y+10,r17
	std Y+9,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+16,r17
	std Y+15,r17
	std Y+14,r17
	std Y+13,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+17,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+16,r17
	std Y+15,r17
	std Y+14,r17
	std Y+13,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+12,r17
	std Y+11,r17
	std Y+10,r17
	std Y+9,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+8,r17
	std Y+7,r17
	std Y+6,r17
	std Y+5,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+4,r17
	std Y+3,r17
	std Y+2,r17
	std Y+1,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_V, .-_V
.global	_E
	.type	_E, @function
_E:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall fill_mask
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	ldi r24,lo8(1)
	std Z+18,r24
	std Z+8,r24
	std Z+1,r24
	ldi r22,lo8(15)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
	rjmp const_light
	.size	_E, .-_E
.global	_T
	.type	_T, @function
_T:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+1,r17
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light
	rcall fill_mask
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+1,r17
	ldi r22,lo8(6)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_T, .-_T
.global	_O
	.type	_O, @function
_O:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+14,r17
	std Y+13,r17
	std Y+12,r17
	std Y+11,r17
	std Y+10,r17
	std Y+9,r17
	std Y+8,r17
	std Y+7,r17
	std Y+6,r17
	std Y+5,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+16,r17
	std Y+15,r17
	std Y+4,r17
	std Y+3,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+17,r17
	std Y+2,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+18,r17
	std Y+1,r17
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+17,r17
	std Y+2,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+16,r17
	std Y+15,r17
	std Y+4,r17
	std Y+3,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+14,r17
	std Y+13,r17
	std Y+12,r17
	std Y+11,r17
	std Y+10,r17
	std Y+9,r17
	std Y+8,r17
	std Y+7,r17
	std Y+6,r17
	std Y+5,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_O, .-_O
.global	_B
	.type	_B, @function
_B:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall fill_mask
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+18,r17
	std Y+9,r17
	std Y+1,r17
	ldi r22,lo8(4)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+17,r17
	std Y+10,r17
	std Y+8,r17
	std Y+2,r17
	ldi r22,lo8(2)
	lds r24,mode
	rcall const_light
	rcall fill_mask
	std Y+18,__zero_reg__
	std Y+17,__zero_reg__
	std Y+10,__zero_reg__
	std Y+9,__zero_reg__
	std Y+8,__zero_reg__
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_B, .-_B
.global	_R
	.type	_R, @function
_R:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	rcall fill_mask
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r28,lo8(mask)
	ldi r29,hi8(mask)
	ldi r17,lo8(1)
	std Y+18,r17
	std Y+9,r17
	std Y+1,r17
	ldi r22,lo8(3)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+11,r17
	std Y+10,r17
	std Y+8,r17
	std Y+2,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+13,r17
	std Y+12,r17
	std Y+8,r17
	std Y+2,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	std Y+7,r17
	std Y+6,r17
	std Y+5,r17
	std Y+4,r17
	std Y+3,r17
	std Y+18,r17
	std Y+17,r17
	std Y+16,r17
	std Y+15,r17
	std Y+14,r17
	ldi r22,lo8(1)
	lds r24,mode
	rcall const_light
	rcall flush_mask
	ldi r22,lo8(4)
	lds r24,mode
/* epilogue start */
	pop r29
	pop r28
	pop r17
	rjmp const_light
	.size	_R, .-_R
.global	blank
	.type	blank, @function
blank:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall flush_mask
	ldi r22,lo8(15)
	lds r24,mode
	rjmp const_light
	.size	blank, .-blank
.global	svetobobr
	.type	svetobobr, @function
svetobobr:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall _S
	rcall _V
	rcall _E
	rcall _T
	rcall _O
	rcall _B
	rcall _O
	rcall _B
	rcall _R
	rjmp blank
	.size	svetobobr, .-svetobobr
.global	binary
	.type	binary, @function
binary:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,a.1913
	lds r19,a.1913+1
	ldi r30,lo8(mask)
	ldi r31,hi8(mask)
	ldi r24,lo8(1)
	ldi r25,0
	ldi r20,lo8(1)
.L276:
	movw r22,r18
	and r22,r24
	and r23,r25
	or r22,r23
	breq .L274
	std Z+1,r20
	rjmp .L275
.L274:
	std Z+1,__zero_reg__
.L275:
	adiw r24,1
	adiw r30,1
	cpi r24,19
	cpc r25,__zero_reg__
	brne .L276
	ldi r22,lo8(10)
	lds r24,mode
	rcall const_light
	lds r24,a.1913
	lds r25,a.1913+1
	adiw r24,1
	cpi r24,19
	cpc r25,__zero_reg__
	brsh .L277
	sts a.1913+1,r25
	sts a.1913,r24
	ret
.L277:
	sts a.1913+1,__zero_reg__
	sts a.1913,__zero_reg__
	ret
	.size	binary, .-binary
.global	demo
	.type	demo, @function
demo:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r29,mode
	lds r24,dm.1921
	sts mode,r24
	lds r28,serie
	lds r24,ds.1920
	sts serie,r24
	cpi r24,lo8(2)
	breq .L282
	brsh .L283
	cpi r24,lo8(1)
	brne .L281
	rcall mode_1
	rjmp .L281
.L283:
	cpi r24,lo8(3)
	breq .L285
	cpi r24,lo8(4)
	brne .L281
	rcall mode_4
	rjmp .L281
.L282:
	rcall mode_2
	rjmp .L281
.L285:
	rcall mode_3
.L281:
	lds r24,serie
	cpi r24,lo8(6)
	breq .L288
	brsh .L289
	cpi r24,lo8(5)
	brne .L287
	rcall mode_5
	rjmp .L287
.L289:
	cpi r24,lo8(7)
	breq .L291
	cpi r24,lo8(8)
	brne .L287
	rcall mode_8
	rjmp .L287
.L288:
	rcall mode_6
	rjmp .L287
.L291:
	rcall mode_7
.L287:
	lds r24,serie
	cpi r24,lo8(10)
	breq .L294
	cpi r24,lo8(11)
	breq .L295
	cpi r24,lo8(9)
	brne .L293
	rcall svetobobr
	rjmp .L293
.L294:
	rcall binary
	rjmp .L293
.L295:
	rcall demo
.L293:
	sts mode,r29
	sts serie,r28
	lds r24,dm.1921
	subi r24,lo8(-(1))
	cpi r24,lo8(13)
	brsh .L297
	sts dm.1921,r24
	rjmp .L280
.L297:
	ldi r25,lo8(1)
	sts dm.1921,r25
	lds r24,ds.1920
	subi r24,lo8(-(1))
	cpi r24,lo8(9)
	brsh .L299
	sts ds.1920,r24
	rjmp .L280
.L299:
	sts ds.1920,r25
.L280:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	demo, .-demo
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
 ;  132 "poi-18LED-v1-2.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r28,lo8(16)
	ldi r29,lo8(32)
.L302:
	sts bbb,__zero_reg__
/* #APP */
 ;  138 "poi-18LED-v1-2.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L304
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
 ;  147 "poi-18LED-v1-2.c" 1
	sei
 ;  0 "" 2
 ;  148 "poi-18LED-v1-2.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L302
.L304:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L305
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L306
	lds r24,serie
	cpi r24,lo8(2)
	breq .L308
	brsh .L309
	cpi r24,lo8(1)
	brne .L307
	rcall mode_1
	rjmp .L307
.L309:
	cpi r24,lo8(3)
	breq .L311
	cpi r24,lo8(4)
	brne .L307
	rcall mode_4
	rjmp .L307
.L308:
	rcall mode_2
	rjmp .L307
.L311:
	rcall mode_3
.L307:
	lds r24,serie
	cpi r24,lo8(6)
	breq .L314
	brsh .L315
	cpi r24,lo8(5)
	brne .L313
	rcall mode_5
	rjmp .L313
.L315:
	cpi r24,lo8(7)
	breq .L317
	cpi r24,lo8(8)
	brne .L313
	rcall mode_8
	rjmp .L313
.L314:
	rcall mode_6
	rjmp .L313
.L317:
	rcall mode_7
.L313:
	lds r24,serie
	cpi r24,lo8(10)
	breq .L319
	cpi r24,lo8(11)
	breq .L320
	cpi r24,lo8(9)
	breq .+2
	rjmp .L302
	rcall svetobobr
	rjmp .L302
.L319:
	rcall binary
	rjmp .L302
.L320:
	rcall demo
	rjmp .L302
.L306:
	lds r24,counter
	tst r24
	brne .+2
	rjmp .L322
	lds r16,mode
	lds r17,serie
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
	sts serie,r24
	cpi r24,lo8(2)
	breq .L324
	brsh .L325
	cpi r24,lo8(1)
	brne .L323
	rcall mode_1
	rjmp .L323
.L325:
	cpi r24,lo8(3)
	breq .L327
	cpi r24,lo8(4)
	brne .L323
	rcall mode_4
	rjmp .L323
.L324:
	rcall mode_2
	rjmp .L323
.L327:
	rcall mode_3
.L323:
	lds r24,serie
	cpi r24,lo8(6)
	breq .L330
	brsh .L331
	cpi r24,lo8(5)
	brne .L329
	rcall mode_5
	rjmp .L329
.L331:
	cpi r24,lo8(7)
	breq .L333
	cpi r24,lo8(8)
	brne .L329
	rcall mode_8
	rjmp .L329
.L330:
	rcall mode_6
	rjmp .L329
.L333:
	rcall mode_7
.L329:
	lds r24,serie
	cpi r24,lo8(10)
	breq .L336
	cpi r24,lo8(11)
	breq .L337
	cpi r24,lo8(9)
	brne .L335
	rcall svetobobr
	rjmp .L335
.L336:
	rcall binary
	rjmp .L335
.L337:
	rcall demo
.L335:
	sts mode,r16
	sts serie,r17
	rjmp .L302
.L322:
	ldi r24,lo8(100)
.L305:
	rcall process_signal
	rjmp .L302
	.size	main, .-main
	.local	counter.1974
	.comm	counter.1974,1,1
	.data
	.type	tmpsch.1973, @object
	.size	tmpsch.1973, 1
tmpsch.1973:
	.byte	1
	.local	rgbs.1972
	.comm	rgbs.1972,1,1
	.type	ds.1920, @object
	.size	ds.1920, 1
ds.1920:
	.byte	1
	.type	dm.1921, @object
	.size	dm.1921, 1
dm.1921:
	.byte	1
	.local	a.1913
	.comm	a.1913,2,1
	.local	a.1888
	.comm	a.1888,2,1
	.local	a.1881
	.comm	a.1881,2,1
	.local	a.1874
	.comm	a.1874,2,1
	.local	a.1867
	.comm	a.1867,2,1
	.local	a.1860
	.comm	a.1860,2,1
	.local	last_button_state.1778
	.comm	last_button_state.1778,1,1
	.local	hold.1776
	.comm	hold.1776,2,1
	.local	button_state.1777
	.comm	button_state.1777,1,1
.global	wave_2
	.type	wave_2, @object
	.size	wave_2, 18
wave_2:
	.byte	-1
	.byte	-56
	.byte	-106
	.byte	105
	.byte	60
	.byte	40
	.byte	20
	.byte	10
	.byte	5
	.byte	5
	.byte	10
	.byte	20
	.byte	40
	.byte	60
	.byte	105
	.byte	-106
	.byte	-56
	.byte	-1
.global	wave_1
	.type	wave_1, @object
	.size	wave_1, 18
wave_1:
	.byte	-1
	.byte	-56
	.byte	-106
	.byte	105
	.byte	60
	.byte	40
	.byte	20
	.byte	10
	.byte	5
	.byte	5
	.byte	10
	.byte	20
	.byte	40
	.byte	60
	.byte	105
	.byte	-106
	.byte	-56
	.byte	-1
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
	.comm	mask,19,1
	.comm	b,18,1
	.comm	g,18,1
	.comm	r,18,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_copy_data
.global __do_clear_bss
