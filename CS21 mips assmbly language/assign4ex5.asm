#exercise 5

	.text
   	.globl   main

main:
	li 	$t0, 0 # i = 0
	li 	$t1, 10 # Read 10 integers
	la 	$t2, array # $t2 points to address of array

loop:
	la 	$a0, prompt
	li 	$v0, 4
	syscall

	li 	$v0, 5 # Read an integer
	syscall

	add 	$t4,$t0,$t0
	add 	$t4,$t4,$t4
	add 	$t4,$t4,$t2 # address of array[i] = address of array[0] + 4 * i 	because each integer is 4 byte
	sw 	$v0, 0($t4) # Store i integer in array[i]
	nop
	nop
	addi 	$t0, $t0, 1 # i = i + 1
	blt 	$t0, $t1, loop # If (i < 10) then go to the loop
	nop
	nop
	la 	$a0, array # a0 = address of array
	addi 	$a1, $0, 9 # $a1 = n = 9
	lw 	$t0,0($a0)
	nop
	nop
	lw $t1,0($a0)
	nop
	nop
	addi 	$a0,$a0,4 # move to array[1]
  
loop1:   
	lw 	$t2,0($a0)
	nop
	nop
	blt 	$t2,$t0,changemin
	nop
	nop
returnmin:
	bgt 	$t2,$t1,changemax
	nop
	nop

returnmax:
	subu 	$a1,$a1,1
	addi 	$a0,$a0,4 # move to array[1]
	bne 	$a1,$0,loop1
  	nop
	nop

	la 	$a0, smallest
	li 	$v0, 4
	syscall

	li 	$v0, 1 # Read an integer
	move 	$a0,$t0
	syscall

	la 	$a0, largest
	li 	$v0, 4
	syscall

	li 	$v0, 1 # Read an integer
	move 	$a0,$t1
	syscall

#exit
	li	$v0,10
	syscall

changemin:
	move 	$t0,$t2
	b 	returnmin
	nop
	nop

changemax:
	move 	$t1,$t2
	b 	returnmax
	nop
	nop
	.data
	array: .space 40
	prompt: .asciiz "Enter a number: "
	smallest: .asciiz "Smallest: "
	largest: .asciiz "\nLargest: "
	endl: .asciiz "\n"

