.data
	list_size_prompt: .asciiz "\nMax list size >> "
	menu_prompt: .asciiz "\n-- MIPS List Storage  --\n\n 1 - Add Elements \n 2 - Recover Element \n 3 - Print List \n 4 - Remove Element \n 5 - Exit \n\n>> "
	invalid_option_prompt: .asciiz "\nInvalid Option! Try again.\n"
	exit_prompt: .asciiz "\nFinishing the application!\n"
	add_element_prompt: .asciiz "\nElement to add >> "
	full_list_error_prompt: .asciiz "\n\nThe list is full! Action aborted.\n\n"
	recover_element_prompt: .asciiz "\nElement position >> "
	print_list_prompt: .asciiz "\n-- List --\n"
	new_line: .asciiz "\n"
	
	max_list_size: .word -1
	current_list_size: .word 0
	list: .word
	menu_selection: .word 999
	
.text
	la 	$a0, list_size_prompt
	li 	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
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
		
	la 	$a0, invalid_option_prompt
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
	
	beq	$s0, $s1, add_element_error
	
	la	$a0, add_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	la	$s2, list
	sw 	$v0, 8($s2)
	
	j	loop
	
add_element_error:
	la 	$a0, full_list_error_prompt
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
	la	$a0, print_list_prompt
	li	$v0, 4
	syscall
	
	la 	$s0, list
	li 	$s1, 0
	la	$s2, current_list_size
	lw 	$s2, ($s2)
	
for:
	beq 	$s1, $s2, loop
	li 	$t0, 4

	mul 	$t0, $t0, $s1
	
	add 	$t0, $t0, $s0
	lw 	$a0, 0($t0)	
	jal 	print_element
	
	la 	$a0, new_line
	li 	$v0, 4
	syscall	
	
	addi 	$s1, $s1, 1
	j 	for
	
delete_element:
	la	$a0, recover_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	j	loop

print_element:
	# Execute before to load the INT at $a0
	#la $t0, list_size
	#lw $a0, ($t0)
	
	li 	$v0, 1
	syscall
	
	jr 	$ra

exit:
	la	$a0, exit_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 10
	syscall