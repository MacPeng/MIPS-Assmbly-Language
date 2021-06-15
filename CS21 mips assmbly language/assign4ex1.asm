#
# assign4.asm
# Yiming Peng
# Assignment 4
# 03/24/2020
# 

	.data
		msg: .asciiz "Upper case string: "
		input: .asciiz "ABCDEFG" 
		newline: .asciiz "\nLower case String: "
	.text
	.globl main 

main:
	li	$v0, 4 			
	la	$a0, msg
	syscall
	li 	$v0, 4 			
	li 	$a1, 20
	la 	$a0, input
	syscall
	li 	$v0, 4
	li 	$t0, 0
	li 	$v0, 4 			
	li 	$a1, 20
	la 	$a0, newline
	syscall
	li	$v0, 4
	li	$t0, 0
loop:
	lb 	$t1, input($t0) 
	nop 
	beq 	$t1, 0, exit
	blt 	$t1, 'A', case
	bgt 	$t1, 'Z', case
	add 	$t1, $t1, 0x20	 
	sb 	$t1, input($t0)
	nop
case:
	addi 	$t0, $t0, 1
	j 	loop
	nop 
exit:
	li 	$v0, 4			
	la 	$a0, input
	syscall
	li 	$v0, 10
	syscall
