.globl __main
.ent __main

.data
a: .word 0
b: .word 0

.text
__main:
#le a e rmazena na memoria e no registrador a0
li $v0, 5
syscall
sw $v0, a
add $a0, $v0, $zero

#le b e rmazena na memoria e no registrador a1
li $v0, 5
syscall
sw $v0, b
add $a1, $v0, $zero

#se a < 0, armazena 1 no registrador v1 e encerra o programa
slti $t0, $a0, 0
beq $t0, 1, end

j mod

mod:
#se a0 < a1, achou o resultado
slt $t0, $a0, $a1
beq $t0, 1, achou
#caso contrario, $a0 = $a0 + $a1
sub $a0, $a0, $a1
j mod

achou:
li $v0, 1
syscall
li $v0, 10
syscall

end:
li $v1, 1
li $v0, 10
syscall 