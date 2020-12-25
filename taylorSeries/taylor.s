.text
.global main
.extern printf

 main:
 	SUB sp, sp, #16
 	STR x30, [sp]
 	ldr x8, =terms
 	ldr x9, =x
 	ldr x0, [x8] // terms
 	ldr d1, [x9] // x
 	fmov d0, #1.0 // keeps the running count of answer
 	fmov d2, #1.0 // initializes the x keeper with 1 because of multiplication
	fmov d4, #1.0 // factorial keeper
	fmov d5, #1.0 // iteration counter
	fmov d6, #1.0 // keeper for each iteration
	fmov d9, #1.0 // a 1 to use
	mov x10, #1
	bl compute
	ldr x30, [sp]
	ldr x0, =prt_str1
	add sp, sp, #16
	bl printf
	br x30
compute:
	cmp x0, #0 // if terms is 0 then done
	beq done
	cmp x10, #1
	beq store
	fmul d2, d2, d1 // for the exponent so multiplies x by the previous values
	fmul d4, d4, d5 // multiplies the iteration by the previous factorial
	fdiv d3, d2, d4
	fadd d0, d0, d3
	fadd d5, d5, d9 // adding one to the iteration counter
	sub x0, x0, #1 // subtracting one from the terms
	bl compute
done:
	ldr x30, [sp, #8]
	br x30
store:
	str x30, [sp, #8]
	add x10, x10, #1
	bl compute
 .data
terms:
	.word 6
x:
	.double 5
prt_str1:
	.ascii "The approximation is %f \n\0"

 .end
