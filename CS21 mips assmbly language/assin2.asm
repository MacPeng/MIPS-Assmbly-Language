#
# assin2.asm
# Yiming Peng
# Assignment 2
# 02/23/2020
# purpose: This assignment is about signed and unsigned adding, shifting, evaluate #expressions and polynomial. 
#

	.text
	.globl	main

main:
#exercise 1: Adding up the numbers.

	#li	$t0, 456	#put 456 in t0
	#li	$t1, -229	#put -229 in t1
	#li	$t2, 325	#put 325 in t2
	#li	$t3, -552	#put -552 in t3
	#add	$t4, $t0, $t1	#456-229
	#add	$t5, $t2, $t3	#325-552
	#add	$t0, $t4, $t5





#exercise 2: Shifting and adding without a loop.
	#ori	$t0, $zero, 0	#t0=0
	#addiu	$t0, 4096	#t0=4096*1 
	#addiu	$t0, 4096	#t0=4096*2 
	#addiu	$t0, 4096	#t0=4096*3
	#addiu	$t0, 4096	#t0=4096*4
	#addiu	$t0, 4096	#t0=4096*5
	#addiu	$t0, 4096	#t0=4096*6
	#addiu	$t0, 4096	#t0=4096*7
	#addiu	$t0, 4096	#t0=4096*8
	#addiu	$t0, 4096	#t0=4096*9
	#addiu	$t0, 4096	#t0=4096*10
	#addiu	$t0, 4096	#t0=4096*11
	#addiu	$t0, 4096	#t0=4096*12
	#addiu	$t0, 4096	#t0=4096*13
	#addiu	$t0, 4096	#t0=4096*14
	#addiu	$t0, 4096	#t0=4096*15
	#addiu	$t0, 4096	#t0=4096*16
	#ori	$t1, $zero, 4096	#t1=4096
	#sll	$t1, $t1, 4	#t1 shifted by 4
	#ori	$t2, $zero, 4096	#t2=4096
	#addu	$t2, $t2, $t2	#t2=4096*2
	#addu	$t2, $t2, $t2	#t2=4096*4
	#addu	$t2, $t2, $t2	#t2=4096*8
	#addu	$t2, $t2, $t2	#t2=4096*16



#exercise 3: Signed and unsigned adding.
	#ori	$t1, $zero, 0x7000
	#sll	$t1, $t1, 16
	#addu	$t3, $t1, $t1
	#ori	$t2, $zero, 0x7000
	#sll	$t2, $t2, 16
	#add	$t4, $t2, $t2





#exercise 4: Evaluate (x*y)/z.
	ori	$t0, $zero, 0x186a	#x- 1600000 needs to be
	sll	$t0, $t0, 8 	        #shift it by 8 
	
	ori	$t1, $zero, 0x1388    	#y- 80000 needs to be shifted
 	sll	$t1, $t1, 4		#left it by 4 

	ori	$t2, $zero, 0x61a8    	#z- 400000 needs to be 
	sll	$t2, $t2, 4		#shifted it by 4 
	div	$t0, $t2
	mflo	$t3
	#nop
	#nop
	mult	$t3, $t1
	mflo	$t4

	

#exercise 5: Evaluate the polynomial 2x^3-3x^2+5x+12.

	#lw	$t0, x		#initialize x
	#nop
	#li	$t1, 2
	#li	$t2, -3
	#li	$t3, 5

	#mult	$t0, $t0	#get x^2
	#mflo 	$s0
	#nop
	#nop

	#mult	$s0, $t0	#get x^3
	#mflo	$s1
	#nop
	#nop

	#mult	$s1, $t1	#get 2x^3
	#mflo 	$s2
	#nop
	#nop

	#mult	$s0, $t2	#get -3x^2
	#mflo	$s3
	#nop
	#nop

	#mult   $t0, $t3	#get 5x
	#mflo	$s4
	#nop
	#nop
	
	#add	$t0, $s2, $s3	# get 2x^3 - 3x^2
	#add	$t0, $t0, $s4	#get 2x^3 - 3x^2 + 5x
	#add	$t0, $t0, 12	#get 2x^3 - 3x^2 + 5x + 12
	#sw	$t0, ($s8)
	#li	$v0, 10
	

	#.data
	#	x:	.word -2	#User input
	#	result:	.word -26		#Result


#exercise 6: Evaluate the expression 18xy+12x-6y+12.
	#lw	$t0, x		#initialize x
	#nop
	#lw	$t1, y		#initialize y
	#nop
	#li	$t2, 18
	#li	$t3, 12
	#li	$t4, -6

	#mult	$t0, $t1
	#mflo	$t5		#get xy
	#nop
	#nop

	#mult	$t5, $t2
	#mflo	$t6		#get 18xy
	#nop
	#nop

	#mult	$t0, $t3
	#mflo	$t7		#get 12x
	#nop	
	#nop
	
	#mult	$t1, $t4
	#mflo	$t8		#get -6y
	#nop
	#nop
	
	#add	$t0, $t6, $t7	#get 18xy+12x
	#add	$t0, $t0, $t8	#get 18xy+12x-6y
	#add	$t0, $t0, 12	#get 18xy+12x-6y+12

	
	#.data
	#	x:	.word 1		#User input
	#	y:	.word 0 	#User input
	#	result:	.word 24 	#result	



	
	