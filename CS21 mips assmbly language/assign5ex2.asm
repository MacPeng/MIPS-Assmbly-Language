#exercise2	
	 .data
promptt: .asciiz "Choose a number: "
result: .asciiz "Answer = "
nextline: .asciiz "\n\n"
	.text
	.globl main

main:
	li	$t0, 0

iterate:
	beq 	$t0, 10, exit
	jal 	prompt
	nop
	mov.s 	$f12, $f0
	jal 	prompt
	nop
	mov.s 	$f14, $f0
	jal 	multiply
	nop
	mov.s 	$f12, $f0
	jal 	print
	nop
	addi 	$t0, $t0, 1
	j	iterate
prompt:
	li 	$v0, 4
	la 	$a0, promptt
	syscall
	li 	$v0, 6
	syscall
	jr 	$ra
multiply:
	mov.s	$f4, $f12
	mov.s	$f5, $f14
	mul.s	$f0, $f4, $f5
	jr 	$ra
print:
	la 	$a0, result
	li 	$v0, 4
	syscall
	li 	$v0, 2
	mov.s 	$f12, $f12
	syscall
	la	$a0, nextline
	li	$v0, 4
	syscall
	jr	$ra
exit:
	li 	$v0, 10
	syscall
	
