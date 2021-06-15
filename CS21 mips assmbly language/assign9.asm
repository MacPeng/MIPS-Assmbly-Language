#
# assign9.asm
# Yiming Peng
# Assignment 9
# 04/22/2020
#

	.data
prompt1: .asciiz "Enter a number:  "
prompt2: .asciiz "The Fibonacci series is:  "

	.text
	.globl main
main:
	li	$v0, 4
    	la      $a0, prompt1
   	syscall
    	li      $v0, 5
    	syscall
    	move    $s1, $v0
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
    	ble     $t0, 0, loop1
    	beq     $t0, 1, loop2
    	addi    $t0, $t0, -1
    	addi    $sp, $sp, -12
    	sw      $t0, 0($sp)
	nop
    	sw      $ra, 8($sp)
	nop
    	jal     fibonacci

    	lw      $t0, 0($sp)
	nop
    	lw      $t1, 4($sp)
	nop
    	lw      $ra, 8($sp)
	nop
    	addi    $sp, $sp, 12
    	addi    $sp, $sp, -4
    	sw      $t1, 0($sp)
	nop
    	addi    $t0, $t0, -1
   	addi    $sp, $sp, -12
    	sw      $t0, 0($sp)
	nop
    	sw      $ra, 8($sp)
	nop
    	jal     fibonacci
    	lw      $t2, 4($sp)
	nop
    	lw      $ra, 8($sp)
	nop
    	addi    $sp, $sp, 12
    	lw      $t1, 0($sp)
	nop
    	addi    $sp, $sp, 4
    	add     $t3, $t1, $t2
    	sw      $t3, 4($sp)
	nop
    	jr      $ra
loop1:
    	sw      $0, 4($sp)
	nop
    	jr      $ra
loop2:
    	li      $t0, 1
    	sw      $t0, 4($sp)
	nop
    	jr      $ra
