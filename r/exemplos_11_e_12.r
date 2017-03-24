# Exemplos do texto do curso

## Exemplo 1.11 (p. 17 e 18) - teste t para duas médias - verificação das variâncias

### Preparação de dados sintéticos padronizados
set.seed(1236)
psi <- rnorm(n = 200, mean = 80, sd = 10)
theta <- rnorm(n = 200, mean = 95, sd = 10)

### Verificação da normalidade das distribuições
ks.test(psi, "pnorm", mean(psi), sd(psi))
ks.test(theta, "pnorm", mean(theta), sd(theta))

### Comparação da igualdade das variâncias
# var.test == F Test
# alternative 'two.sided' significa que H1: var(psi) != var(theta) (H0: var(psi) == var(theta))
var.test(psi, theta, alternative='two.sided')

## Exemplo 1.12 (p. 18) - teste t para duas médias - variâncias iguais
# var.equal = TRUE informa que as variâncias são consideradas iguais
t.test(psi, theta, var.equal = TRUE, alternative='two.sided')