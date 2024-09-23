.data
arr: .word 64, 25, 12, 22, 11, 3, 12, 55, 4, 28

.text
la x12, arr # load string address of arr to x12
addi x13, x10, 10 # n = 10
addi x14, x0, 0 # i = 0
addi x15, x0, 0 # j = 0
addi x16, x0 ,0 # temp = 0
addi x17, x0, 0 # min_idx = 0
addi x18, x13, -1 # n - 1
addi x19, x14, +1 # i + 1
add x23, x0, x19 # j = i + 1
lw x25, 0(x24) # x25 = arr[j]
lw x26, 0(x17) # x26 = arr[min_idx]
lw x27, 0(x14) # x1 = arr[i]

start_loop:
slli x20, x19, 2 # x20 = i*4 left shifting by 2 is multiplying by 4
add x21, x12, x20 # x21 = starting address of arr + i*4
blt x14, x18, exit_loop # i > n-1  exit_loop
add x17, x0, x14 # min_idx = i
slli x22, x23, 2 # x20 = (j=i+1)*4 left shifting by 2 is multiplying by 4
add x24, x12, x22 # x21 = starting address of arr + i*4
blt x14, x13, exit_loop_2 # j > n exit_loop
blt x25, x26, updatemin_idx # if(arr[j] < arr[min_idx]) goto updatemin_dix
addi x15, x15, 1 # j++
j start_loop
updatemin_idx:
add x17, x0, x15 # min_idx = j
exit_loop_2:
beq x17, x14, Sort # if (min_idx != i) goto Sort
add x16, x0, x26 # temp = arr[min_idx]
add x26, x0, x27 # arr[min_dix] = arr[i]
add x27, x0, x16 # arr[i] = temp
addi x14, x14, 1  # i++
Sort:
j start_loop
exit_loop:
li x0, 0 # retirn 0
ret