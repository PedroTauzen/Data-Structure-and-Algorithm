#=
eda1:
- Julia version: 1.9.1
- Author: Pedro Tauzen
- Date: 2023-06-18
=#


#=
1. a)
- Crie uma função designada por bubble_sort() e programe o algoritmo Bubble-Sort().
- Programe o algoritmo de ordenação Insertion-Sort().
- Utilize para teste dos algoritmos tabelas aleatórias com distribuição normal de
  média nula e desvio padrão = 1.0.
=#

# Bubble Sort
function bubble_sort(A)
    for i in 1:length(A)-1 # Percorre a matriz desde a primeira posição até a penúltima
        for j in length(A):-1:i+1 # percorre a matriz da última posição até a posição i+1 atual do laço externo
            if A[j] < A[j-1] # if true, está fora de ordem
                A[j], A[j-1] = A[j-1], A[j] # Troca de elementos
            end
        end
    end
    return A
end

# Insertion Sort
function insertion_sort(A)
    for j in 2:length(A) # percorre a matriz a partir do segundo elemento até o último elemento.
        key = A[j] # Valor do elemento atual é armazenado na key.
        i = j - 1 # ïndice do elemento anterior na lista.
        while i > 0 && A[i] > key
            A[i + 1] = A[i] # desloca o elemento A[i] uma posição para a direita, criando espaço para inserir o elemento key na posição correta.
            i -= 1 # movendo-se para o próximo elemento anterior na lista.
        end
        A[i + 1] = key # insere o elemento key na posição correta, onde todos os elementos à esquerda são menores ou iguais a key.
    end
    return A
end

# Array
array = [5, 3, 8, 2, 1, 9]
print("Array Original: ")
println(array)
println("")

# Teste Bubble Sort
println("Array ordenado com Bubble Sort: ")
println(bubble_sort(array))

println("")

# Teste Insertion Sort
println("Array ordenado com Insertion Sort: ")
println(insertion_sort(array))

# Função para gerar uma matriz aleatória com distribuição normal
function generate_random_table(n)
    table = randn(n)
    return table
end

# Função para testar os algoritmos de ordenação
function test_sorting_algorithms(n)

    # Gerar uma tabela aleatória com distribuição normal
    table = generate_random_table(n)

    # Imprimir a tabela original
    println("Tabela original:")
    println(table)
    println()

    # Ordenar a tabela usando o Bubble Sort
    sorted_table_bubble = bubble_sort(copy(table))
    println("Tabela ordenada usando Bubble Sort:")
    println(sorted_table_bubble)
    println()

    # Ordenar a tabela usando o Insertion Sort
    sorted_table_insertion = insertion_sort(copy(table))
    println("Tabela ordenada usando Insertion Sort:")
    println(sorted_table_insertion)
end

# Exemplo de uso
test_sorting_algorithms(10)


#= 1. b)
 -Utilize o package Plots.jl para criar um gráfico que permite observar as taxas assimptóticas de
  crescimento dos tempos de execução dos algoritmos de ordenação Bubble-Sort e Insertion-Sort.
=#

using Plots

# Função para calcular o tempo de execução de um algoritmo de ordenação
function measure_time(sort_algorithm, input_size)
    input = randn(input_size)  # Gera uma matriz aleatória com distribuição normal

    # Medição do tempo de execução
    start_time = time()
    sort_algorithm(input)
    end_time = time()

    execution_time = end_time - start_time
    return execution_time
end

# Função para gerar os dados de tempo de execução para diferentes tamanhos de entrada
function generate_execution_time_data(sort_algorithm, input_sizes)
    execution_times = []

    for input_size in input_sizes
        execution_time = measure_time(sort_algorithm, input_size)
        push!(execution_times, execution_time)
    end

    return execution_times
end

# Definindo os tamanhos de entrada
input_sizes = [100, 200, 500, 1000, 2000, 5000, 10000]

# Gerando os dados de tempo de execução para Bubble Sort e Insertion Sort
bubble_sort_times = generate_execution_time_data(bubble_sort, input_sizes)
insertion_sort_times = generate_execution_time_data(insertion_sort, input_sizes)

# Plotando os resultados
plot(input_sizes, bubble_sort_times, label="Bubble Sort", marker=:circle)
plot!(input_sizes, insertion_sort_times, label="Insertion Sort", marker=:square)
xlabel!("Tamanho da entrada")
ylabel!("Tempo de execução (s)")
title!("Taxas assintóticas de crescimento dos tempos de execução")
legend(:topright)


