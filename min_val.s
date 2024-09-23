.data
arr: .word 64, 25, 12, 22, 11, 3, 12, 55, 4, 28

.text
la x12, arr # load staring address of arr to x12
addi x13, x10, 10 # n = 10
addi x15, x0, 0 # min_val = 0
addi x14, x0, 0 # i = 0
lw x15, 0(x12) # min_val = arr[0]

start_loop:

slli x20, x14, 2 # x20 = i*4 left shifting by 2 is multiplying by 4
add x21, x12, x20 # x21 = starting address of arr + i*4
bge x14, x13, exit_loop # arr[i] >= min_nal exit_loop
lw  x22, 0(x21) # x22 = arr[i]
blt x22, x15, update_min  #if(arr[i] < min_val) goto update_min
addi x14, x14, 1 # i++
j start_loop
update_min:
mv x15, x22 # min_val = arr[i]
j start_loop
exit_loop:
li x0, 0 #return 0
ret