.data
	list_size_prompt: .asciiz "\nMax list size >> "
	menu_prompt: .asciiz "\n-- MIPS List Storage  --\n\n 1 - Add Elements \n 2 - Recover Element \n 3 - Print List \n 4 - Remove Element \n 5 - Exit \n\n>> "
	invalid_option_message: .asciiz "\nInvalid Option! Try again.\n"
	exit_message: .asciiz "\nFinishing the application!\n"
	add_element_prompt: .asciiz "\nElement to add >> "
	full_list_error_message: .asciiz "\n\nThe list is full! Action aborted.\n\n"
	recover_element_prompt: .asciiz "\nElement position >> "
	print_list_header: .asciiz "\n-- List --\n"
	new_line: .asciiz "\n"
	
	menu_selection: .word -1
	max_list_size: .word -1
	current_list_size: .word 1
	list: .word
	
.text
	la 	$a0, list_size_prompt
	li 	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	addi 	$v0, $v0, 1
	sw 	$v0, max_list_size
	
loop:		
	jal 	show_menu_and_load_selection
		
	la 	$t0, menu_selection
	lw 	$t0, ($t0)
	
	beq	$t0, 1, add_element
	beq	$t0, 2, recover_element
	beq	$t0, 3, print_list
	beq	$t0, 4, delete_element
	beq	$t0, 5, end_loop
		
	la 	$a0, invalid_option_message
	li 	$v0, 4
	syscall
	
	j 	loop
	
end_loop:
	
	j	exit
	
show_menu_and_load_selection:
	la 	$a0, menu_prompt
	li 	$v0, 4
	syscall

	li 	$v0, 5
	syscall
	sw 	$v0, menu_selection
			
	jr 	$ra
	
add_element:
	la	$s0, current_list_size
	lw 	$s0, ($s0)
	la	$s1, max_list_size
	lw 	$s1, ($s1)
	la	$s2, list
	
	beq	$s0, $s1, add_element_error
	
	la	$a0, add_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	li 	$t0, 4
	mul 	$t0, $t0, $s0
	add 	$t0, $t0, $s2
		
	sw 	$v0, 0($t0)
	addi 	$s0, $s0, 1
	sw	$s0, current_list_size
	
	j	loop
	
add_element_error:
	la 	$a0, full_list_error_message
	li 	$v0, 4
	syscall
		
	j	loop

recover_element:
	la	$a0, recover_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	j	loop
	
print_list:
	la	$a0, print_list_header
	li	$v0, 4
	syscall
	
	la 	$s0, list
	li 	$s1, 1
	la	$s2, current_list_size
	lw 	$s2, ($s2)
	
for:
	beq 	$s1, $s2, loop
	
	li 	$t0, 4
	mul 	$t0, $t0, $s1
	
	add 	$t0, $t0, $s0
	lw 	$a0, 0($t0)	
	jal 	print_int
	
	addi 	$s1, $s1, 1
	j 	for
	
delete_element:
	la	$a0, recover_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	j	loop

print_int:
	# Execute before to load the INT at $a0
	#la $t0, list_size
	#lw $a0, ($t0)
	
	li 	$v0, 1
	syscall
	
	la 	$a0, new_line
	li 	$v0, 4
	syscall	
	
	jr 	$ra

exit:
	la	$a0, exit_message
	li	$v0, 4
	syscall
	
	li 	$v0, 10
	syscall
