#
# assign7.asm
# Yiming Peng
# Assignment 7
# 04/14/2020
#

	.data
prompt1: .asciiz "Input1: "
prompt2: .asciiz "Input2: "
prompt3: .asciiz "Output: "
prompt4: .asciiz "Check: "
newLine:	.asciiz"\n"
	.text
main:
	li	$v0, 4
	la 	$a0, prompt1
	syscall
	li 	$v0, 5   
	syscall   
	move 	$t0, $v0

	li 	$v0, 4
	la 	$a0, prompt2
	syscall
	li 	$v0, 5   
	syscall   
	move 	$t1, $v0
	mult	$t0, $t1
	mflo	$t7
	nop
	nop
	

multiply:
        beq 	$t1, 0, result
	sll	$t4, $t1,31
	srl	$t4, $t4,31
        andi 	$t5, $t4,1
        beq 	$t5, 1, increment
	srl 	$t1, $t1,1
        sll 	$t0, $t0,1
        j 	multiply
	nop
increment:
        addu 	$t2, $t2, $t0
	srl 	$t1, $t1,1
        sll 	$t0, $t0,1
        j 	multiply
	nop  
result:
	li 	$v0, 4
	la 	$a0, newLine
	syscall
	li 	$v0, 4
	la 	$a0, prompt3
	syscall
	li 	$v0, 1
	move 	$a0, $t2
	syscall
	li 	$v0, 4
	la 	$a0, newLine
	syscall
	li	$v0, 4
	la 	$a0, prompt4
	syscall
	li	$v0, 1	
	move	$a0, $t7
	nop
	syscall
	li 	$v0, 10 
	syscall 
	
