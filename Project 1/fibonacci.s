.text
.global main
.extern printf

main:
	.global fiboStart
fiboStart:
	mov x0, #1 //current
	mov x1, #0 //previous
	ldr x8, =nth
	ldr x2, [x8]
	.global fibo
fibo:
	sub sp, sp, #16 //only increments of 16
	str x0, [sp, #0]
	subs x10, x2, #1
	cbnz x10, L1
	ldr x1, [sp, #0]
	ldr x0, =prt_str
	bl printf
	add sp, sp, #16
	br x30
L1:
	sub x2, x2, #1
	add x19, x0, x1
	add x1, xzr, x0
	mov x0, x19
	bl fibo

	.data
nth:
	.quad 10
stack:
	.space 32
prt_str:
	.ascii "The fibonacci number is %d \n\0"
	.end
