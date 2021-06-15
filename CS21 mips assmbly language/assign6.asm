## newton.s -- compute sqrt(n)
## given an approximation x to sqrt(n),
## an improved approximation is:
## x' = (1/2)(x + n/x)
## Register use:
## $f0 --- n
## $f1 --- 1.0
## $f2 --- 2.0
## $f3 --- x : current approx.
## $f4 --- x' : next approx.
## $f8 --- temp
.text
.globl main

main:
	li 	$v0, 4 # print string
	la $a0, prompt # address of prompt string
	syscall # print the prompt
	li $v0, 5 # read integer
	syscall # get the integer
	mtc1 $v0, $f0 # move integer to coprocessor 1
	cvt.s.w $f1, $f0 # convert entered integer to single
	s.s $f1, n # store it in n
	nop # store delay slot

# start Newton's algorithm to approximate square root
	l.s $f0, n # get n
	l.s $f1, float_one # constant 1.0
	l.s $f2, float_two # constant 2.0
	l.s $f3, float_one # x == first approx.
	l.s $f10, float_limit # five figure accuracy

loop:   
	mov.s $f4, $f0 # x' = n
	div.s $f4, $f4,$f3 # x' = n/x
	add.s $f4, $f3,$f4 # x' = x + n/x
	div.s $f3, $f4,$f2 # x = (1/2)(x + n/x)

	mul.s $f8, $f3, $f3 # check: x^2
	sub.s $f8, $f8, $f0 # x^2 - n
	abs.s $f8, $f8 # |x^2 - n|
	c.lt.s $f8, $f10 # |x^2 - n| < limit ?
	bc1t done # yes: done
	nop
	j loop # next approximation
	nop

done:
	mov.s $f12, $f3 # print the result
	li $v0, 2
	syscall
	li $v0, 10 # return to OS
	syscall
	nop

	.data
n: .float 5.0 # default 5, but will be changed
float_one: .float 1.0   
float_two: .float 2.0
float_limit: .float 1.0e-5
prompt: .asciiz "Enter an integer for its square root\n"


#ex2
.text
.globl main

main:

   li $t0,4
   la $t1,prompt_tab
   la $t2,points_data

loop1:  

li $v0, 4 # print string
lw $a0, 0($t1) # address of prompt string
nop
syscall # print the prompt
li $v0, 6 # read float value of x1 in $f0
syscall # get the integer
s.s $f0,($t2)
nop
   addi $t1,$t1,4
   addi $t2,$t2,4
sub $t0,$t0,1
bne $t0,$0,loop1 #loop 4 times to get all the values

la $t0,points_data
l.s $f2,($t0)
l.s $f3,4($t0)
l.s $f4,8($t0)
l.s $f5,12($t0)   
  
sub.s $f0, $f2, $f4 # x1-x2
mul.s $f0, $f0, $f0 # square(x1-x2)
  
   sub.s $f1, $f3, $f5 # y1-y2
mul.s $f1, $f1, $f1 # square(y1-y2)
  
add.s $f0, $f0,$f1 # square(x1-x2) + square(y1-y2)
  
# start Newton's algorithm to approximate square root for the value in $f0
l.s $f1, float_one # constant 1.0
nop
l.s $f2, float_two # constant 2.0
nop
l.s $f3, float_one # x == first approx.
nop
l.s $f10, float_limit # five figure accuracy
nop

loop:   
mov.s $f4, $f0 # x' = n
nop
div.s $f4, $f4,$f3 # x' = n/x
add.s $f4, $f3,$f4 # x' = x + n/x
div.s $f3, $f4,$f2 # x = (1/2)(x + n/x)

mul.s $f8, $f3, $f3 # check: x^2
sub.s $f8, $f8, $f0 # x^2 - n
abs.s $f8, $f8 # |x^2 - n|
c.lt.s $f8, $f10 # |x^2 - n| < limit ?
bc1t done # yes: done
nop
j loop # next approximation
nop

done:
li $v0, 4 # print string
la $a0, distance # address of prompt string for y2
syscall # print the prompt
  
mov.s $f12, $f3 # print the result
li $v0, 2
syscall
li $v0, 10 # return to OS
syscall
nop

.data
float_one: .float 1.0   
float_two: .float 2.0
float_limit: .float 1.0e-5
prompt_x1: .asciiz "Enter x value for point 1\n"
prompt_x2: .asciiz "Enter x value for point 2\n"
prompt_y1: .asciiz "Enter y value for point 1\n"
prompt_y2: .asciiz "Enter y value for point 2\n"
distance: .asciiz "The distance between point 1 and 2 is : "
prompt_tab: .word prompt_x1, prompt_y1, prompt_x2, prompt_y2
points_data: .float 1.0,1.0,1.0,1.0 #all the data are initialised with 1.0
