.data
my_String1:  .string "-"
my_String2:  .string "- "
new_line:    .string "\n"

.text
.globl main

ruler_draw:
    addi sp, sp, -64      # Allocate 16 bytes on the stack
    sw ra, 12(sp)         # Save return address
    sw a0, 8(sp)          # Save n
    li x20, 1             # x20 = 1

    beq a0, x20, base_case # if n == 1, go to base_case

    lw a0, 8(sp)          # Load n
    addi a0, a0, -1       # n - 1
    jal ruler_draw        # Recursive call

base_case:
    # Print "-"
    li a0, 4              # syscall for print_string
    la a1, my_String1     # Load address of "-"
    ecall

    # Print newline
    li a0, 4              # syscall for print_string
    la a1, new_line       # Load address of "\n"
    ecall

    # Load n from stack
    lw a0, 8(sp)          # Load n again
    li x18, 0             # i = 0

print_loop:
    bge x18, a0, print_newline # if i >= n, print newline
    li a0, 4              # syscall for print_string
    la a1, my_String2     # Load address of "- "
    ecall
    addi x18, x18, 1      # i++
    j print_loop          # Repeat the loop

print_newline:
    li a0, 4              # syscall for print_string
    la a1, new_line       # Load address of "\n"
    ecall

    lw ra, 12(sp)         # Restore return address
    lw a0, 8(sp)          # Load n again
    addi sp, sp, 64       # Deallocate stack
    addi a0, a0, -1       # n - 1
    jal ruler_draw        # Recursive call again
    jr ra                 # Return

main:
    li a0, 1              # Start with n = 1
    li x19, 4             # Set depth for the ruler
main_loop:
    beq x19, x0, end      # If depth is 0, exit
    jal ruler_draw        # Call ruler_draw
    addi x19, x19, -1     # Decrease depth
    j main_loop           # Repeat

end:
    li a0, 10             # syscall for exit
    ecall                 # Exit program
    jr ra