#
# lab04.asm
,# Yiming Peng, Ethan Vocal
# Lab 4
# Date:03/02/2020
# Purpose: This lab is to practice writing different loops in mips assembly #language.
#

	.text
	.globl main

main:	#if statement

	li	$t0, 0
	li	$t1, 0
	ble	$t0, $t1, put10
	b	finish
put10:
	li	$t1, 10
finish:
	


	#if-else

	li	$t0, 0
	li	$t1, 0
	blt	$t0, $t1, else
	li	$t0, 20
	b	done
else:
	li	$t1, 10
	b	done
done:


	#while loop
	
	li	$t0, 0
	li	$t1, 0
loop:	
	bge	$t0, 10, stop
	addu	$t1, $t1, $t0
	addi	$t0, $t0, 1
	b	loop
stop:
	

	
	#do-while loop
	li	$t0, 0
	li	$t1, 0
loop1:	addu	$t1, $t1, $t0
	addi	$t0, $t0, 1
	blt	$t0, 10, loop1
	




	#for loop	
	li	$t0, 0
	li	$t1, 0
loop2:	
	beq	$t0, 10, out
	addu	$t1, $t1, $t0
	addi	$t0, $t0, 1
	j	loop2
out:


	