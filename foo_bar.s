.data
my_string: .string "result is "

.text
main:
addi sp, sp, -8 # allocate 8 bytes on the stack
addi x20, x0, 3 # temp = 3
addi x19, x0, 5 # temp2 = 5
sw x19, 4(sp) # push temp2 to the stack; pass argument temp2
sw x20, 0(sp) # push temp1 to the stack; pass atgument temp1
jal foo # call foo
add x18, x0, a0 # result = value returned form foo
addi sp, sp, 8 # deallocate 8 bytes on the stack

# printf("result is %d\n", result);
addi a0, x0, 4
la a1,my_string
ecall

addi a0, x0, 1
add a1, x0, x18
ecall

#return
lw ra, 0(sp), #
addi sp, sp, 0 #
jr ra #

bar:
addi x19, x0, 0 # i = 0
lw x18, 0(sp) # load n form stack to x18 = n
start_loop:
bge x19, x18, exit_loop # if(i<n) exit_loop
add x20, x20, x19 # sum = sum + i
addi x20, x20, 1 # sum = sum + 1
addi x19, x19, 1 # i++
j start_loop
exit_loop:
add a0, x0, x20
jr ra

foo:
addi x21, x0, 0 # sum = 0
addi x20, x0, 0 # i = 0
lw x19, 4(sp) # load n (argument 2) form stack to x19
start_loop_2:
bge x20, x19, exit_loop_2 # if i >= n goto exit_loop
lw x18, 0(sp) # load x (argument 1) form satck to x18
add x21, x21, x18 # sum += x
addi x20, x20, 1 # i++
j start_loop_2
exit_loop_2:

# save sum and ra to the stack
addi sp, sp, -8 #
sw x21, 4(sp) #
sw ra, 0(sp) #

# pass argument 10 to bar; 10 in x22
addi sp, sp, -4 #
addi x22, x0, 10 #
sw x22, 0(sp) #
jal bar
addi sp, sp, 4 #
lw x21, 4(sp) #

#sum = sim + bar(10)
add x21, x21, a0 #

#place sum to a0
add a0, x21, x0 #

#return
lw ra, 0(sp), #
addi sp, sp, 8 #
jr ra #