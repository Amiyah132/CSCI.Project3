.data
input: .space 1001
error_msg: .asciiz "X"

.text
main:

	li $v0, 8
	la $a0, input
	li $a1, 1001
	syscall

	move $t0, $a0
	addi $sp, $sp, -12
	
next:
	lb $s0, ($t0)
	j check_end

check_end:
	beq $s0, $zero, print
	j loop
sub_a:

	sw $s0,($sp)
	#addi $sp,$sp,-4
	j next

loop: 
	addi $t0, $t0, 1
	beq $s0, 32, next 
	beq $s0, 44 , sub_a
	bge $s0, 97, lower
    	bge $s0, 65, upper
    	bge $s0, 48, number 
	j next 

lower:
	bge $s0, 117, print_error
	addi $s0, $s0, -87
	j sub_a

upper:
	bge $s0, 85, print_error
	addi $s0, $s0, -55
	j sub_a 

number:
	bge $s0, 58, print_error
	addi $s0, $s0, -48
	j sub_a

print_error:
	la $s0, error_msg
	j sub_a

print:
	li $v0, 1
	lw $a0, 12($sp)
	syscall
	lw $a0, 8($sp)
	syscall
	lw $a0, 4($sp)
	syscall
	lw $a0, 0($sp)
	syscall
	j exit
exit:
    
    	li $v0, 10            
    	syscall

