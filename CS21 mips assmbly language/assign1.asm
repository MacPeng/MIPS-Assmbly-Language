#assign1.asm
#Yiming Peng
#02/11/20
#The purpose of this assignment is to understand 
#how to use only shift logical instructions
#and register to register logic instructions.

	.text
	.globl main
main:
#exercise 1: Shifting from 0x01 to 0x55555555
	ori	$t0, $zero, 0x01
	sll	$t1, $t0, 2
	or	$t2, $t0, $t1
	sll	$t3, $t2, 4
	or	$t4, $t2, $t3
	sll	$t5, $t4, 8
	or	$t6, $t4, $t5
	sll	$t7, $t6, 16
	or	$t1, $t6, $t7
	

	 
	 
	




#exercise 2: Shifting from 0x01 to 0x69696969
	ori	$t0, $zero, 0x01
	sll	$t1, $t0, 2
	sll	$t2, $t0, 1
	or	$t3, $t1, $t2
	sll	$t4, $t3, 4
	sll	$t5, $t0, 3
	or	$t6, $t5, $t0
	or	$t7, $t4, $t6
	sll	$t8, $t7, 8
	or	$t9, $t7, $t8
	sll	$10, $t9, 16
	or	$t1, $t9, $10
		
	





#exercise 3: Shifting from 0x01 to 0xFFFFFFFF
	ori	$t0, $zero, 0x01
	sll	$t1, $t0, 1
	or	$t0, $t0, $t1
	sll	$t2, $t0, 2
	or	$t0, $t0, $t2
	sll	$t3, $t0, 4
	or	$t0, $t0, $t3
	sll	$t4, $t0, 8
	or	$t0, $t0, $t4
	sll	$t5, $t0, 16
	or	$t1, $t0, $t5