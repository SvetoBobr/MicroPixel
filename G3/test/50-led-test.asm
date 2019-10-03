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
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
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
/* stack size = 9 */
.L__stack_usage = 9
	rcall init_io
	ldi r22,lo8(10)
	mov r3,r22
	clr r2
	inc r2
.L19:
	ldi r20,lo8(r)
	mov r6,r20
	ldi r20,hi8(r)
	mov r7,r20
	ldi r21,lo8(g)
	mov r8,r21
	ldi r21,hi8(g)
	mov r9,r21
	ldi r24,lo8(b)
	ldi r25,hi8(b)
	std Y+7,r25
	std Y+6,r24
	ldi r26,lo8(mask)
	ldi r27,hi8(mask)
	std Y+2,r27
	std Y+1,r26
	movw r22,r26
	movw r18,r8
	movw r30,r6
.L9:
	st Z+,r3
	movw r26,r18
	st X+,__zero_reg__
	movw r18,r26
	movw r26,r24
	st X+,__zero_reg__
	movw r24,r26
	movw r26,r22
	st X+,r2
	movw r22,r26
	ldi r27,hi8(r+60)
	cpi r30,lo8(r+60)
	cpc r31,r27
	brne .L9
	ldi r30,lo8(b)
	ldi r31,hi8(b)
.L10:
	std Z+3,r3
	adiw r30,4
	ldi r18,hi8(b+60)
	cpi r30,lo8(b+60)
	cpc r31,r18
	brne .L10
	ldi r20,lo8(1)
	sts mask+60,r20
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,lo8(mask+1)
	mov r4,r24
	ldi r24,hi8(mask+1)
	mov r5,r24
	ldi r25,lo8(r)
	mov r14,r25
	ldi r25,hi8(r)
	mov r15,r25
	ldi r18,lo8(g)
	mov r12,r18
	ldi r18,hi8(g)
	mov r13,r18
	ldi r19,lo8(b)
	mov r10,r19
	ldi r19,hi8(b)
	mov r11,r19
	movw r16,r4
.L13:
	movw r26,r16
	ld r24,X+
	movw r16,r26
	tst r24
	breq .L11
	movw r30,r10
	ld r31,Z
	std Y+3,r31
	movw r26,r12
	ld r27,X
	std Y+4,r27
	movw r30,r14
	ld r31,Z
	std Y+5,r31
	ldi r24,lo8(-30)
	rcall sendByte
	ldd r24,Y+3
	rcall sendByte
	ldd r24,Y+4
	rcall sendByte
	ldd r24,Y+5
	rjmp .L26
.L11:
	ldi r24,lo8(-30)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
.L26:
	rcall sendByte
	ldi r18,-1
	sub r10,r18
	sbc r11,r18
	ldi r20,-1
	sub r12,r20
	sbc r13,r20
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	ldi r25,hi8(mask+61)
	cpi r16,lo8(mask+61)
	cpc r17,r25
	brne .L13
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r20,lo8(b)
	ldi r21,hi8(b)
	ldi r24,lo8(g)
	ldi r25,hi8(g)
	ldi r30,lo8(r)
	ldi r31,hi8(r)
.L14:
	st Z+,__zero_reg__
	movw r26,r24
	st X+,r3
	movw r24,r26
	movw r26,r20
	st X+,__zero_reg__
	movw r20,r26
	ldd r26,Y+1
	ldd r27,Y+2
	st X+,r2
	std Y+2,r27
	std Y+1,r26
	ldi r27,hi8(r+60)
	cpi r30,lo8(r+60)
	cpc r31,r27
	brne .L14
	ldi r30,lo8(b)
	ldi r31,hi8(b)
.L15:
	std Z+3,r3
	adiw r30,4
	ldi r24,lo8(b+60)
	ldi r25,hi8(b+60)
	cp r24,r30
	cpc r25,r31
	brne .L15
	ldi r25,lo8(1)
	sts mask+60,r25
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
.L18:
	movw r26,r4
	ld r24,X+
	movw r4,r26
	tst r24
	breq .L16
	ldd r30,Y+6
	ldd r31,Y+7
	ld r15,Z
	movw r26,r8
	ld r16,X
	movw r30,r6
	ld r17,Z
	ldi r24,lo8(-30)
	rcall sendByte
	mov r24,r15
	rcall sendByte
	mov r24,r16
	rcall sendByte
	mov r24,r17
	rjmp .L27
.L16:
	ldi r24,lo8(-30)
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
	rcall sendByte
	ldi r24,0
.L27:
	rcall sendByte
	ldd r24,Y+6
	ldd r25,Y+7
	adiw r24,1
	std Y+7,r25
	std Y+6,r24
	ldi r25,-1
	sub r8,r25
	sbc r9,r25
	ldi r26,-1
	sub r6,r26
	sbc r7,r26
	ldi r27,lo8(mask+61)
	cp r4,r27
	ldi r27,hi8(mask+61)
	cpc r5,r27
	brne .L18
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	ldi r24,lo8(-1)
	rcall sendByte
	rjmp .L19
	.size	main, .-main
	.comm	mask,61,1
	.comm	b,60,1
	.comm	g,60,1
	.comm	r,60,1
	.comm	power,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
