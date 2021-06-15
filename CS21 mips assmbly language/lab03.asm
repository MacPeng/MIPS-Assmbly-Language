#
# lab03.asm
# Nickolas Alcazar, Yiming Peng
# Lab 3
# Evaluate a polynomial using Horner's Method given user input.
#

	.data
		x:  	.word 0 # User input
		y:  	.word 0 # Result
		text:	.asciiz "\nresult="

	.text
	.globl	main

main: 	ori 	$v0, $zero, 5 # Store syscall code for reading integer input
		syscall
		sw  	$v0, x # Store user input in the variable "x"
		lw  	$t0, x # Store value of x in variable $t0

		# $t0 - original user input
		# $t1 - current/final result
		# $t2 - temporary value

		# Perform math
		ori 	$t2, $zero, 4
		multu	$t0, $t2 # (input * 4)
		mflo	$t1 # result = (input * 4)
		nop
		nop

		addiu	$t1, $t1, 2 # result = (r + 2)

		multu	$t0, $t1 # (result * input)
		mflo	$t1 # result = (result * input)
		nop

		ori 	$t2, $zero, 5
		subu	$t1, $t1, $t2 # result = (r - 5)

		multu	$t0, $t1 # (result * input)
		mflo	$t1 # result = (result * input)
		nop
		nop

		addiu	$t1, $t1, 3 # result = (r + 3)

		sw  	$t1, y # Store final result in variable "y"

		# Printing the results
		ori  	$v0, $zero, 4 # Store syscall code "4"
		la  	$a0, text
		syscall
		or  	$a0, $zero, $t1 # Store result in $a0 to be printed
		ori 	$v0, $zero, 1 # Store syscall code for printing integers
		syscall
