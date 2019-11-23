.data
	list_size_prompt: .asciiz "Tell me the list size: "
	list_size_value_prompt: .asciiz "List size: "	
.text
	la $a0, list_size_prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0

	la $a0, list_size_value_prompt
	li $v0, 4
	syscall
		
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 10
	syscall