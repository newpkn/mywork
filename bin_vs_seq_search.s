.data
sorted_arr: .word -126, -115, -99, -75, -45, -23, -12, 0, 15, 38, 57, 78, 89, 103, 126
arr_size: .word 15

.text
.globl main

main:
    # Initialize registers
    la  x12, sorted_arr     # Load address of sorted_arr into x12
    lw x18, arr_size       # Load the size of the array into a1
    li x19, 89             # Load key value (89) into t0

    # Binary search initialization
    li x13, 0              # left = 0
    add x14, x18, zero      # right = arr_size - 1 (a1 already holds arr_size)
    addi x14, x14, -1
    li x17, 0              # num_step = 0
    li x16, -1             # result = -1

binary_search:
    bgt x13, x14 end_binary_search  # if (left > right) break
    addi x17, x17, 1       # num_step++
    add x15, x13, x14       # mid = left + right
    srai x15, x15, 1       # mid = (left + right) >> 1
    slli x23, x15, 2       # x6 = mid * 4 (word size)
    add x23, x23, a0       # x6 = address of sorted_arr[mid]
    lw x23, 0(x23)         # x6 = sorted_arr[mid]

    beq x23, x0, found_binary_search  # if (sorted_arr[mid] == key) result = mid
    blt x23, x0, update_left         # if (sorted_arr[mid] < key) left = mid + 1
    addi x14, x15, -1       # right = mid - 1
    j binary_search       # continue binary search

update_left:
    addi x13, x15, 1        # left = mid + 1
    j binary_search       # continue binary search

found_binary_search:
    add x17, x15, zero      # result = mid
    j end_binary_search

end_binary_search:
    # Sequential search initialization
    li x20, 0              # num_step_2 = 0
    li x21, -1             # result_2 = -1
    li x22, 0              # i = 0

sequential_search:
    bge x22, x18, end_sequential_search # if (i >= arr_size) break
    slli x23, x22, 2       # x6 = i * 4
    add x23, x23, x0       # x6 = address of sorted_arr[i]
    lw x23, 0(x23)         # x6 = sorted_arr[i]

    beq t6, t0, found_sequential_search  # if (sorted_arr[i] == key) result_2 = i
    addi x22, x22, 1       # i++
    addi x21, x21, 1       # num_step_2++
    j sequential_search  # continue sequential search

found_sequential_search:
    add x20, x22, zero     # result_2 = i

end_sequential_search:
    # Exit the program
    li x24, 10             # syscall number for exit
    ecall