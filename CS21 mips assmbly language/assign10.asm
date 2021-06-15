#
# assign10.asm
# Yiming Peng
# Assignment 10
# 05/04/2020
#

	.data
source: .asciiz "The Brown quCk fox juMPed Over tHE lazy Dog\n"
display: .asciiz "                                               "
size:	.word	65

	.text
	.globl main

main:
	la	$a1, source
	la	$a0, display
	jal	copyArray
	nop
poll:
	jal	input
	nop
	beq	$v0, 's', s
	beq	$v0, 't', t
	beq	$v0, 'a', c
	beq	$v0, 'r', r
	beq	$v0, 'q', q
	j	poll
	nop
s:
	la	$a0, display
	la	$a1, size
	jal	sort
	nop
	la	$a0, display
	jal	print
	nop
	j	poll
	nop
t:
	la	$a0, display
	jal	toggle
	nop
	la	$a0, display
	jal	print
	nop
	j	poll
	nop
r:
	la	$a0, display
	jal	reverse
	nop
	la	$a0, display
	jal	print
	nop
	j	poll
	nop
c:
	la	$a0, display
	la	$a1, source
	jal	copyArray
	nop
	la	$a0, display
	jal	print
	nop
	j	poll
	nop
q:
	li	$v0, 10
	syscall
toggle:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)
	move	$s0, $a0
toggleloop:
	lb	$t0, ($s0)
	beq	$t0, 0, toggleexit
	blt	$t0, 0x20, ignorespace
	blt	$t0, 0x41, ignorespace
	blt	$t0, 0x5b, tolower
	sub	$t0, $t0, 32
	sb	$t0, ($s0)
	addi	$s0, $s0, 1
	j	toggleloop
	nop
ignorespace:	
	addi	$s0, $s0, 1
	j 	toggleloop
	nop
tolower:
	add	$t0, $t0, 32
	sb	$t0, ($s0)
	addi	$s0, $s0, 1
	j 	toggleloop
	nop
toggleexit:
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra
	nop
copyArray:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)
	move	$t0, $a1
	move	$t1, $a0
copyloop:
	lb	$s0, ($t0)
	sb	$s0, ($t1)
	beq	$s0, 0, copyexit
	addi	$t0, $t0, 1
	addi	$t1, $t1, 1
	j	copyloop
	nop
copyexit:
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra
	nop
reverse:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)
	move	$t5, $a0	
checklast:
	lb	$t1, ($t5)
	nop
	beq	$t1, 0, reverstore
	addi	$t5, $t5, 1
	j	checklast
	nop
reverstore:
	addi	$t5, $t5,-2		
loop:
	lb	$t2, ($t5)
	lb	$t3, ($a0)
	blt	$t5, $a0, exitreverse
	sb	$t2, ($a0)
	sb	$t3, ($t5)
	addi	$t5, $t5, -1
	addi	$a0, $a0, 1
	j	loop
	nop
exitreverse:
	lw	$ra, ($sp)
	add	$sp, $sp, 4	
	jr	$ra
	nop
sort: 
	sub	$sp, $sp, 4
	sw	$ra, ($sp)		
	lw	$t0, ($a1)				
for1: 
	move	$t5, $a0 
	beq	$t0, 0, exit  	
for2:	
	lb	$t2, ($t5) 	
	lb	$t3, 1($t5)
	nop
	beq	$t3, 0x0a, exit2 	
	bgt	$t3, $t2, else 
	j swap
	nop
else:  
	addi	$t5, $t5, 1
	beq	$t3, 0x0a, exit2
	j for2
	nop
exit: 
	lw	$ra, ($sp)
	add	$sp, $sp, 4		
	jr	$ra
	nop
exit2: 
	addi	$t0, $t0, -1 		
	j	for1
	nop
swap: 
	sb	$t3, 0($t5)
	sb	$t2, 1($t5)
	j	else
	nop
print:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)
	li	$a3, 0xffff0000
printloop:
	lw	$t1, 8($a3)
	andi	$t1, $t1, 1
	beqz	$t1, printloop
	lb	$t0, ($a0)
	beqz	$t0, printexit
	sb	$t0, 12($a3)
	addiu	$a0, $a0, 1
	j	printloop
	nop
printexit:
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra
	nop
input:
	sub	$sp,$sp, 4
	sw	$ra, ($sp)
	li	$s3, 0xffff0000
inputloop:
	lw	$t1, ($s3)
	addi	$t1, $t1, 1
	beqz	$t1, inputloop
	lw	$t0, 4($s3)
	move	$v0, $t0
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra
	nop
