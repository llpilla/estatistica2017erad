# Exemplos do texto do curso

## Exemplo 1.16 (p. 20) - One-way ANOVA

### Preparação de dados sintéticos padronizados
set.seed(1236)                            # fixa a semente aleatória
A <- rnorm(n = 200, mean = 80, sd = 10)   # gera três amostras de distribuições normais com médias diferentes e mesma variância
B <- rnorm(n = 200, mean = 95, sd = 10)
C <- rnorm(n = 200, mean = 75, sd = 10)

### Verificação de normalidade
ks.test(A, "pnorm", mean(A), sd(A))
ks.test(B, "pnorm", mean(B), sd(B))
ks.test(C, "pnorm", mean(C), sd(C))

### Organização dos dados
library(tidyr)                                # biblioteca para deixar os dados melhor organizados
dados <- cbind(A, B, C)
colnames(dados) <- c("A", "B", "C")
dados <- as.data.frame(dados)
dados <- gather(dados, chave, valores)        # renomeia as colunas do data frame para 'chave' e 'valores'

### Visualização dos dados 
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

# Gera a Figura 1.6
boxp <- ggplot(dados, aes(factor(chave), valores)) +
  geom_boxplot(aes(fill = factor(chave))) + 
  mytheme +
  scale_color_manual(values=c("#5B9DAD", "#D97B7F", "#9dad5b")) +
  scale_fill_manual(values=c("#5B9DAD", "#D97B7F", "#9dad5b")) +
  labs(x = "Algoritmo", y = "Tempo de execução (u.t.)");

# Mostra a Figura 1.6
boxp

### Testes para a ANOVA
library(car)
leveneTest(dados$valores~as.factor(dados$chave))                       # avalia a homogeneidade das variâncias das três amostras

# Aplica a ANOVA sobre os dados e apresenta os resultados
anova <- aov(valores~as.factor(chave), data = dados)
anova
summary(anova)

# Aplica o teste de Tukey sobre os dados e apresenta os resultados
library(agricolae)
mc <- HSD.test(anova, "as.factor(chave)", group = TRUE, console=TRUE)
mc
