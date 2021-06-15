#exercise 4

	.data
    buffer: .space 100
    str1:  .asciiz "Enter string: "
    str2:  .asciiz "Capitalized: "

	.text

main:
    	la	$a0, str1    
    	li 	$v0, 4
    	syscall

    	li 	$v0, 8       
    	la 	$a0, buffer  
    	li 	$a1, 100      
    	syscall
    	move 	$s0, $a0   

    	li	 $v0, 4
    	li 	$t0, 0

    #Loop to capitalize
loop:
    	lb 	$t1, buffer($t0)    
    	nop
	nop 
    	beq 	$t1, 0, exit       
    	blt 	$t1, 'A', not_lower  
   	blt 	$t1, 'Z', to_upper  
	nop
	nop
    	sub 	$t1, $t1, 32  
    	sb 	$t1, buffer($t0)  
not_lower: 		
	addi	$t0, $t0, 1
    	j 	loop

to_upper:
	add 	$t1, $t1, 32
	sb 	$t1, buffer($t0)
	addi 	$t0, $t0, 1
	j 	loop
exit:
    	la 	$a0, str2    
    	li 	$v0, 4
    	syscall

    	move 	$a0, $s0  
   	li 	$v0, 4       
    	syscall
    
	li 	$v0, 10      
    	syscall

