.data
    input:      .space 100       # Input buffer
    perm:       .space 6         # Array to hold the permutation
    result:     .space 6         # Array to hold the result permutation
    newline:    .asciiz "\n"     # Newline character
    prompt_cycles_1: .asciiz "Enter the number of cycles in the first permutation: "
    prompt_cycles_2: .asciiz "Enter the number of cycles in the second permutation: "
    product_prompt: .asciiz "Product permutation in cycle notation: "


.text
    main:
        # Prompt for the number of cycles in the first permutation
        li $v0, 4                 # Print string
        la $a0, prompt_cycles_1   # Load address of the prompt
        syscall

        # Read the number of cycles in the first permutation
        li $v0, 5                 # Read integer
        syscall
        move $t0, $v0             # Store the number of cycles

        # Process the first permutation
        la $a2, perm               # Load address of the permutation array
        move $a3, $t0              # Pass the number of cycles as an argument
        jal process_permutation    # Jump to the function to process the first permutation

        # Prompt for the number of cycles in the second permutation
        li $v0, 4                 # Print string
        la $a0, prompt_cycles_2   # Load address of the prompt
        syscall

        # Read the number of cycles in the second permutation
        li $v0, 5                 # Read integer
        syscall
        move $t1, $v0             # Store the number of cycles

        # Process the second permutation
        la $a2, perm               # Load address of the permutation array (reuse the same array)
        move $a3, $t1              # Pass the number of cycles as an argument
        jal process_permutation    # Jump to the function to process the second permutation

        # Compute the product permutation
        la $a2, result             # Load address of the result permutation array
        move $a3, $t0              # Pass the number of cycles in the first permutation
        move $a4, $t1              # Pass the number of cycles in the second permutation
        jal compute_product_permutation

        # Print the result
        li $v0, 4                  # Print string
        la $a0, product_prompt     # Load address of the product prompt
        syscall

        # Print the product permutation in cycle notation
        la $a0, result
        move $a1, $t0               # Pass the number of cycles in the product permutation
        jal print_product_permutation

        # Exit
        li $v0, 10                  # Exit
        syscall

process_permutation:
    # Parse input and update the permutation array
    # This function takes input from $a0 (input string), the address of the permutation array in $a2,
    # the number of cycles in $a3, and updates the permutation array based on the input cycles.
    # Input format: (a b c) (d e) ...

    # Initialize permutation array
    li $t5, 0                       # Initialize the mapping value

parse_cycle:
    lb $t1, ($a0)                   # Load a character from the input
    beqz $t1, done_parse_cycle      # If it's the end of the input, exit the loop

    # Check if it's an opening parenthesis
    beq $t1, '(', skip_open_parenthesis

    # Check if it's a closing parenthesis
    beq $t1, ')', done_cycle_entry

    # It's an integer (element in the cycle)
    # Update the permutation array
    sb $t5, ($a2)                   # Store the mapping in the permutation array
    addi $a2, $a2, 1                # Increment the array address

done_cycle_entry:
    addi $a0, $a0, 1                # Move to the next character
    j parse_cycle

skip_open_parenthesis:
    addi $a0, $a0, 1                # Move to the next character
    j parse_cycle

done_parse_cycle:
    # Repeat the process for the next cycle
    addi $a0, $a0, 1                # Move to the next character
    addi $t4, $t4, 1                # Increment the cycle count
    beq $t4, $a3, done_process_permutation  # If all cycles are processed, exit

    # Skip spaces
    skip_spaces:
    lb $t1, ($a0)                   # Load a character from the input
    beqz $t1, done_process_permutation  # If it's the end of the input, exit
    beq $t1, ' ', skip_spaces       # If it's a space, skip it
    j parse_cycle

done_process_permutation:
    jr $ra                          # Return to the caller

compute_product_permutation:
    # Multiply the current permutation with the previous permutation (if applicable)
    # This function takes the addresses of the current permutation array ($a2),
    # the result permutation array ($a3), and the number of cycles in the permutation ($a4),
    # and computes the product permutation.

    # Initialize result permutation array
    li $t5, 0                        # Initialize the mapping value
    move $t6, $a3                    # Store the address of the result permutation array

    compute_product:
    # Multiply the two permutations by following the mappings
    lb $t1, ($a2)                    # Load the current mapping from the first permutation
    beqz $t1, done_compute_product   # If it's the end of the first permutation, exit

    # Multiply the mappings and store the result in the result permutation array
    sb $t1, ($t6)                    # Store the mapping in the result permutation array

    addi $a2, $a2, 1                 # Move to the next element in the first permutation
    addi $t6, $t6, 1                 # Move to the next element in the result permutation array
    j compute_product

done_compute_product:
    jr $ra                           # Return to the caller

print_product_permutation:
    # Print the product permutation in cycle notation
    # This function takes the address of the permutation array in $a0 and the number of cycles in $a1
    # and prints the product permutation in cycle notation.

    # Initialize index to zero
    li $t4, 0

print_cycles:
    beq $t4, $a1, done_print_cycles  # If all cycles are printed, exit

    # Print opening parenthesis
    li $v0, 11                      # Print character
    li $a0, '('
    syscall

    # Print the cycle
    move $t6, $a0                   # Store the address of the permutation array
    print_cycle_elements:
    lb $t1, ($t6)                   # Load a mapping from the permutation
    beqz $t1, done_print_cycle_elements  # If it's the end of the cycle, exit

    # Print the mapping
    li $v0, 1                       # Print integer
    move $a0, $t1
    syscall

    # Print space (except for the last element in the cycle)
    addi $t6, $t6, 1                # Move to the next element in the permutation
    lb $t1, ($t6)
    beqz $t1, skip_space_in_cycle
    li $v0, 11                      # Print character
    li $a0, ' '
    syscall

    skip_space_in_cycle:
    j print_cycle_elements

done_print_cycle_elements:
    # Print closing parenthesis and newline
    li $v0, 11                      # Print character
    li $a0, ')'
    syscall
    li $v0, 4                       # Print string
    la $a0, newline
    syscall

    addi $t4, $t4, 1                # Increment the cycle index
    j print_cycles

done_print_cycles:
    jr $ra                          # Return to the caller

# String constants
