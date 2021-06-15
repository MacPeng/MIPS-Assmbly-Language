#
# interrupts.asm
# Yiming Peng
# Final Project
# 05/13/2020
#

	.data
flag:	.word 0
source:	.asciiz "The Brown quiCk fox juMPed Over tHE lazy Dog\n"
display: .asciiz "                                              "                                    

	.text
	.globl main
main:
	la	$a0, display
	la	$a1, source
	jal	copyArray
	mfc0	$s0, $12
	ori	$s0, 0xC01
	mtc0	$s0, $12
	li	$s1, 0xffff0000		
	lw	$s0, ($s1)
	ori	$s0, $s0, 0x2
	sw	$s0, ($s1)	 	
	li	$s0, 0xffff0008	
	lw	$s1, ($s0)
	ori	$s1, $s1, 0x2
	sw	$s1, ($s0)

flag_loop:
	la	$t1, flag
	lw	$t0, 0($t1)
	bne	$t0, 0, end
	b	flag_loop
	nop	
end:	
	li	$v0, 10
	syscall

copyArray:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)
	move	$t0, $a0
	move	$t1, $a1

copyloop:
	lb	$s0, ($t1)
	sb	$s0, ($t0)
	beq	$s0, 0, copyexit
	addi	$t0, $t0, 1
	addi	$t1, $t1, 1
	j	copyloop
	nop
copyexit:
	move	$a0, $a2
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra
	nop

	.kdata
save_at:	.word 0
save_t0:	.word 0
save_t1:	.word 0
pointer:	.word 0
save_s0:	.word 0
save_s1:	.word 0

size:		.word 65
	.ktext	0x80000180
	.set noat
	move	$k0, $at
	.set at
	sw	$k0, save_at
	sw	$t0, save_t0
	sw	$t1, save_t1
	sw	$s0, save_s0
	sw	$s1, save_s1
	mfc0	$t0, $13
	andi	$t0, $t0, 0x800
	bne	$t0, 0, input
	mfc0	$t0, $13
	andi	$t0, $t0, 0x400
	bne	$t0, 0, print

input:
	li	$t1, 0xffff0000
	lw	$t0, 4($t1)		
	beq	$t0, 'q', quit		
	beq	$t0, 's', sort		
	beq	$t0, 't', toggle		
	beq	$t0, 'a', replace	
	beq	$t0, 'r', reverse
	b	restore
	nop

print:
	li	$t0, 0xffff0000
	la	$t1, display
printIt:
	lw	$s1, 8($t0)
	nop
	andi	$s1, $s1, 1
	beq	$s1, 0, printIt

	lb	$s0, ($t1)
	beq	$s0, 0, endPrint

	sw	$s0, 12($t0)
	addiu	$t1, $t1, 1
	b	printIt
	nop

endPrint:
	b	restore
	nop

quit:
	la	$t1, flag
	li 	$t0, 1
	sw	$t0, ($t1)
	b	restore
	nop

sort: 
	la	$s0, size		
	lw	$t0, ($s0)				
for1: 
	la	$s1, display
	beq	$t0, 0, exit  	
for2:	
	lb	$t1, ($s1) 	
	lb	$k1, 1($s1)
	nop
	beq	$k1, 0x0a, exit2 	
	bgt	$k1, $t1, else 
	j swap
	nop
else:  
	addi	$s1, $s1, 1
	beq	$k1, 0x0a, exit2
	j for2
	nop
exit: 		
	j	restore
	nop
exit2: 
	addi	$t0, $t0, -1 		
	j	for1
	nop
swap: 
	sb	$k1, 0($s1)
	sb	$t1, 1($s1)
	j	else
	nop

toggle:
	la	$s0, display
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
	j	restore
	nop

replace:
	la	$s0, display
	la	$s1, source

copyChar:
	lb	$t0, ($s1)
	sb	$t0, ($s0)
	beq	$t0, 0x0a, copyExit
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	j	copyChar
	nop
copyExit:
	j	restore
	nop

reverse:
	la	$t0, display	
checklast:
	lb	$t1, ($t0)
	nop
	beq	$t1, 0, reverstore
	addi	$t0, $t0, 1
	j	checklast
	nop
reverstore:
	addi	$t0, $t0,-2
	la	$s0, display		
loop:
	lb	$s1, ($t0)
	lb	$t1, ($s0)
	blt	$t0, $s0, exitreverse
	sb	$s1, ($s0)
	sb	$t1, ($t0)
	addi	$t0, $t0, -1
	addi	$s0, $s0, 1
	j	loop
	nop
exitreverse:	
	j	restore
	nop

restore:
	lw	$k0, save_at
	lw	$t0, save_t0
	lw	$t1, save_t1
	lw	$s0, save_s0
	lw	$s1, save_s1
	.set	noat
	move	$at, $k0
	.set	at 
	eret
