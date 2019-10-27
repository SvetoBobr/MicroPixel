	.file	"50-led-test.c"
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
.global	send
	.type	send, @function
send:
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
/* stack size = 11 */
.L__stack_usage = 11
	mov r16,r24
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r17,0
.L9:
	cpse r17,r16
	rjmp .L11
	ldi r28,0
	rjmp .L12
.L11:
	ldi r28,lo8(b)
	ldi r29,hi8(b)
	ldi r24,lo8(g)
	mov r12,r24
	ldi r24,hi8(g)
	mov r13,r24
	ldi r25,lo8(r)
	mov r14,r25
	ldi r25,hi8(r)
	mov r15,r25
.L10:
	ld r9,Y+
	movw r30,r12
	ld r10,Z+
	movw r12,r30
	movw r30,r14
	ld r11,Z+
	movw r14,r30
	ldi r24,lo8(-30)
	rcall sendByte
	mov r24,r9
	rcall sendByte
	mov r24,r10
	rcall sendByte
	mov r24,r11
	rcall sendByte
	ldi r31,hi8(b+40)
	cpi r28,lo8(b+40)
	cpc r29,r31
	brne .L10
	subi r17,lo8(-(1))
	rjmp .L9
.L12:
	cp r28,r16
	breq .L15
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	subi r28,lo8(-(1))
	rjmp .L12
.L15:
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
	ret
	.size	send, .-send
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall init_io
	ldi r28,lo8(10)
	ldi r29,lo8(1)
.L21:
	ldi r16,lo8(r)
	ldi r17,hi8(r)
	ldi r24,lo8(g)
	mov r10,r24
	ldi r24,hi8(g)
	mov r11,r24
	ldi r25,lo8(b)
	mov r12,r25
	ldi r25,hi8(b)
	mov r13,r25
	ldi r18,lo8(mask)
	mov r14,r18
	ldi r18,hi8(mask)
	mov r15,r18
	movw r22,r14
	movw r24,r12
	movw r18,r10
	movw r30,r16
.L17:
	st Z+,r28
	movw r26,r18
	st X+,__zero_reg__
	movw r18,r26
	movw r26,r24
	st X+,__zero_reg__
	movw r24,r26
	movw r26,r22
	st X+,r29
	movw r22,r26
	ldi r27,hi8(r+40)
	cpi r30,lo8(r+40)
	cpc r31,r27
	brne .L17
	ldi r30,lo8(b)
	ldi r31,hi8(b)
.L18:
	std Z+3,r28
	adiw r30,4
	ldi r20,hi8(b+40)
	cpi r30,lo8(b+40)
	cpc r31,r20
	brne .L18
	ldi r24,lo8(4)
	rcall send
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L19:
	st Z+,__zero_reg__
	movw r26,r10
	st X+,r28
	movw r10,r26
	movw r26,r12
	st X+,__zero_reg__
	movw r12,r26
	movw r26,r14
	st X+,r29
	movw r14,r26
	ldi r27,hi8(r+40)
	cpi r30,lo8(r+40)
	cpc r31,r27
	brne .L19
.L20:
	movw r30,r16
	std Z+3,r28
	subi r16,-4
	sbci r17,-1
	ldi r31,hi8(r+40)
	cpi r16,lo8(r+40)
	cpc r17,r31
	brne .L20
	ldi r24,lo8(4)
	rcall send
	rjmp .L21
	.size	main, .-main
	.comm	mask,41,1
	.comm	b,40,1
	.comm	g,40,1
	.comm	r,40,1
	.comm	power,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
