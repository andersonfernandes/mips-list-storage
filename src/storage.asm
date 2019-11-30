.data
	list_size_prompt: .asciiz "Tell me the list size: "
	menu_prompt: .asciiz "-- MIPS List Storage  --\n\n 1 - Add Elements \n 2 - Recover Element \n 3 - Print List \n 4 - Remove Element \n 5 - Exit \n\n >> "
	
	add_element_prompt: .asciiz "Element to add >> "
	
	
	list_size: .word -1
	menu_selection: .word 999
.text

main:
	la 	$a0, list_size_prompt
	li 	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	sw 	$v0, list_size
	
	loop:
		jal 	show_menu_and_load_selection
		
		la 	$t0, menu_selection
		lw 	$t0, ($t0)
	
		beq	$t0, 1, add_element
		beq	$t0, 5, end_loop
	
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
	la	$a0, add_element_prompt
	li	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	j	loop

exit:
	li 	$v0, 10
	syscall
	
	#Print INT
	#la $t0, list_size
	#lw $a0, ($t0)
	#li $v0, 1
	#syscall
	#Print INT
