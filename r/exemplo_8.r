# Exemplos do texto do curso

## Exemplo 1.8 (p. 16) - teste de normalidade

### Preparação de dados sintéticos padronizados
set.seed(1234)                        # fixa a semente aleatória
lambda <- 3                           # parâmetro lambda a ser usado para a geração de pontos em uma distribuição exponencial
n <- 100                              # número de repetições de cada amostra
n_medias <- 1000                      # número de médias a serem calculadas
medias <- rep(0, n_medias)            # criação do vetor de médias, o qual vamos colocar valores item a item

for (i in 1:n_medias){               # cálculo das 1000 médias
  tempos <- rexp(n = n, rate = lambda)
  medias[i] <- mean(tempos)           # média da amostra de tamanho 100
}

### Plot dos dados para vermos seu comportamento (estilo uma normal)
library(ggplot2)
mytheme <- theme_bw(base_size=10, base_family = "Times") + 
  theme(panel.background=element_blank(), 
        text=element_text(size=10), 
        plot.title = element_text(size=10),  
        legend.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 

histograma <- qplot(medias, 
                    geom='histogram',
                    ylab = 'Número de ocorrências',
                    xlab = 'Tempo de execução (u.t.)',
                    fill = I("#5B9DAD")) + 
  mytheme;
histograma

### Aplicação do teste de Kolmogorov-Smirnov para verificarmos normalidade
media <- mean(medias)          # media a ser usada para a geração da distribuição normal
desvio <- sd(medias)           # desvio padrão a ser usado para a geração da distribuição normal
ks.test(medias, 'pnorm', media, desvio) # A raiz de n não é necessária aqui porque já está inclusa no desvio padrão das médias
# O resultado acima é um pouco diferente do valor no texto (p-value 0.8388 vs 0.8208) 
# porque os valores originais usavam as medias e desvio padrão
# populacionais ao invés dos amostrais. No caso abaixo usamos os parâmetros populacionais
# que nós conhecemos da distribuição exponencial
ks.test(medias, 'pnorm', 1/lambda, (1/lambda)/sqrt(n))

