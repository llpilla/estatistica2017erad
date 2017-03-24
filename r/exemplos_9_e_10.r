# Exemplos do texto do curso

## Exemplo 1.9 (p. 17) - teste t para uma média - caso unilateral

### Preparação de dados sintéticos padronizados
set.seed(1235)
eficiencia <- rnorm(n = 100, mean = 80, sd = 10)         # gera 100 pontos segundo uma distribuição normal com média 80 e desvio padrão 10
hist(eficiencia)

ks.test(eficiencia, "pnorm", mean(eficiencia), sd(eficiencia)) # verifica a normalidade dos dados

### Teste t para uma média - caso unilateral
# x é o vetor de dados
# mu é a média populacional com a qual estamos testando
# alternative é 'greater' para dizer que é unilateral e H1: eficiência > mu (H0: eficiência <= mu)
t.test(x = eficiencia, mu = 80, alternative = 'greater')

## Exemplo 1.10 (p. 17) - teste t para uma média - caso bilateral
set.seed(1235)
requisicoes <- rnorm(n = 200, mean = 90, sd = 10)        # gera 200 pontos segundo uma distribuição normal com média 90 e desvio padrão 10
hist(requisicoes)

ks.test(requisicoes, "pnorm", mean(requisicoes), sd(requisicoes)) # verifica a normalidade dos dados

### Teste t para uma média - caso bilateral
# alternative é 'two.sided' para dizer que H1: requisições != mu (H0: requisições == mu)
t.test(requisicoes, mu = 90, alternative = "two.sided")