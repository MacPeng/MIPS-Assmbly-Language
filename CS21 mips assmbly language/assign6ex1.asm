#
# assign6.asm
# Yiming Peng
# Assignment 6
# 04/08/2020
# 
	.text
	.globl main

main:
	li	$v0, 4 
	la 	$a0, prompt 
	syscall 
	li 	$v0, 5 
	syscall 
	mtc1 	$v0, $f0 
	cvt.s.w $f1, $f0 
	s.s 	$f1, n 
	nop 

	l.s 	$f0, n 
	l.s 	$f1, floatone 
	l.s 	$f2, floattwo 
	l.s 	$f3, floatone 
	l.s 	$f10, floatlimit 

loop:   
	mov.s 	$f4, $f0 
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
	mov.s 	$f12, $f3 
	li 	$v0, 2
	syscall
	li 	$v0, 10 
	syscall
	nop

	.data
n: .float 5.0 
floatone: .float 1.0   
floattwo: .float 2.0
floatlimit: .float 1.0e-5
prompt: .asciiz "Choose an integer for its square root:\n"
