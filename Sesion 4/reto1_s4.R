# Title     : TODO
# Objective : TODO
# Created by: deltarios
# Created on: 19/01/21

library(ggplot2)
library(reshape2)

# Parte 1
#1. La probabilidad de observar exactamente 10 éxitos.

dbinom(x = 10, size = 35, prob = 0.51)

#2. La probabilidad de observar 10 o más exitos.

pbinom(q = 10, size = 35, prob = 0.51,lower.tail = FALSE)

#3. El cuantil de orden 0.5.

qbinom(p = 0.5, size = 35, prob = 0.51) # b = 5

# Parte 2
#1.
x <- seq(-4, 4, 0.01)*7 + 110
y <- dnorm(x, mean = 110, sd = 7)

plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 110, " y ", sigma == 7)))
abline(v = 110, lwd = 2, lty = 2)


#4. Genere una muestra aleatoria de tamaño 1000 y realice el histograma de frecuencias relativas para esta muestra
set.seed(4857) # Para poder reproducir la muestra en el futuro
muestra <- rnorm(n = 1000, mean = 110, sd = 7)
length(muestra); mdf <- as.data.frame(muestra)
tail(mdf)

# Observamos que el histograma de la muestra generada tiene forma de campana
# Similar a la densidad de una normal

ggplot(mdf, aes(muestra)) +
  geom_histogram(colour = 'red',
                 fill = 'blue',
                 alpha = 0.3, # Intensidad del color fill
                 binwidth = 3) +
  geom_vline(xintercept = mean(mdf$muestra), linetype="dashed", color = "black") +
  ggtitle('Histograma para la muestra normal') +
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))