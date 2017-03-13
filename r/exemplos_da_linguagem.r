# Exemplo básico de uso de funções na linguagem R

1:5                    ## dois pontos: gera uma sequência de valores
centena <- c(1:100)    ## c: combina valores em um vetor ou lista (vetores não têm atributos)
centena < 10           ## exemplo de comparação com vetor, retorna um vetor booleano
pares <- centena[centena %%  2 == 0] ## uso de vetor booleano como índice
pares + pares          ## operação de soma de vetores (item a item), retorna outro vetor
length(pares)          ## length: retorna o tamanho do vetor
tamanho <- .Last.value ## .Last.value: variável oculta que contém o valor da última expressão
tamanho

help(mean)             ## help: ajuda do R com informações da linguagem

mean(pares)            ## mean: retorna a média
median(pares)          ## median: retorna a mediana
var(pares)             ## var: retorna a variância

quantile(pares)        ## quantile: retorna os quartis e extremos. R implementa 9 formas de calcular quartis.
quantile(pares, probs = seq(0,1,0.1)) ## divisão em 10 partes. O símbolo igual serve para definir um parâmetro em função pelo nome

