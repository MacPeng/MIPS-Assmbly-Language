#
# assign9.asm
# Yiming Peng
# Assignment 9
# 04/22/2020
#

	.data
prompt1: .asciiz "Enter the number:  "
prompt2: .asciiz "The Fibonacci series is: "

.text
    # Take user input
	li	$v0, 4
    	la      $a0, prompt1
   	syscall
    	li      $v0, 5
    	syscall
    	move    $s1, $v0
    # decrement
    	#addi    $v0, $v0, -1
    	addi    $sp, $sp, -12
   	sw      $v0, 0($sp)
	nop
    	sw      $ra, 8($sp)
	nop

    	jal     fibonacci
    	lw      $ra, 8($sp)
	nop
    	lw      $s0, 4($sp)
	nop
    	addi    $sp, $sp, 12
    # print result
    	move    $a0, $s1
    	li      $v0, 1
   	syscall
    	la      $a0, prompt2
    	li      $v0, 4
    	syscall
   	move    $a0, $s0
    	li      $v0, 1
    	syscall
    	li      $v0, 10
    	syscall
fibonacci:
    	lw      $t0, 0($sp)
	nop
    # if n > 46, return 0
    	#bge     $t0, 46, return0
    # base case
    	ble     $t0, 0, return0
    	beq     $t0, 1, return1
    # fibonacci(n - 1)
    	addi    $t0, $t0, -1
    	addi    $sp, $sp, -12
    	sw      $t0, 0($sp)
	nop
    	sw      $ra, 8($sp)
	nop
    	jal     fibonacci
    # reload (n - 1)
    	lw      $t0, 0($sp)
	nop
    # get return value from fibonacci(n - 1)
    	lw      $t1, 4($sp)
	nop
    	lw      $ra, 8($sp)
	nop
    	addi    $sp, $sp, 12
    # save the return value from fibonacci(n - 1) on the stack
    	addi    $sp, $sp, -4
    	sw      $t1, 0($sp)
	nop
    # fibonacci(n - 2)
    	addi    $t0, $t0, -1
   	addi    $sp, $sp, -12
    	sw      $t0, 0($sp)
	nop
    	sw      $ra, 8($sp)
	nop
    	jal     fibonacci
    # get return value from fibonacci(n - 2)
    	lw      $t2, 4($sp)
	nop
    	lw      $ra, 8($sp)
	nop
    	addi    $sp, $sp, 12
    	lw      $t1, 0($sp)
	nop
    	addi    $sp, $sp, 4

    # $t3 = fibonacci(n - 1) + fibonacci(n - 2)
    	add     $t3, $t1, $t2
    	sw      $t3, 4($sp)
	nop
    	jr      $ra
return0:
    	sw      $0, 4($sp)
	nop
    	jr      $ra
return1:
    	li      $t0, 1
    	sw      $t0, 4($sp)
	nop
    	jr      $ra
