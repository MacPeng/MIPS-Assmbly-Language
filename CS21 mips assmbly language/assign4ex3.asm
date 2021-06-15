#exercise 3

	.data
msg_before: .asciiz "String before conversion"
string: .asciiz "\nin a hole in the ground there lived a hobbit"
msg_after: .asciiz "\nString after conversion"

	.text
	.globl main

main:
	la 	$a0,msg_before 
	li 	$v0,4
	syscall
	la 	$a0,string 
	li 	$v0,4
	syscall
	la 	$t0,string 
	li	$t3, 0 
loop: 
	lb 	$t1,($t0)
	nop
	beqz 	$t1,loop_end 
	beq 	$t1,0x20,next_element 
	beq	$t3, 1, next
	blt	$t1, 97, next_element
	sub 	$t1,$t1, 32 
	sb 	$t1,($t0)
	addi	$t0, $t0, 1
	j	loop
next:
	li	$t3, 1
	j	loop
next_element:
	addiu 	$t0,$t0,1 
	li	$t3, 0
	j 	loop
loop_end:
	la 	$a0,msg_after 
	li 	$v0,4
	syscall
	la 	$a0,string 
	li 	$v0,4
	syscall
	li 	$v0,10 
	syscall
