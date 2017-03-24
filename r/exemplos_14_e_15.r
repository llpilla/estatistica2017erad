# Exemplos do texto do curso

## Exemplo 1.14 (p. 19 e 20) - Teste de Wilcoxon-Mann-Whitney para duas Amostras

### Preparação de dados sintéticos padronizados
set.seed(1235)
tempo_A <- rexp(n=100, rate=3)     # exponencial com lambda = 3
tempo_B <- rexp(n=100, rate=10)    # exponencial com lambda = 10

### Comparação das distribuições de A e B
# alternative 'two.sided' significa que H1: dist(A) != dist(B) (H0: dist(A) == dist(B))
wilcox.test(tempo_A, tempo_B, alternative = "two.sided", paired = FALSE)

## Exemplo 1.15 (p. 20) - Teste de Wilcoxon-Mann-Whitney para duas Amostras
tempo_reA <- rexp(n=100, rate=3)   # exponencial com lambda = 3
wilcox.test(tempo_A, tempo_reA, alternative = "two.sided", paired = FALSE)
# Os valor W = 4771 e p-value = 0.5766 são um pouco distintos dos valores no exemplo, 
# mas o significado dos resultados é o mesmo