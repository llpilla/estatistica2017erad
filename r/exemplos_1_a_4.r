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

library(tidyr)                                # biblioteca para deixar os dados melhor organizados
dados <- gather(dados, "chave", "valores")    # renomeia colunas para chave e valor

### Geração das figuras
library(ggplot2)                              # biblioteca para gerar figuras

# tema usado para a figura
mytheme <- theme_bw(base_size=10, base_family = "Times") + 
  theme(panel.background=element_blank(), 
        text=element_text(size=10), 
        plot.title = element_text(size=10),  
        legend.title = element_blank(), 
        legend.position = "none",
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 

# Gera a Figura 1.3 (a)
fig_a <- ggplot(dados, aes(factor(chave), valores)) +    # chave e valores fazem referência aos nomes de
  geom_boxplot(aes(fill = factor(chave))) +              # colunas do data frame 'dados' que definimos anteriormente
  mytheme +
  scale_color_manual(values=c("#5B9DAD", "#D97B7F")) +
  scale_fill_manual(values=c("#5B9DAD", "#D97B7F")) +
  #+ guides(fill = FALSE)
  labs(x = "Algoritmo", y = "Tempo de execução (u.t.)");

# Mostra Figura 1.3 (a) Boxplot
fig_a

# Gera a Figura 1.3 (b)
fig_b <- ggplot(dados, aes(x = valores, fill = chave)) + 
  geom_histogram(alpha = 0.4, position = "identity", binwidth = 5) +
  mytheme +
  scale_color_manual(values=c("#5B9DAD", "#D97B7F")) +
  scale_fill_manual(values=c("#5B9DAD", "#D97B7F")) +
  labs(x = "Tempo de execução (u.t.)", y = "Número de ocorrências");

# Mostra Figura 1.3 (b) Histograma
fig_b

