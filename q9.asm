.globl __main
.ent __main

.data
str: .asciiz "enTRadA"
aux: .space 40
i: .word 0             #cursor que percorre str
j: .word 0             #outro cursor que guarda a posicao onde vai ser escrita a proxima vogal em str

.text
__main:
la $a0, str
la $a1, aux
lw $s0, i
lw $s1, j

loop:
add $t0, $a0, $s0     #endereco de memoria de str[i]
lb $t1, 0($t0)        #conteudo de str[i]

beq $t1, 0, fim       #testa para ver se nao chegou no '/0'

#teste para ver se nao eh letra
sle $t7, $t1, 64
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


vogalMaiuscula:

vogalMinuscula:

NehLetra:

fim:
