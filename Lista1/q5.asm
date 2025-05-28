.data
    lado1: .word 0
    lado2: .word 0
    lado3: .word 0
    
    # string resultado (4 bytes + null terminator)
    s: .space 5
    
    # strings para classifica��o
    not_triangle: .asciiz "not"
    equilatero: .asciiz "eq"
    isosceles: .asciiz "iso"
    escaleno: .asciiz "esc"

.text
.globl main

main:
    # le os tres valores do usu�rio e armazena na mem�ria
    li $v0, 5
    syscall
    sw $v0, lado1
    
    li $v0, 5
    syscall
    sw $v0, lado2
    
    li $v0, 5
    syscall
    sw $v0, lado3
    
    # carrega os tr�s lados da mem�ria
    lw $t0, lado1        # $t0 = lado1
    lw $t1, lado2        # $t1 = lado2
    lw $t2, lado3        # $t2 = lado3
    
    # verifica se formam um tri�ngulo
    add $t3, $t1, $t2    # $t3 = lado2 + lado3
    bge $t0, $t3, nao_triangulo  # se lado1 >= lado2 + lado3, n�o � tri�ngulo
    
    add $t3, $t0, $t2    # $t3 = lado1 + lado3
    bge $t1, $t3, nao_triangulo  # se lado2 >= lado1 + lado3, n�o � tri�ngulo
    
    add $t3, $t0, $t1    # $t3 = lado1 + lado2
    bge $t2, $t3, nao_triangulo  # se lado3 >= lado1 + lado2, n�o � tri�ngulo
        
    # verifica se � equil�tero
    bne $t0, $t1, verifica_isosceles  # se lado1 != lado2, n�o � equil�tero
    bne $t1, $t2, verifica_isosceles  # se lado2 != lado3, n�o � equil�tero
    
    # � equil�tero
    la $t4, equilatero
    j copia_resultado

verifica_isosceles:
    # verifica se � is�sceles
    beq $t0, $t1, isosceles_encontrado  # lado1 == lado2
    beq $t0, $t2, isosceles_encontrado  # lado1 == lado3
    beq $t1, $t2, isosceles_encontrado  # lado2 == lado3
    
    # ent�o � escaleno
    la $t4, escaleno
    j copia_resultado

isosceles_encontrado:
    la $t4, isosceles
    j copia_resultado

nao_triangulo:
    la $t4, not_triangle

copia_resultado:
    la $t5, s
    
copia_loop:
    lb $t6, 0($t4)
    sb $t6, 0($t5)
    beq $t6, $zero, fim
    addi $t4, $t4, 1
    addi $t5, $t5, 1
    j copia_loop

fim:
    li $v0, 10
    syscall