#
# assign3.asm
# Yiming Peng
# Assignment 3
# 03/07/2020
# purpose:This assignment is for finding the sum of integers/odds/evens in 1-100,
# and also for exploring the Fibonacci  series.
#

	.text
	.globl	main

main:
#exercise 1:sum of numbers in 1-100

	li	$t0, 0		#counter
	li	$t1, 0		#sum
	li	$t2, 101
loop3:
	addiu	$t0, $t0, 1
	addu	$t1, $t1, $t0	#sum
	blt	$t0, $t2, loop3
	li	$v0, 4
	la	$a0, result	
	li	$v0, 1
	move	$a0, $t1
exit:
	li	$v0, 10
	syscall

	


#exercise 2:sum of numbers/odds/evens in 1-100

	
	li 	$t0, 0		#counter
	li 	$t1, 0 		#sum of all
	li 	$t2, 0 		# sum of even
	li 	$t3, 1 		# sum of odd

	li 	$t4, 0		# that will hold the one bit

loop:

	addu 	$t1, $t1, $t0 
 	sll	$t4, $t0, 31
 	srl	$t4, $t4, 31

 	beqz	$t4, addeven
	beq	$t4, 1, addodd

addeven:
 	addu	$t2, $t2, $t0
 	b	next
addodd:
 	addu	$t3, $t3, $t0
next:
	addiu	$t0, $t0, 1
	blt 	$t0, 101, loop

	li	$v0, 10
	syscall


#exercise 3:Fibonacci Series

	li 	$t0, 0
	li 	$t1, 0
	li 	$t2, 1
	li 	$t3, 0
loop7:
	addu	$t3, $t1, $t2

	or	$t2, $zero, $t1 
	or	$t1, $zero, $t3
	addiu	$t0, $t0, 1
	blt 	$t0, 101, loop7

	li 	$v0, 4
	la 	$a0, result7
	syscall
 
	li	$v0, 1
	move	$a0, $t3
	syscall

exit7:
	li	$v0, 10
	syscall 		

	

	