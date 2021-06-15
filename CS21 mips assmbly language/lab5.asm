Lab5.1.asm
# Frezer Woldemariam, Yiming Peng 
#
# 03/16/20
# CS21 Lab5.1
#
# program that reverse a string 

	
	.data
string:		.asciiz "The quick brown fox jumps over a lazy dog\n"

	
	.globl main
	.text

main:
	la	$t1, string			# loading the address of string into $t1
	li	$t2, 0				# initializing $t2 to 0 to be used as flag

	li	$v0, 4				# system call code for string print
	la	$a0, string			# loading the address of string to be printed
	syscall					# system call to print
	

scanend:
	lb	$t2, ($t1)			# reading a value from $t2 (string) into $t2
	nop					# delay slot for the load byte
	beq	$t2, 0xa, lastelement		# branch to lastelement if $t2 is equal to 10 (LF)
	
	addi	$t1, $t1, 1			# increment $t1 to the next element
	b	scanend				# loop back to scanend
	
lastelement:
	li	$t0, 0				# initializing $t0 to zero to hold the last element
	addi	$t1, $t1, -2			# decrementing $t1 (string) back to the last element
	la	$t3, string			# loading address of string into $t3

reverse:
	lb	$t0, ($t1)			# reading a value from $t1 into $t0 (backwards) 	

	
	lb	$s0, ($t3)			# reading a value from $t3 into $s0 (forwards)
	li	$t4, 0				# initializing $t4 to be used as temp


	blt	$t1, $t3, print			# branch to print if $t1 is lessthan $t3 
	move	$t4, $s0			# moving the value from $s0 into $t4 (temp)
	move	$s0, $t0			# moving the value from $t0 into $s0 (swap)
	move	$t0, $t4			# moving the value from $t4 (temp) into $t0
	
	sb	$s0, ($t3)			# storing the value at $s0 into $t3 (string)
	sb	$t0, ($t1)			# storing the value at $t0 into $t1 (string)

	addi	$t3, $t3, 1			# incrementing $t3 to the next element 
	addi	$t1, $t1, -1			# decrementing $t1 to the previous element
	j	reverse				# loop back to reverse
	
	

print:

	li 	$v0, 4				# system call code to print string	
	la	$a0, string			# loading the address of string to be printed 
	syscall					# system call to print

	li 	$v0, 10				# system call code to terminate program & pass control to OS
	syscall	
		






	.text
	.globl main

main:
	li	$t1, 0	 # initalize counter $t1 to 0
	li	$t3, 0   # initalize index $t3 to 0
-------------- # load the size of integer array to '$t0' using symbolic address 'array' and index '$t3'
nop
subu $t0, $t0, 1 # get max index using size (12-1=11)

___________________________________ # load the first integer in the array to '$t2'
nop
j next
nop

loop:
___________________________________ # if the index equals the max index saved in '$t0', go to 'done'
move $t4, $t3 # move index '$t3' to '$t4'
lw $t7, array($t4) # load current integer to '$t7'
nop   
subu $t4, $t3, 4 # update '$t4' to get the previous integer
___________________________________ # load the previous integer to '$t8'
nop
___________________________________ # update '$t4' to get the next integer
___________________________________ # load the next integer to '$t9'
nop
addu $t2, _______________________ # compute the sum of the current integer and the previous integer
addu $t2, _______________________ # compute the sum of the current integer, the previous integer, and the next integer
___________________________________ # compute the average
next:
___________________________________ # store the integer to the 'result' using symoblic address 'result' and index '$t3'
___________________________________ # update counter'$t1'
___________________________________ # update index '$t3'
j loop
nop
done:
___________________________________ # load the last integer of 'array' to '$t2'
nop
___________________________________ # store the last integer of 'array' in '$t2' to the last integer of 'result'
li $t1, 0
li $t3, 0
print:
___________________________________ # if the index '$t1' is greater than the max index '$t0', go to 'finish'
___________________________________ # load the integer in 'result' to '$t2'
li $v0, 1 # print the integer
move $a0, $t2
syscall
la $a0, space # print space
li $v0, 4
syscall
___________________________________ # update counter'$t1'
___________________________________ # update index '$t3'
j next	# jump back to print next integer
finish:
li $v0,10 # exit
syscall   
  
.data
size: .word 12
array: .word 50, 53, 52, 49, 48, 51, 99, 45, 53, 47, 47, 50
result: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
space: .asciiz " "