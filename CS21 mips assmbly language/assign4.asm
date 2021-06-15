#
# assign4.asm
# Yiming Peng
# Assignment 4
# 03/24/2020
# 
#


	.data
str: .asciiz "ABCdEfgH"

	.text
	.globl main
main:

# exercise 1 
	la $t1, str
nextCh: 
	lb $t2, ($t1)
	nop
	nop
	beqz $t2, strEnd
	addi $t4, $zero, 0x61
	sub $t3, $t2, $t4
	bgez $t3, l1
	add $t2, $t2, 32
	sb $t2, ($t1)
l1: 
	add $t1, $t1, 1
	j nextCh
strEnd: 
	la $a0, str
	li $v0,4
	syscall
	li $v0, 10
	syscall


#exercise 2
	.text
	.globl main
	li $v0, 4   # Print the original string.
	la $a0, string
	syscall

	li $t0, 0
loop:
	lb $t1, string($t0)
	nop
	nop
	beqz $t1, end  # if ($t1 == NULL) print the result
	nop
	nop
	bnez $t0, next  # Check if first character is lower case
	nop
	nop
	blt     $t1, 97, next2  # Convert from lower case to upper case
	nop
	nop
	bgt $t1, 122, next2
	nop
	subu $t1, $t1, 32
	sb $t1, string($t0)
	j loop

next:
	bne $t1, 32, next2  # if ($t1 == ' ') check for next character
	nop
	nop
	addiu $t0, $t0, 1
	lb $t1, string($t0)
	nop
	nop
	blt $t1, 97, loop  # Convert from lower case to upper case
	nop
	nop
	bgt $t1, 122, loop
	nop
	subu $t1, $t1, 32
	sb $t1, string($t0)

next2:
	addiu $t0, $t0, 1
	j loop

end:
	li $v0, 4   # Print a new line.
	la $a0, newline
	syscall

	li $v0, 4   # Print the new string.
	la $a0, string
	syscall

	li $v0, 10   # End the program.
	syscall

  	.data
	string: .asciiz "in a hole in the   ground there lived a hobbit"
	newline: .asciiz "\n"


#exercise 3






#exercise 4

	.data
    buffer: .space 100
    str1:  .asciiz "Enter string: "
    str2:  .asciiz "Capitalized: "

	.text

main:
    	la $a0, str1    # Load and print string asking for string
    	li $v0, 4
    	syscall

    	li $v0, 8       # take in input
    	la $a0, buffer  # load byte space into address
    	li $a1, 100      # allot the byte space for string
    	syscall
    	move $s0, $a0   # save string to s0

    	li $v0, 4
    	li $t0, 0

    #Loop to capitalize
loop:
    	lb $t1, buffer($t0)    #Load byte from 't0'th position in buffer into
    	nop
	nop 
    	beq $t1, 0, exit       #If ends, exit
    	blt $t1, 'A', not_lower  #If it is space
   	blt $t1, 'Z', to_upper  #If it is less than Z
	nop
	nop
    	sub $t1, $t1, 32  #If lowercase, then subtract 32
    	sb $t1, buffer($t0)  #Store it back to 't0'th position in buffer	addi $t0, $t0, 1

#if not lower, then increment $t0 and continue
not_lower: 		
	addi $t0, $t0, 1
    	j loop

# to change upper to lower
to_upper:
	add $t1, $t1, 32
	sb $t1, buffer($t0)
	addi $t0, $t0, 1
	j loop
exit:
    	la $a0, str2    # load and print "capitalized" string
    	li $v0, 4
    	syscall

    	move $a0, $s0   # primary address = s0 address (load pointer)
   	li $v0, 4       # print string
    	syscall
    
	li $v0, 10      # end program
    	syscall

#exercise 5

.text
   .globl   main

main:
	li $t0, 0 # i = 0
	li $t1, 10 # Read 10 integers
	la $t2, array # $t2 points to address of array

loop:
	la $a0, prompt
	li $v0, 4
	syscall

	li $v0, 5 # Read an integer
	syscall

	add $t4,$t0,$t0
	add $t4,$t4,$t4
	add $t4,$t4,$t2 # address of array[i] = address of array[0] + 4 * i 	because each integer is 4 byte
	sw $v0, 0($t4) # Store i integer in array[i]
	nop
	nop
	addi $t0, $t0, 1 # i = i + 1
	blt $t0, $t1, loop # If (i < 10) then go to the loop
	nop
	nop
	# ($t0 = 0, $t1 = 10)
	la $a0, array # a0 = address of array
	addi $a1, $0, 9 # $a1 = n = 9
	#$t0 has min, $t1 has max
	#initialise $t0 & $t1 with array[0]
	lw $t0,0($a0)
	nop
	nop
	lw $t1,0($a0)
	nop
	nop
	addi $a0,$a0,4 # move to array[1]
  
loop1:   
	lw $t2,0($a0)
	nop
	nop
	blt $t2,$t0,changemin
	nop
	nop
returnmin:
	bgt $t2,$t1,changemax
	nop
	nop

returnmax:
	subu $a1,$a1,1
	addi $a0,$a0,4 # move to array[1]
	bne $a1,$0,loop1
  	nop
	nop

	la $a0, smallest
	li $v0, 4
	syscall

	li $v0, 1 # Read an integer
	move $a0,$t0
	syscall

	la $a0, largest
	li $v0, 4
	syscall

	li $v0, 1 # Read an integer
	move $a0,$t1
	syscall

#exit
	li $v0,10
	syscall

changemin:
	move $t0,$t2
	b returnmin
	nop
	nop

changemax:
	move $t1,$t2
	b returnmax
	nop
	nop
	.data
	array: .space 40
	prompt: .asciiz "Enter a number: "
	
	smallest: .asciiz "Smallest: "
	largest: .asciiz "\nLargest: "
	endl: .asciiz "\n"



#exercise 6
 	.text
  	 .globl   main

main:
	li   $t0, 0          # i = 0
	li   $t1, 10          # Read 10 integers
	la   $t2, array      # $t2 points to address of array

loop:
	la   $a0, prompt
	li   $v0, 4
	syscall

   	li   $v0, 5       # Read an integer
   	syscall


   	sw   $v0, 0($t2)       # Store   integer in array[i]
	nop
	nop
   	addi $t2,$t2,4         #go to next element of array
   	addi   $t0, $t0, 1   # i = i + 1
  	blt   $t0, $t1, loop   # If (i < 10) then go to the loop
	nop
	nop
               # ($t0 = 0, $t1 = 10)
	li $t0,0          #i=0
	la   $t2, array      # $t2 points to address of array
print:
   	beq   $t0, $t1, newline   # Check for array end
	nop
	nop
  	lw   $a0, ($t2)   # Print value at the array pointer
	nop
	nop

   	li   $v0, 1
   	syscall
   	la   $a0, space
   	li   $v0, 4
   	syscall
   	addi   $t0, $t0, 1   # Advance loop counter
   	addi   $t2, $t2, 4   # Advance array pointer
   	j print           # Repeat the loop
	nop
	nop
newline:
  	la   $a0, endl
   	li   $v0, 4
   	syscall

	li $t1,5           #will loop 5 times(half the loop size)
   	li $t0,0          #beginning of array pointer
    	la   $t2,array    #beginning of array
   	la $t5,array      #form
   	addi $t5,$t5,36        #end of array
loop2:

   	beq   $t0, $t1, startprint2 # Break from loop if j = 10
	nop
	nop

   	lw   $s1, ($t2)
	nop
	nop
   	lw   $s2, ($t5)
	nop
	nop
   	sw   $s2, ($t2)
	nop
	nop
   	sw   $s1, ($t5)
	nop
	nop
    	addi $t0,$t0,1   #i=i+1
   	addi $t2,$t2,4    #advance beginning of array
  	 addi $t5,$t5,-4   #decrease end of array

   	j loop2
	nop
	nop

startprint2:
	li $t0,0          #i=0
	la   $t2, array      # $t2 points to address of array
	li $t1,10         #times to loop

print2:

   	beq   $t0, $t1, newline2   # Check for array end
	nop
	nop
   	lw   $a0, ($t2)   # Print value at the array pointer
	nop
	nop
   	li   $v0, 1
   	syscall
   	la   $a0, space
   	li   $v0, 4
   	syscall
   	addi   $t0, $t0, 1   # Advance loop counter
  	addi   $t2, $t2, 4   # Advance array pointer
   	j print2           # Repeat the loop
	nop
	nop
newline2:
   	la   $a0, endl
   	li   $v0, 4
   	syscall

end:
   	li   $v0, 10
   	syscall

	.data
	array: .space 40
	prompt: .asciiz "Enter a number: "
	space: .asciiz "\t"
	endl: .asciiz "\n"

