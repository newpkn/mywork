.data
my_string: .string "my_fib = "
my_string2: .string "my_num = "
new_line: .string "\n"

.text
main:
addi x18, x0, 4 # my_num = 4
addi sp, sp, -4 # allocate 4 bytes on the stack
sw x18, 0(sp) # save my_num (x18) on to the stack
addi sp, sp, -4 # allocate 4 bytes on the stack
addi x20, x0, 12 # temp = 12
sw x20, 0(sp) # push temp; pass temp arg fo fib_iter
jal fib_iter # call fib_iter function

add x19, x0, a0 # my_fib = return value form fib_iter
addi sp, sp, 4 # deallocate 4 byte on the stack
lw x18, 0(sp) #restore my_num (x18)
addi x18, x18, 1 # my_num++
addi sp, sp, 4 # deallocat on the stack

addi a0, x0, 4
la a1,my_string
ecall

addi a0, x0, 1
add a1, x0, x19
ecall


addi a0, x0, 4
la a1, new_line
ecall

addi a0, x0, 4
la a1, my_string2
ecall

addi a0, x0, 1
add a1, x0, x18
ecall

addi a0, x0, 4
la a1, new_line
ecall

#return 0 in main
addi a0, x0, 10 # put cold 10 in a0
add a1, x0, x0 #
ecall

fib_iter:
addi x19, x0, 0 # curr_fib = 0
addi x20, x0, 1 # next_fib = 1
lw x18, 0(sp) # get n form the stack
add x22 x0, x18 # i = n
start_loop:
ble x22, x0, exit_loop # if i<= 0 goto exit_loop
add x21, x19, x20 # new_fib = cuur_fib + next_fib
add x19, x20, x0 # curr_fib = next_fib
add x20, x21 x0 # next_fib = new_fib
addi x22, x22, -1 # i--
j start_loop

exit_loop:
add a0, x19, x0 # move x19 value to a0 preparing to return
jr ra