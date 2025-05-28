.globl __main
.ent __main

.data
b: .word 2
res: .word 1

.text
__main:
li $v0, 5
syscall

lw $a0, res
loop: beq $v0, $zero, end
sll $a0, $a0, 1
subi $v0, $v0, 1
j loop

end:
addi $v0, $v0, 1
syscall