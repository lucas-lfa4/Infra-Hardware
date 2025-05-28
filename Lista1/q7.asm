.data
a:      .word 1, 15, 27, 88, 125, 138       # Array de entrada (exemplo)
a_size: .word 6                              # Tamanho do array a
b:      .space 100                           # Array de saída (máx 25 elementos, pois 22^3 > 10000)
b_size: .word 0                              # Tamanho do array b (inicializado com 0)

.text
.globl main

main:
    la $s0, a                # $s0 = endereço base de a
    la $s1, b                # $s1 = endereço base de b
    lw $s2, a_size           # $s2 = tamanho de a
    lw $s3, b_size           # $s3 = tamanho de b (inicialmente 0)
    
    li $t0, 0                # $t0 = índice i (para percorrer a)
    
loop_a:
    bge $t0, $s2, end_loop_a # Se i >= tamanho de a, termina
    sll $t1, $t0, 2          # $t1 = i * 4 (deslocamento em bytes)
    add $t1, $s0, $t1        # $t1 = endereço de a[i]
    lw $a0, 0($t1)           # $a0 = a[i] (argumento para is_perfect_cube)
    
    jal is_perfect_cube      # Chama a função que verifica se é cubo perfeito
    beq $v0, $zero, not_cube # Se não for cubo perfeito, pula
    
    # Se for cubo perfeito, adiciona em b
    sll $t2, $s3, 2          # $t2 = b_size * 4 (deslocamento em bytes)
    add $t2, $s1, $t2        # $t2 = endereço de b[b_size]
    sw $a0, 0($t2)           # b[b_size] = a[i]
    addi $s3, $s3, 1         # Incrementa b_size
    
not_cube:
    addi $t0, $t0, 1         # Incrementa i
    j loop_a
    
end_loop_a:
    sw $s3, b_size           # Atualiza o tamanho de b na memória
    
    # Fim do programa
    li $v0, 10
    syscall

# Função que verifica se um número é cubo perfeito (0 <= n <= 10000)
# Argumento: $a0 = número a verificar
# Retorno: $v0 = 1 se é cubo perfeito, 0 caso contrário
is_perfect_cube:
    li $t3, 0                # $t3 = candidato a raiz cúbica (inicia em 0)
    
cube_loop:
    mul $t4, $t3, $t3        # $t4 = cubo = i * i * i
    mul $t4, $t4, $t3
    
    beq $t4, $a0, found_cube # Se cubo == n, encontrou
    bgt $t4, $a0, no_cube    # Se cubo > n, não é cubo perfeito
    
    addi $t3, $t3, 1         # Incrementa i
    j cube_loop
    
found_cube:
    li $v0, 1                # Retorna 1 (é cubo perfeito)
    jr $ra
    
no_cube:
    li $v0, 0                # Retorna 0 (não é cubo perfeito)
    jr $ra