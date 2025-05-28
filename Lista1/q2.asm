.data
    result_perfect_square: .word 0
    result_not_perfect: .word 0

.text
.globl main

main:
    # Ler número (a)
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 = a

    li $t1, 0            # $t1 = b (flag)
    li $t2, 0            # $t2 = i

loop:
    beq $t2, 10, fim     # se i == 10, fim do loop

    mul $t3, $t2, $t2    # t3 = i * i
    beq $t3, $t0, quadrado

    addi $t2, $t2, 1     # i++
    j loop

quadrado:
    li $t1, 1            # b = 1
    sw $t0, result_perfect_square
    j fim

fim:
    beq $t1, 0, nao_quadrado
    j fim_programa

nao_quadrado:
    sw $t0, result_not_perfect

fim_programa:
    li $v0, 10
    syscall
