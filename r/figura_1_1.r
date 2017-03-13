# Exemplo Figura 1.1 - médias vs detalhamento das repetições

## Primeiro passo: ler os dados de um arquivo csv (comma-separated values, valores separados por vírgula)
original_data <- read.csv("../csv/escalonadores.csv", header=TRUE, sep=",")

## Segundo passo: criar um novo dataframe a partir do anterior,
## agrupando os resultados das repetições de cada escalonador
## e mantendo as médias e medianas dos tempos
library(plyr)  # biblioteca com a função ddply
resumed_data <- ddply(original_data, c("sched"), summarize, mean = mean(time), median = median(time), num = length(time))

## Terceiro passo: desenhar os resultados de tempo médio
library(ggplot2) # biblioteca para gráficos

# Definição do tema usado para a figura
mytheme <- theme_bw(base_size=9, base_family = "Times") + 
  theme(panel.background=element_blank(), 
        text=element_text(size=9), 
        panel.border=element_blank(), 
        plot.title = element_text(size=9), 
        axis.ticks.y = element_blank(), 
        axis.text.y = element_blank(), 
        axis.text.x = element_text(family = "Times", size=8, face = "bold"), 
        axis.ticks.x = element_blank(), 
        legend.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 

# Geração da figura com os tempos médios dos escalonadores
p1 <- ggplot(resumed_data, aes(x = sched, y = mean)) + 
  mytheme +
  ylim(0,90) +
  geom_bar(stat="identity", color = "#5B9DAD", fill = "#5B9DAD") + 
  xlab("") + ylab("Tempo médio (segundos)") +
  geom_text(aes(label = sprintf("%.2f", mean)), vjust = -0.5, size=2.7, family="Times");

p1 # Apresenta a figura

## Quarto passo: desenhar os tempos individuais

# Definição de um novo tema para a segunda figura
mytheme <- theme_bw(base_size=9, base_family = "Times") + 
  theme(panel.background=element_blank(), 
        text=element_text(size=9), 
        plot.title = element_text(size=9),  
        axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(), 
        legend.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 

# Geração da figura com os tempos individuais
p2 <- ggplot(original_data, aes(x = repetition, y = time)) +
  geom_point(color = "#5B9DAD", size = 1) +
  mytheme +
  xlab("Repetições") + ylab("Tempo (segundos)") +
  facet_wrap(~sched, ncol = 2);

p2 # Apresenta a figura