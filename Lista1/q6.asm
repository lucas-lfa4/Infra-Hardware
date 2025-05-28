.data
    dividendo: .word -17
    divisor: .word 3
    
    RESULT: .word 0      # quociente
    REMAINDER: .word 0   # resto
    
    msg_dividendo: .asciiz "Dividendo: "
    msg_divisor: .asciiz "Divisor: "
    msg_result: .asciiz "Quociente (RESULT): "
    msg_remainder: .asciiz "Resto (REMAINDER): "
    newline: .asciiz "\n"

.text
.globl main

main:
    lw $t0, dividendo    # $t0 = dividendo
    lw $t1, divisor      # $t1 = divisor
    
    # verifica divisão por zero
    beq $t1, $zero, erro_divisao_zero
    
    li $v0, 4
    la $a0, msg_dividendo
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 4
    la $a0, msg_divisor
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    
    # 0 = positivo e 1 = negativo
    li $t2, 0
    li $t3, 0
    
    # verifica o sinal do dividendo
    bgez $t0, dividendo_positivo
    li $t3, 1
    neg $t0, $t0
    xori $t2, $t2, 1

dividendo_positivo:
    # verifica sinal do divisor
    bgez $t1, divisor_positivo
    neg $t1, $t1
    xori $t2, $t2, 1

divisor_positivo:
    # faz a divisão subtraindo várias vezes
    li $t4, 0
    move $t5, $t0

loop_divisao:
    # termina se o resto < divisor
    blt $t5, $t1, fim_divisao
    
    sub $t5, $t5, $t1
    
    addi $t4, $t4, 1
    
    j loop_divisao

fim_divisao:
    # ajusta sinal do quociente
    beq $t2, $zero, quociente_positivo
    neg $t4, $t4

quociente_positivo:
    # o resto tem o mesmo sinal do dividendo
    beq $t3, $zero, resto_positivo
    neg $t5, $t5

resto_positivo:
    sw $t4, RESULT
    sw $t5, REMAINDER
    
    li $v0, 4
    la $a0, msg_result
    syscall
    li $v0, 1
    lw $a0, RESULT
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 4
    la $a0, msg_remainder
    syscall
    li $v0, 1
    lw $a0, REMAINDER
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    
    j fim_programa

erro_divisao_zero:
    sw $zero, RESULT
    sw $zero, REMAINDER

fim_programa:
    li $v0, 10
    syscall