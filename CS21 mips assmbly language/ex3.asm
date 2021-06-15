#exercise 3
.data

msg_before: .asciiz "String before conversion"

string: .asciiz "\nin a hole in the ground there lived a hobbit"

msg_after: .asciiz "\nString after conversion"

.text

.globl main

main:

la $a0,msg_before #print message

li $v0,4

syscall

la $a0,string #print string before conversion

li $v0,4

syscall

la $t0,string #loading base address of string
li	$t3, 0 # to bbe used as flag

loop: #continuing loop character by character till end of string

lb $t1,($t0)
nop
beqz $t1,loop_end #condition for loop end

beq $t1,0x20,next_element #checking for space
beq	$t3, 1, next

#addiu $t0,$t0,1 #if space character;then we are going for next character in order to #change it's case

#bgt $t1,'z',next_element #checking for small letter alphabet

#blt $t1,'a',next_element
blt	$t1, 97, next_element
sub $t1,$t1, 32 #if small letter alphabet then changing its case to upper

sb $t1,($t0)
addi	$t0, $t0, 1
j	loop

next:
li	$t3, 1
j	loop
next_element:

addiu $t0,$t0,1 #next character
li	$t3, 0

j loop

loop_end:

la $a0,msg_after #print msg

li $v0,4

syscall

la $a0,string #print string after conversion

li $v0,4

syscall

li $v0,10 #exit

syscall
