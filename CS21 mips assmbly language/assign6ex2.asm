	.text
	.globl main
main:
	li	$t0, 4
   	la 	$t1, prompttab
   	la 	$t2, pointsdata

loop1:  

	li 	$v0, 4 
	lw 	$a0, 0($t1) 
	nop
	syscall 
	li 	$v0, 6 
	syscall 
	s.s 	$f0,($t2)
	nop
   	addi 	$t1, $t1, 4
   	addi 	$t2, $t2, 4
	sub 	$t0, $t0, 1
	bne 	$t0, $0, loop1 
	la 	$t0, pointsdata
	l.s 	$f2,($t0)
	l.s 	$f3, 4($t0)
	l.s 	$f4, 8($t0)
	l.s 	$f5, 12($t0)    
	sub.s 	$f0, $f2, $f4 
	mul.s 	$f0, $f0, $f0 
   	sub.s 	$f1, $f3, $f5 
	mul.s 	$f1, $f1, $f1 
	add.s 	$f0, $f0, $f1 
	l.s 	$f1, floatone 
	nop
	l.s 	$f2, floattwo 
	nop
	l.s 	$f3, floatone 
	nop
	l.s 	$f10, floatlimit 
	nop
loop:   
	mov.s 	$f4, $f0 
	nop
	div.s 	$f4, $f4, $f3 
	add.s 	$f4, $f3, $f4 
	div.s 	$f3, $f4, $f2 
	mul.s 	$f8, $f3, $f3 
	sub.s 	$f8, $f8, $f0 
	abs.s 	$f8, $f8 
	c.lt.s 	$f8, $f10 
	bc1t 	done 
	nop
	j 	loop 
	nop
done:
	li 	$v0, 4 
	la 	$a0, distance 
	syscall   
	mov.s 	$f12, $f3 
	li 	$v0, 2
	syscall
	li 	$v0, 10 
	syscall
	nop

	.data
floatone: .float 1.0   
floattwo: .float 2.0
floatlimit: .float 1.0e-5
promptx1: .asciiz "Choose x value for the 1st point:\n"
promptx2: .asciiz "Choose x value for the 2nd point:\n"
prompty1: .asciiz "Choose y value for the 1st point:\n"
prompty2: .asciiz "Choose y value for the 2nd point:\n"
distance: .asciiz "The distance between the 1st point and the 2nd point is: "
prompttab: .word promptx1, prompty1, promptx2, prompty2
pointsdata: .float 1.0,1.0,1.0,1.0 
