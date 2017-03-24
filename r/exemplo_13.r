# Exemplos do texto do curso

## Exemplo 1.13 (p. 19) - teste para uma proporção

### Preparação de dados sintéticos padronizados
set.seed(1235)                        # fixa a semente aleatória
n <- 1000                             # número de repetições em cada amostra
medias <- rep(0, 500)                 # criação do vetor de médias de 500 experimentos
p <- 0.05                             # proporção esperada

# Preenche o arranjo de médias
for (i in 1:500) {
  pacotes <- rbinom(1, size = n, prob = 0.06) # gera dados sintéticos conforme distribuição binomial
  medias[i] <- pacotes/n
}

### Teste para uma proporção
ks.test(medias, "pnorm", mean(medias), sd(medias)) # verificamos a normalidade primeiro
# o KS vai reclamar que existem valores repetidos em 'medias', mas iremos ignorar isso conscientemente
z_teste <- (mean(medias) - p)/sqrt(p*(1-p)/n)      # calculamos o valor de z_teste conforme a Equação 6
z_teste
1 - pnorm(z_teste, lower.tail = TRUE, mean = 0, sd = 1) # vemos onde o z_teste cai na normal e ficamos com o p-valor
# Ou seja, calcula o p-valor fazendo um menos a probabilidade acumulada até o valor de z-teste, utilizando uma normal padrão