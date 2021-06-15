#
# assign5.asm
# Yiming Peng
# Assignment 5
# 04/04/2020
# 
	
	.data
prompt: .asciiz "Enter a number: "
result: .asciiz "Answer : "
x: .float 0.0
y: .float 0.0
z: .float 0.0
	.text
	.globl main
main:
	li.s	$f7, 16.0
	li.s    $f0, 0.0
	li.s    $f1, 0.0
	li.s    $f2, 0.0
	la  	$a0, prompt 
	li  	$v0, 4
	syscall 
	li  	$v0, 6
	syscall         
	s.s 	$f0 , x     
	nop
	li  	$v0, 4  
	syscall        
	li  	$v0, 6
	syscall
	s.s 	$f0, y      
	nop
	li  	$v0, 4
	syscall        
	li  	$v0, 6
	syscall
	s.s 	$f0, z      
	nop
	l.s 	$f1, x
	l.s 	$f2, y
	l.s 	$f3, z
	li.s    $f4, 3.0    
	mul.s   $f5, $f1, $f2   # a * b
	mul.s   $f5, $f5, $f4   # 3ab
	addi    $sp, $sp, -4 
	s.s  	$f5, ($sp)  # push 3ab onto stack
	nop
	li.s    $f4, -2.0
	mul.s   $f5, $f2, $f3   # b * c
	mul.s   $f5, $f5, $f4   # -2bc
	addi    $sp, $sp, -4     
	s.s  	$f5, ($sp)  # push -2bc onto stack
	nop
	li.s    $f4, -5.0
	mul.s   $f5, $f4, $f1   # 5 * a
	addi    $sp, $sp, -4    
	s.s  	$f5, ($sp)  # push -5a onto stack
	nop
	li.s    $f4, 20.0
	mul.s   $f5, $f1, $f3   # a * c
	mul.s   $f5, $f5, $f4   # 20ac
	addi    $sp, $sp, -4    
	s.s  	$f5, ($sp)  # push 20ac onto stack ( top of stack )
	nop 
	li.s    $f4, -16.0   
	l.s  	$f5, ($sp)   # pop 20ac
	nop
	addu    $sp, $sp, 4
	add.s   $f4, $f5, $f4   # 20ac - 16
	l.s  	$f5, ($sp)   # pop  -5a
	nop
	addu    $sp, $sp, 4
	add.s   $f4, $f5, $f4   # - 5a + 20ac - 16
	l.s  	$f5, ($sp)   # pop -2bc
	nop
	addu    $sp, $sp, 4 
	add.s   $f4, $f5, $f4   # - 2bc - 5a + 20ac - 16
	l.s  	$f5, ($sp)   # pop 3ab
	nop
	addu    $sp, $sp, 4 
	add.s   $f4, $f5, $f4   # 3ab - 2bc - 5a + 20ac - 16
	la	$a0, result
	li 	$v0,4
	syscall
	li 	$v0, 2
	mov.s 	$f12, $f4
	syscall
	li  	$v0, 10
	syscall         
