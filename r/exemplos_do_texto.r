# Exemplos do texto do curso

## Exemplo 1.1 (p. 6) - média da população
tempos <- c(55.0, 65.0, 54.0)
mean(tempos)

## Exemplo 1.2 (p. 8) - médias e medianas
tempoA <- c(10, 12, 13, 15, 100)
tempoB <- c(30, 30, 30, 30, 30)

mediaA <- mean(tempoA) # média de A
mediaB <- mean(tempoB) # média de B
mediaA == mediaB       # comparação das médias (iguais)

medianaA <- median(tempoA) # mediana de A
medianaB <- median(tempoB) # mediana de B
medianaA == medianaB       # comparação das medianas (diferentes)
1.0 - medianaA / medianaB  # o quão menor é a mediana de A

## Exemplo 1.3 (p. 9) - variância e desvio padrão
var(tempoA) # variancia de A
sd(tempoA)  # desvio padrão de A

var(tempoB) # variancia de B
sd(tempoB)  # desvio padrão de B

## Exemplo 1.4 (p. 9) - amostras maiores
### Preparação de dados sintéticos padronizados
set.seed(1234)                                # define semente para geração de números aleatórios
completoA <- (100*rexp(n = 100, rate=10))     # dois vetores iniciais pseudoaleatórios
completoB <- (100*rexp(n=100, rate = 3))
completoA <-completoA - mean(completoA) + 30  # transformação dos vetores para que as médias ainda sejam 30
completoB <-completoB - mean(completoB) + 30
dados <- cbind(completoA, completoB)          # combina os dois vetores em uma matriz 2x100
colnames(dados) <- c("A", "B")                # nomeia colunas
dados <- as.data.frame(dados)                 # converte a matriz para um data frame

#### TODO: verificar plot