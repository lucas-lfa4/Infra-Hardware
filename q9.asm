.globl __main
.ent __main

.data
str: .asciiz "SaIda"
aux: .space 40
i: .word 0             #cursor que percorre str
jota: .word 0          #outro cursor que guarda a posicao onde vai ser escrita a proxima vogal em str
k: .word 0             #cursor que percorre aux
mensagem1: .asciiz "Passei no vogalMaiuscula"
mensagem2: .asciiz "Passei no vogalMinuscula"
mensagem3: .asciiz "Passei no consoanteMaiuscula"
mensagem4: .asciiz "Passei no consoanteMinuscula"

.text
__main:
la $a0, str            #endereco de memoria de str[0]
la $a1, aux            #endereco de memoria de aux[0]
lw $s0, i
lw $s1, jota
lw $s2, k

loop:
add $t0, $a0, $s0      #endereco de memoria de str[i]
lb $t1, 0($t0)         #conteudo de str[i]

beq $t1, 0, fim        #testa para ver se nao chegou no '/0'

#teste para ver se nao eh letra
sle $t7, $t1, 64
beq $t7, 1, NehLetra

li $t7, 123
slt $t7, $t7, $t1
beq $t7, 1, NehLetra

sle $t7, $t1, 96
li $t6, 91
sle $t6, $t6, $t1
and $t7, $t7, $t6
beq $t7, 1, NehLetra

#teste para ver se a letra eh vogal e maiuscula
beq $t1, 65, vogalMaiuscula
beq $t1, 69, vogalMaiuscula
beq $t1, 73, vogalMaiuscula
beq $t1, 79, vogalMaiuscula
beq $t1, 85, vogalMaiuscula

#teste para ver se a letra eh vogal e minuscula
beq $t1, 97, vogalMinuscula
beq $t1, 101, vogalMinuscula
beq $t1, 105, vogalMinuscula
beq $t1, 111, vogalMinuscula
beq $t1, 117, vogalMinuscula

sle $t7, $t1, 90
beq $t7, 1, consoanteMaiuscula
j consoanteMinuscula


vogalMaiuscula:
add $t2, $a0, $s1       #endereco de memoria de str[j]
sb $t1, 0($t2)

addi $s0, $s0, 1
addi $s1, $s1, 1

j loop

vogalMinuscula:
subi $t1, $t1, 32
add $t2, $a0, $s1       #endereco de memoria de str[j]
sb $t1, 0($t2)          #armazena o valor de str[i] em str[j]

addi $s0, $s0, 1
addi $s1, $s1, 1

j loop

consoanteMaiuscula:
addi $t1, $t1, 32
add $t2, $a1, $s2       #endereco de memoria de aux[k]
sb $t1, 0($t2)          #armazena o valor de str[i] em aux[k]

addi $s0, $s0, 1
addi $s2, $s2, 1

j loop

consoanteMinuscula:
add $t2, $a1, $s2       #endereco de memoria de aux[k]
sb $t1, 0($t2)          #armazena o valor de str[i] em aux[k]

addi $s0, $s0, 1
addi $s2, $s2, 1

j loop

NehLetra:
li $v1, 1
li $v0, 10
syscall

fim:
li $t3, 0
loop2:
slt $t1, $t3, $s2
beq $t1, 0, acabou
add $t1, $a1, $t3
lb $t2, 0($t1)
add $t1, $a0, $s1
sb $t2, 0($t1)

addi $s1, $s1, 1
addi $t3, $t3, 1
j loop2

acabou:
la $a0, str
li $v0, 4
syscall
li $v0, 10
syscall

