.file "code.c"                    # Source file name
.text                            # Start of the code section
.globl calculateFrequency         # calculateFrequency is a global name
.type calculateFrequency, @function # Define calculateFrequency as a function

calculateFrequency:              # Function calculateFrequency starts
.LFB0:                           # Label for the beginning of the function
.cfi_startproc                   
endbr64                          # End Branch instruction
pushq %rbp                       # Save the value of the base pointer
.cfi_def_cfa_offset 16           # Define CFA offset
.cfi_offset 6, -16               # Save the old value of %rbp in the CFI data
movq %rsp, %rbp                  # Set the current stack pointer as the base pointer
.cfi_def_cfa_register 6          # Define CFA register
movq %rdi, -24(%rbp)             # Save the first function argument at -24(%rbp)
movl %esi, -28(%rbp)             # Save the second function argument at -28(%rbp)
movq %rdx, -40(%rbp)             # Save the third function argument at -40(%rbp)
movl $0, -12(%rbp)               # Initialize a local variable to store frequency (counter) to 0
jmp .L2                          # Jump to label .L2 to start the loop

.L7:                             # Start of a loop to compare elements in the array
movl $1, -4(%rbp)                # Set a temporary counter variable to 1
movl -12(%rbp), %eax             # Load the value of the counter variable into %eax
addl $1, %eax                    # Increment the counter by 1
movl %eax, -8(%rbp)              # Store the updated counter value at -8(%rbp)
jmp .L3                          # Jump to label .L3 to continue the loop

.L5:                             # Loop to compare elements
movl -12(%rbp), %eax             # Load the value of the counter variable into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -24(%rbp), %rax             # Load the array pointer into %rax
addq %rdx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %edx                # Load the value of the current element into %edx
movl -8(%rbp), %eax              # Load the value of the temporary counter variable into %eax
cltq                             # Sign-extend %eax to %rcx
leaq 0(,%rax,4), %rcx            # Calculate the offset for the array access (%rcx = 4 * %rax)
movq -24(%rbp), %rax             # Load the array pointer into %rax
addq %rcx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %eax                # Load the value of the current element into %eax
cmpl %eax, %edx                  # Compare the current element with the previous one
jne .L4                          # Jump to label .L4 if the elements are different
addl $1, -4(%rbp)                # Increment the temporary counter by 1
movl -8(%rbp), %eax              # Load the value of the temporary counter variable into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -40(%rbp), %rax             # Load the array pointer into %rax
addq %rdx, %rax                  # Calculate the address of the current element in the array
movl $0, (%rax)                  # Store 0 at the address of the current element in the array
.L4:                             # End of loop to compare elements
addl $1, -8(%rbp)                # Increment the temporary counter by 1

.L3:                             # Loop condition check
movl -8(%rbp), %eax              # Load the value of the temporary counter variable into %eax
cmpl -28(%rbp), %eax             # Compare the counter with the length of the array
jl .L5                           # Jump to label .L5 if the counter is less than the array length

movl -12(%rbp), %eax             # Load the value of the counter variable into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -40(%rbp), %rax             # Load the array pointer into %rax
addq %rdx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %eax                # Load the value of the current element into %eax
testl %eax, %eax                 # Test if the value of the current element is 0
je .L6                           # Jump to label .L6 if the value is 0
movl -12(%rbp), %eax             # Load the value of the counter variable into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -40(%rbp), %rax             # Load the array pointer into %rax
addq %rax, %rdx                  # Calculate the address of the current element in the array
movl -4(%rbp), %eax              # Load the value of the temporary counter variable into %eax
movl %eax, (%rdx)                # Store the value of the counter at the address of the current element in the array

.L6:                             # Label .L6, end of loop
addl $1, -12(%rbp)               # Increment the counter by 1

.L2:                             # Loop condition check
movl -12(%rbp), %eax             # Load the value of the counter variable into %eax
cmpl -28(%rbp), %eax             # Compare the counter with the length of the array
jl .L7                           # Jump to label .L7 if the counter is less than the array length

nop                              # No operation
nop                              # No operation
popq %rbp                        # Restore the base pointer
.cfi_def_cfa 7, 8                # Define CFA for the return address
ret                              # Return from the function
.cfi_endproc                     # End of the function calculateFrequency

.LFE0:                           # End of the calculateFrequency function

.size calculateFrequency, .-calculateFrequency  # Size of the calculateFrequency function

.section .rodata                 # Start of read-only data section
.LC0:                            # Label for the first string
.string "Element\tFrequency"     # String: "Element Frequency"
.LC1:                            # Label for the second string
.string "%d\t%d\n"               # String: "%d %d\n"

.text                            # Return to the code section
.globl printArrayWithFrequency    # printArrayWithFrequency is a global name
.type printArrayWithFrequency, @function # Define printArrayWithFrequency as a function

printArrayWithFrequency:         # Function printArrayWithFrequency starts
.LFB1:                           # Label for the beginning of the function
.cfi_startproc                   # Call Frame Information (CFI) indicating start of the procedure
endbr64                          # End Branch instruction (for control flow enforcement)
pushq %rbp                       # Save the value of the base pointer
.cfi_def_cfa_offset 16           # Define CFA offset
.cfi_offset 6, -16               # Save the old value of %rbp in the CFI data
movq %rsp, %rbp                  # Set the current stack pointer as the base pointer
.cfi_def_cfa_register 6          # Define CFA register
subq $48, %rsp                   # Allocate space on the stack for local variables
movq %rdi, -24(%rbp)             # Save the first function argument at -24(%rbp)
movq %rsi, -32(%rbp)             # Save the second function argument at -32(%rbp)
movl %edx, -36(%rbp)             # Save the third function argument at -36(%rbp)
leaq .LC0(%rip), %rax            # Load the address of the first string into %rax
movq %rax, %rdi                  # Set the address of the first string as the first function argument
call puts@PLT                    # Call the puts function to print the string
movl $0, -4(%rbp)                # Initialize a loop counter to 0
jmp .L9                          # Jump to label .L9 to start the loop

.L11:                            # Start of a loop to print the array elements with frequency
movl -4(%rbp), %eax              # Load the value of the loop counter into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -32(%rbp), %rax             # Load the array pointer into %rax
addq %rdx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %eax                # Load the value of the current element into %eax
testl %eax, %eax                 # Test if the value of the current element is 0
je .L10                          # Jump to label .L10 if the value is 0
movl -4(%rbp), %eax              # Load the value of the loop counter into %eax
cltq                             # Sign-extend %eax to %rdx
leaq 0(,%rax,4), %rdx            # Calculate the offset for the array access (%rdx = 4 * %rax)
movq -32(%rbp), %rax             # Load the array pointer into %rax
addq %rdx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %edx                # Load the value of the current element into %edx
movl -4(%rbp), %eax              # Load the value of the loop counter into %eax
cltq                             # Sign-extend %eax to %rcx
leaq 0(,%rax,4), %rcx            # Calculate the offset for the array access (%rcx = 4 * %rax)
movq -24(%rbp), %rax             # Load the array pointer into %rax
addq %rcx, %rax                  # Calculate the address of the current element in the array
movl (%rax), %eax                # Load the value of the current element into %eax
movl %eax, %esi                  # Move the value of %eax to %esi (second argument for printf)
leaq .LC1(%rip), %rax            # Load the address of the second string into %rax
movq %rax, %rdi                  # Set the address of the second string as the first function argument
movl $0, %eax                    # Set %eax to 0 (first argument for printf)
call printf@PLT                  # Call the printf function to print the element and its frequency

.L10:                            # End of loop to print array elements with frequency
addl $1, -4(%rbp)                # Increment the loop counter by 1

.L9:                             # Loop condition check
movl -4(%rbp), %eax              # Load the value of the loop counter into %eax
cmpl -36(%rbp), %eax             # Compare the loop counter with the array length
jl .L11                          # Jump to label .L11 if the loop counter is less than the array length

nop                              # No operation
nop                              # No operation
leave                            # Restore the stack and base pointers
.cfi_def_cfa 7, 8                # Define CFA for the return address
ret                              # Return from the function
.cfi_endproc                     # End of the function printArrayWithFrequency

.LFE1:                           # End of the printArrayWithFrequency function

.size printArrayWithFrequency, .-printArrayWithFrequency # Size of the printArrayWithFrequency function

.section .rodata                 # Start of read-only data section
.align 8
.LC2:
.string "\n\nCount frequency of each integer element of an array:" # String: "\n\nCount frequency of each integer element of an array:"
.align 8
.LC3:
.string "------------------------------------------------"          # String: "------------------------------------------------"
.align 8
.LC4:
.string "Input the number of elements to be stored in the array :" # String: "Input the number of elements to be stored in the array :"
.LC5:
.string "%d"                                                      # String: "%d"
.align 8
.LC6:
.string "Enter each elements separated by space: "                # String: "Enter each elements separated by space: "

.text                            # Return to the code section
.globl main                       # main function is a global name
.type main, @function             # Define main as a function

main:                            # Main function starts
.LFB2:                           # Label for the beginning of the function
.cfi_startproc                   # Call Frame Information (CFI) indicating start of the procedure
endbr64                          # End Branch instruction (for control flow enforcement)
pushq %rbp                       # Save the value of the base pointer
.cfi_def_cfa_offset 16           # Define CFA offset
.cfi_offset 6, -16               # Save the old value of %rbp in the CFI data
movq %rsp, %rbp                  # Set the current stack pointer as the base pointer
.cfi_def_cfa_register 6          # Define CFA register
subq $832, %rsp                  # Allocate space on the stack for local variables
movq %fs:40, %rax                # Load the value of the FS segment register into %rax (for stack smashing protection)
movq %rax, -8(%rbp)              # Save the value in the stack

xorl %eax, %eax                  # Clear the value of %eax (setting it to 0)
leaq .LC2(%rip), %rax            # Load the address of the first string into %rax
movq %rax, %rdi                  # Set the address of the first string as the first function argument
call puts@PLT                    # Call the puts function to print the string
leaq .LC3(%rip), %rax            # Load the address of the second string into %rax
movq %rax, %rdi                  # Set the address of the second string as the first function argument
call puts@PLT                    # Call the puts function to print the string
leaq .LC4(%rip), %rax            # Load the address of the third string into %rax
movq %rax, %rdi                  # Set the address of the third string as the first function argument
movl $0, %eax                    # Set %eax to 0 (first argument for printf)
call printf@PLT                  # Call the printf function to print the string

leaq -828(%rbp), %rax            # Load the address of a buffer for storing the array size into %rax
movq %rax, %rsi                  # Set the address of the buffer as the second function argument
leaq .LC5(%rip), %rax            # Load the address of the fourth string into %rax
movq %rax, %rdi                  # Set the address of the fourth string as the first function argument
movl $0, %eax                    # Set %eax to 0 (first argument for printf)
call __isoc99_scanf@PLT          # Call the scanf function to read the array size

leaq .LC6(%rip), %rax            # Load the address of the fifth string into %rax
movq %rax, %rdi                  # Set the address of the fifth string as the first function argument
movl $0, %eax                    # Set %eax to 0 (first argument for printf)
call printf@PLT                  # Call the printf function to print the string

movl $0, -824(%rbp)              # Initialize a loop counter for reading array elements to 0
jmp .L13                         # Jump to label .L13 to start the loop

.L14:                            # Start of a loop to read the array elements
leaq -816(%rbp), %rdx            # Load the address of the buffer for reading the array element into %rdx
movl -824(%rbp), %eax            # Load the value of the loop counter into %eax
cltq                             # Sign-extend %eax to %rdx
salq $2, %rax                    # Multiply %rax by 4 (since each element is an integer)
addq %rdx, %rax                  # Calculate the address of the current element in the buffer
movq %rax, %rsi                  # Set the address of the current element as the second function argument
leaq .LC5(%rip), %rax            # Load the address of the sixth string into %rax
movq %rax, %rdi                  # Set the address of the sixth string as the first function argument
movl $0, %eax                    # Set %eax to 0 (first argument for printf)
call __isoc99_scanf@PLT          # Call the scanf function to read the current element
addl $1, -824(%rbp)              # Increment the loop counter by 1

.L13:                            # Loop condition check
movl -824(%rbp), %eax            # Load the value of the loop counter into %eax
cmpl -828(%rbp), %eax            # Compare the loop counter with the array size
jl .L14                          # Jump to label .L14 if the loop counter is less than the array size

movl $0, -820(%rbp)              # Initialize a loop counter for initializing array elements to 0
jmp .L15                         # Jump to label .L15 to start the loop

.L16:                            # Start of a loop to initialize array elements to -1
movl -820(%rbp), %eax            # Load the value of the loop counter into %eax
cltq                             # Sign-extend %eax to %rdx
movl $-1, -416(%rbp,%rax,4)      # Store -1 at the address of the current element in the array
addl $1, -820(%rbp)              # Increment the loop counter by 1

.L15:                            # Loop condition check
movl -820(%rbp), %eax            # Load the value of the loop counter into %eax
cmpl -828(%rbp), %eax            # Compare the loop counter with the array size
jl .L16                          # Jump to label .L16 if the loop counter is less than the array size

movl -828(%rbp), %ecx            # Load the value of the array size into %ecx
leaq -416(%rbp), %rdx            # Load the address of the buffer for storing the array into %rdx
leaq -816(%rbp), %rax            # Load the address of the buffer for reading the array into %rax
movl %ecx, %esi                  # Set the value of the array size as the second function argument
movq %rax, %rdi                  # Set the address of the buffer for reading the array as the first function argument
call calculateFrequency         # Call the calculateFrequency function to count the frequency of each element

movl -828(%rbp), %edx            # Load the value of the array size into %edx
leaq -416(%rbp), %rcx            # Load the address of the buffer for storing the array into %rcx
leaq -816(%rbp), %rax            # Load the address of the buffer for reading the array into %rax
movq %rcx, %rsi                  # Set the address of the buffer for storing the array as the second function argument
movq %rax, %rdi                  # Set the address of the buffer for reading the array as the first function argument
call printArrayWithFrequency     # Call the printArrayWithFrequency function to print the array elements with frequency

movl $0, %eax                    # Set %eax to 0 (return value of the main function)
movq -8(%rbp), %rdx              # Load the saved value of the FS segment register into %rdx
subq %fs:40, %rdx                # Compare the current value of the FS segment register with the saved value
je .L18                          # Jump to label .L18 if they are equal
call __stack_chk_fail@PLT        # Call the stack smashing protection function

.L18:                            # Label .L18, end of the main function
leave                            # Restore the stack and base pointers
.cfi_def_cfa 7, 8                # Define CFA for the return address
ret                              # Return from the function
.cfi_endproc                     # End of the main function

.LFE2:                           # End of the main function

.size main, .-main               # Size of the main function

.ident "GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"   # Compiler identification

.section .note.GNU-stack,"",@progbits       # Stack information for the linker
.section .note.gnu.property,"a"             # GNU property section for linker optimization
.align 8
.long 1f - 0f                               
.long 4f - 1f                               
.long 5                                     
0:
.string "GNU"                               
1:
.align 8
.long 0xc0000002                            
.long 3f - 2f                               
2:
.long 0x3                                   
3:
.align 8
4:
