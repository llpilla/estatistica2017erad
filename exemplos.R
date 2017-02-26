library(tidyr)
library(ggplot2)
library(dplyr)

# Teste de normalidade - exemplo 1.7
## Parte 1

### Fixa a semente aleatória
set.seed(1234)

### Parâmetros de controle
lambda = 3
n = 100

### Gera o vetor dos dados vazio
tempos<-rep(0,n)

### Seleciona sem reposição 100 valores da população
tempos<-rexp(n = length(tempos), rate = 3)

# Plota o histograma
########################
# Seria BEM LEGAL se tivesse esse histograma com os outros dois, mas se não couber, tudo bem
########################
qplot(tempos, 
      geom='histogram',
      main = 'Histograma dos tempos de execução',
      ylab = 'Repetições',
      xlab = 'Tempos (u.t.)',
      alpha=I(.5),
      fill = I('cadetblue'))

# Testa se os dados aderem à distribuição normal
ks.test(tempos, 'pnorm', 1/lambda, (1/lambda)/sqrt(n))

#######################################################
# Parte 2 - exemplo 1.8

# Na primeira parte utilizar n = 10, nmedias = 1000. Depois, trocar para n=100 e m=1000

### Parâmetros
n = 100
lambda = 3
nmedias = 1000
set.seed(1234)

# Cria o vetor para os tempos e as médias
tempos<-rep(0,n)
medias<-rep(0, nmedias)

# Retira 100 amostras de tamanho 100 da população e calcula sua média
for (i in 1:length(medias)){
  tempos<-rexp(n=length(tempos), rate = lambda)
  medias[i]<-mean(tempos)
}

mean(medias)
sd(medias)


# Plota o histograma
qplot(medias, 
      geom='histogram',
      main = 'Histograma das médias dos tempos de execução',
      ylab = 'Repetições',
      xlab = 'Tempos (u.t.)',
      alpha=I(.5),
      fill = I('cadetblue'))

# Testa se os dados aderem à distribuição normal
ks.test(medias, 'pnorm', 1/lambda, (1/lambda)/sqrt(n))

#######################################################
# Teste t para uma amostra
#######################################################

## Unilateral 
set.seed(1235)
eficiencia<-rnorm(n = 100, mean = 80, sd = 10)
hist(eficiencia)

mean(eficiencia)
ks.test(eficiencia, "pnorm", 80, 10)
t.test(x = eficiencia, mu = 80, alternative = 'greater')

## Bilateral
#pop<-rnorm(n=10000, mean = 90, sd = 10)
#hist(pop)
set.seed(1235)
requisicoes<-rnorm(n = 200, mean = 90, sd = 10)
hist(requisicoes)

mean(requisicoes)
ks.test(requisicoes, "pnorm", 90, 10)
t.test(requisicoes, mu = 90, alternative = "two.sided")

#####################
# Teste F para homogeneidade de variâncias
#####################

set.seed(1235)
eficiencia_A<-rnorm(n = 100, mean = 80, sd = 10)
eficiencia_B<-rnorm(n=100, mean = 90, sd = 2)

ks.test(eficiencia_A, "pnorm", 80, 10)
ks.test(eficiencia_B, "pnorm", 90, 2)

var(eficiencia_A)
var(eficiencia_B)
var.test(eficiencia_A, eficiencia_B, alternative='two.sided')

t.test(eficiencia_A, eficiencia_B)

#######################
# Teste T para duas médias com variâncias populacionais iguais
########################

set.seed(1236)

psi<-rnorm(n = 200, mean = 80, sd = 10)
theta<-rnorm(n = 200, mean = 95, sd = 10)

mean(psi)
mean(theta)
var(psi)
var(theta)
var.test(psi, theta, alternative = 'two.sided')


t.test(psi, theta, var.equal = TRUE, alternative='two.sided')

###################################################
# Teste para uma proporção
###################################################

set.seed(1235)
n <- 1000
medias<-rep(0,500)
p = 0.05

for (i in 1:length(medias)) {
  pacotes<-rbinom(1, size = n, prob = 0.06)
  medias[i]<-pacotes/n
}

hist(medias)
mean(medias)
sd(medias)
sqrt(p*(1-p)/n)

ks.test(medias, "pnorm", 0.06, sqrt(0.06*(1-0.06)/n))

z_teste<- (mean(medias) - p)/sqrt(p*(1-p)/n)
z_teste

1-pnorm(z_teste, lower.tail = TRUE, mean = 0, sd = 1)

###################################################
# Teste de Wilcoxon para amostras independentes
###################################################

set.seed(1235)
tempo_A<-rexp(n=100, rate=3)
tempo_B<-rexp(n=100, rate=10)
tempo_C<-rexp(n=100, rate=3)

ks.test(tempo_A, "pnorm", 1/3, 1/3)
ks.test(tempo_B, "pnorm", 1/10, 1/10)

wilcox.test(tempo_A, tempo_C, alternative = "two.sided", paired = FALSE)


##################################################
# One-way ANOVA
##################################################

# Gera os dados provenientes de 3 distribuições normais
set.seed(1236)
psi<-rnorm(n=200, mean = 80, sd=10)
theta<-rnorm(n=200, mean = 95, sd = 10)
delta <- rnorm(n = 200, mean = 75, sd = 10)

ks.test(psi, "pnorm", mean(psi), sd(psi))
ks.test(theta, "pnorm", mean(theta), sd(theta))
ks.test(delta, "pnorm", mean(delta), sd(delta))

library(tidyr)
dados<- cbind(psi,theta,delta)
colnames(dados)<-c("psi", "theta", "delta")
dados<-as.data.frame(dados)
dados<-gather(dados, chave, valores)

c<-ggplot(dados, aes(factor(chave), valores))
c <- c + geom_boxplot(aes(fill = factor(chave))) + theme_bw() + guides(fill = FALSE)
c + labs(x = "Algoritmo", y = "Tempo de execução (u.t.)")

install.packages("car")
library(car)
leveneTest(dados$valores~as.factor(dados$chave))

anova<-aov(valores~as.factor(chave), data = dados)
anova
summary(anova)

install.packages("agricolae")
library(agricolae)
mc <- HSD.test(anova, "as.factor(chave)", group = TRUE, console=TRUE)
mc


#############################################
#
#############################################
