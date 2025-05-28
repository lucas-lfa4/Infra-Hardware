.data
    result: .word 0
    promptA: .asciiz "Digite o valor de a: "
    promptB: .asciiz "Digite o valor de b: "
    output:  .asciiz "Resultado: "

.text
.globl main

main:
    li $v0, 4
    la $a0, promptA
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, promptB
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    blt $t0, $t1, salva_a
    bgt $t0, $t1, salva_b

    # a == b
    add $t2, $t0, $t1
    j imprime

salva_a:
    move $t2, $t0
    j imprime

salva_b:
    move $t2, $t1

imprime:
    sw $t2, result

    li $v0, 4
    la $a0, output
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall
