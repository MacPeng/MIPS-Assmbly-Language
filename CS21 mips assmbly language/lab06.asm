#
# lab06.asm
# Nickolas Alcazar, Yiming Peng
# Lab 6
# Stack exercises.
#

	.data
		buffer1:		.space 100
		buffer2:		.space 100
	.text
	.globl main

main:	# Exercise 1 #####################################################
		# Read in string input
		la		$a0, buffer1
		ori		$v0, $zero, 8
		syscall

		ori		$t2, $zero, 10				# t2 = 10 = "line feed" char

		# Push NULL char
		addiu	$sp, $sp, -4				# sp -= 4
		sw		$zero, 0($sp)

		# Push chars
		or		$t0, $zero, $zero
		lb		$t1, buffer1($t0)			# t1 = *(buffer1 + t0)
push_chars1:
		addiu	$sp, $sp, -4				# sp -= 4
		sw		$t1, 0($sp)					# *sp = t1
		addiu	$t0, $t0, 1					# t0++
		lb		$t1, buffer1($t0)			# t1 = *(buffer1 + t0)
		nop
		bne		$t1, $t2, push_chars1		# if (t1 != NUL) { loop }
		nop

		# Pop chars
		or		$t0, $zero, $zero			# t0 = 0
		lw		$t1, 0($sp)					# t1 = *sp
		addiu	$sp, $sp, 4					# sp += 4
pop_chars1:
		sb		$t1, buffer1($t0)			# *(buffer1 + t0) = t1
		addiu	$t0, $t0, 1					# t0++

		lw		$t1, 0($sp)					# t1 = *sp
		addiu	$sp, $sp, 4					# sp += 4
		bne		$t1, $zero, pop_chars1		# if (t1 != NUL) { loop }
		nop

		# Print modified string
		ori		$v0, $zero, 4
		la		$a0, buffer1
		syscall

		# Reset registers
		or		$t0, $zero, $zero
		or		$t1, $zero, $zero
		or		$t2, $zero, $zero


		# Exercise 2 #####################################################
		# t0 = length
		# t1 = buffer2 address

		# Read in string input
		la		$a0, buffer2
		ori		$v0, $zero, 8
		syscall

		# Scan string to find length
		subu	$t0, $zero, 3				# length = t0 = -3 (offset)
		la		$t1, buffer2
		or		$t2, $zero, $zero			# i = t2 = 0
find_length:
		addiu	$t0, $t0, 1					# length++
		lb		$t3, buffer2($t2)			# t3 = *(buffer2 + i)
		addiu	$t2, $t2, 1					# i++
		bne		$t3, $zero, find_length		# if (t3 != NUL) { continue }
		nop

		# Push NUL char
		addiu	$sp, $sp, -4				# sp -= 4
		sw		$zero, 0($sp)				# *sp = NUL

		# Push chars
		or		$t2, $zero, $t0				# i = length

		ori		$t4, $zero, 'a'
		ori		$t5, $zero, 'e'
		ori		$t6, $zero, 'i'
		ori		$t7, $zero, 'o'
		ori		$t8, $zero, 'u'
		
push_chars2:
		lb		$t3, buffer2($t2)			# t3 = *(buffer2 + i)
		nop

		# if (t3 = vowel) { skip }
		beq		$t3, $t4, increment
		beq		$t3, $t5, increment
		beq		$t3, $t6, increment
		beq		$t3, $t7, increment
		beq		$t3, $t8, increment

		# else { push t3 to stack }
		addiu	$sp, $sp, -4				# sp -= 4
		sw		$t3, 0($sp)					# *sp = t3

increment:
		# Replace $t3 with with NUL
		sb		$zero, buffer2($t2)			# *(buffer2 + i) = NUL

		addiu	$t2, $t2, -1				# i--
		bgez	$t2, push_chars2			# if (i >= 0) { continue }
		nop

		or		$t2, $zero, $zero			# i = t2 = 0
pop_chars2:
		lw		$t3, 0($sp)					# *sp = t3
		addiu	$sp, $sp, 4					# sp += 4

		sb		$t3, buffer2($t2)			# t3 = *(buffer2 + i)
		addiu	$t2, $t2, 1					# i++
		bne		$t2, $t0, pop_chars2		# if (i != length) { continue }
		nop

		# Print modified string
		ori		$v0, $zero, 4
		la		$a0, buffer2
		syscall

		# Exit program
		ori		$v0, $zero, 10
		syscall
