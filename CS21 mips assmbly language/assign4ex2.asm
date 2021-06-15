#exercise2	
	.text
	.globl main
	li 	$v0, 4   
	la 	$a0, string
	syscall

	li 	$t0, 0
loop:
	lb 	$t1, string($t0)
	nop
	nop
	beqz 	$t1, end  
	nop
	nop
	bnez 	$t0, next  
	nop
	nop
	blt     $t1, 97, next2  
	nop
	nop
	bgt 	$t1, 122, next2
	nop
	subu 	$t1, $t1, 32
	sb 	$t1, string($t0)
	j 	loop

next:
	bne 	$t1, 32, next2  
	nop
	nop
	addiu 	$t0, $t0, 1
	lb 	$t1, string($t0)
	nop
	nop
	blt 	$t1, 97, loop  
	nop
	nop
	bgt 	$t1, 122, loop
	nop
	subu 	$t1, $t1, 32
	sb 	$t1, string($t0)

next2:
	addiu 	$t0, $t0, 1
	j 	loop

end:
	li 	$v0, 4   
	la 	$a0, newline
	syscall

	li 	$v0, 4   
	la 	$a0, string
	syscall

	li 	$v0, 10   
	syscall

  	.data
	string: .asciiz "in a hole in the   ground there lived a hobbit"
	newline: .asciiz "\n"
