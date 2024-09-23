.data
my_String1:  .string "Factorial of "
my_String2:  .string " is "
new_line:    .string "\n"

.text
.globl fact
.globl main

fact:
    addi sp, sp, -16        allocate 16 bytes on the stack
    sw ra, 12(sp)
    sw a0, 8(sp)

    beq a0, zero, return_one  # ถ้า n == 0, คืนค่า 1
    addi x19, a0, -1       # x19 = n - 1
    mv a0, x19             # n = n - 1
    jal fact               # call fact(n - 1)
    
    lw x19, 8(sp)
    mul a0, a0, x19        # result = fact(n-1) * n
    j exit

return_one:
    li a0, 1               # reutrn 1

exit:
    lw ra, 12(sp)
    addi sp, sp, 16
    ret

main:
    addi sp, sp, -16        # allocate 16 bytes on the stack
    sw ra, 12(sp)
    addi x18, x0, 0         # i = 0
    addi x20, x0, 9         # x20 = 9

loop:
    bge x18, x20, exit_loop # if i >= 9, exit_loop
    mv a0, x18              # move i to fact
    call fact               # result = fact(i)
    mv x23, a0              # move result to x23

    # พิมพ์ "Factorial of "
    addi a0, x0, 4
    la a1, my_String1
    ecall

    # พิมพ์ i
    addi a0, x0, 1
    add a1, x0, x18
    ecall

    # พิมพ์ " is "
    addi a0, x0, 4
    la a1, my_String2
    ecall

    # พิมพ์ result
    addi a0, x0 1
    add a1, x0, x23
    ecall

    # พิมพ์ newline
    addi a0, x0, 4
    la a1, new_line
    ecall

    addi x18, x18, 1        # i++
    j loop

exit_loop:
    lw ra, 12(sp)           # return address
    addi sp, sp, 16         # allocate 16 bytes on the stack
    li a0, 0                # return 0
    ret