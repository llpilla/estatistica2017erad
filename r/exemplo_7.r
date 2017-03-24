# Exemplos do texto do curso

## Exemplo 1.7 (p. 15) - teste de normalidade

### Preparação de dados sintéticos padronizados
set.seed(1234)                        # fixa a semente aleatória
lambda <- 3                           # parâmetro lambda a ser usado para a geração de pontos em uma distribuição exponencial
n <- 100                              # número de repetições
tempos <- rexp(n = n, rate = lambda)  # geração de tempos segundo uma distribuição exponencial 

### Plot dos dados para vermos seu comportamento (claramente não normal)
library(ggplot2)
mytheme <- theme_bw(base_size=10, base_family = "Times") + 
  theme(panel.background=element_blank(), 
        text=element_text(size=10), 
        plot.title = element_text(size=10),  
        legend.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 

histograma <- qplot(tempos, 
           geom='histogram',
           ylab = 'Número de ocorrências',
           xlab = 'Tempo de execução (u.t.)',
           fill = I("#5B9DAD")) + 
           mytheme;
histograma

### Aplicação do teste de Kolmogorov-Smirnov para verificarmos normalidade
media <- mean(tempos)          # media a ser usada para a geração da distribuição normal
desvio <- sd(tempos)           # desvio padrão para ser usado na geração da distribuição normal
ks.test(tempos, 'pnorm', media, desvio/sqrt(n)) # 'desvio/sqrt(n)' é uma aplicação errada do Teorema do Limite Central (proposital aqui)
# O resultado acima é um pouco diferente do valor no texto (0.49403 vs 0.50073) 
# porque os valores originais usavam as medias e desvio padrão
# populacionais ao invés dos amostrais. No caso abaixo usamos os parâmetros populacionais
# que nós conhecemos da distribuição exponencial
ks.test(tempos, 'pnorm', 1/lambda, (1/lambda)/sqrt(n))