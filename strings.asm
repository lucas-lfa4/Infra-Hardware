.globl __main
.ent __main

.data
mensagem: .asciiz "enTRadA"
i: .word 0


.text
__main:
la $a0, mensagem
lw $s0, i          #$s0 carrega o indice do array i
loop:
add $t0, $a0, $s0  #$t0 carrega o endereco de memoria de a[i]
lb $t1, 0($t0)     #$t1 carrega o conteudo de a[i]

#testa pra ve se a string acabou
beq $t1, 0, acabou

#se o bype for menor que 65(A), va para a excecao
li $t2, 65
slt $t2, $t1, $t2
beq $t2, 1, exception
#se o byte for menor ou igual a 90, a letra eh maiuscula
sle $t2, $t1, 90
beq $t2, 1, maiusculo
#se o byte for menor que 97(a), va para a excecao
li $t2, 91
slt $t2, $t1, $t2
beq $t2, 1, exception
#se o byte for menor ou igual a 122, a letra eh minuscula
sle $t2, $t1, 122
beq $t2, 1, minusculo
#caso contrario, eh excecao
j exception


maiusculo:
add $t1, $t1, 32
sb $t1, 0($t0)
add $s0, $s0, 1
j loop

minusculo:
sub $t1, $t1, 32
sb $t1, 0($t0)
add $s0, $s0, 1
j loop

exception:
li $v1, 1
li $v0, 10
syscall

acabou:
li $v0, 4
syscall
li $v0, 10
syscall