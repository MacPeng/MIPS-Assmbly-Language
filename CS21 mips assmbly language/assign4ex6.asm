#exercise6
	.text
   	.globl   main

main:
	li	$t0, 0          # i = 0
   	li   	$t1, 10          # Read 10 integers
   	la   	$t2, array      # $t2 points to address of array

loop:
   	la   	$a0, prompt
   	li   	$v0, 4
   	syscall
   	li   	$v0, 5       # Read an integer
  	syscall
   	sw   	$v0, 0($t2)       # Store   integer in array[i]
	nop
	nop
   	addi 	$t2,$t2,4         #go to next element of array
   	addi   	$t0, $t0, 1   # i = i + 1
   	blt   	$t0, $t1, loop   # If (i < 10) then go to the loop
	nop
	nop          
	li 	$t0,0          #i=0
	la   	$t2, array      # $t2 points to address of array
print:
   	beq   	$t0, $t1, newline   # Check for array end
	nop
	nop
   	lw   	$a0, ($t2)   # Print value at the array pointer
	nop
	nop
   	li   	$v0, 1
   	syscall
   	la   	$a0, space
   	li   	$v0, 4
   	syscall
   	addi   	$t0, $t0, 1   # Advance loop counter
   	addi   	$t2, $t2, 4   # Advance array pointer
   	j 	print           # Repeat the loop
	nop
	nop
newline:
   	la   	$a0, endl
   	li   	$v0, 4
   	syscall
	li 	$t1,5           #will loop 5 times(half the loop size)
   	li 	$t0,0          #beginning of array pointer
    	la   	$t2,array    #beginning of array
   	la 	$t5,array      #form
   	addi 	$t5,$t5,36        #end of array
loop2:
   	beq   	$t0, $t1, startprint2 # Break from loop if j = 10
	nop
	nop
   	lw   	$s1, ($t2)
	nop
	nop
  	lw   	$s2, ($t5)
	nop
	nop
   	sw   	$s2, ($t2)
	nop
	nop
   	sw   	$s1, ($t5)
	nop
	nop
    	addi 	$t0,$t0,1   #i=i+1
   	addi 	$t2,$t2,4    #advance beginning of array
   	addi 	$t5,$t5,-4   #decrease end of array
   	j 	loop2
	nop
	nop
startprint2:
	li 	$t0,0          #i=0
	la   	$t2, array      # $t2 points to address of array
	li 	$t1,10         #times to loop

print2:
   	beq   	$t0, $t1, newline2   # Check for array end
	nop
	nop
   	lw   	$a0, ($t2)   # Print value at the array pointer
	nop
	nop
   	li   	$v0, 1
   	syscall
   	la   	$a0, space
   	li   	$v0, 4
   	syscall
   	addi   	$t0, $t0, 1   # Advance loop counter
   	addi   	$t2, $t2, 4   # Advance array pointer
   	j 	print2           # Repeat the loop
	nop
	nop
newline2:
   	la   	$a0, endl
   	li   	$v0, 4
   	syscall

end:
   	li   	$v0, 10
   	syscall
	.data
	array: .space 40
	prompt: .asciiz "Enter a number: "
	space: .asciiz "\t"
	endl: .asciiz "\n"
