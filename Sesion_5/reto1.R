# Title     : TODO
# Objective : TODO
# Created by: deltarios
# Created on: 21/01/21

datos <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-05/Reto-01/datoslineal.csv")

attach(datos)
plot(x, y, main = "Gráfico de dispersión")

modelo <- lm(y ~ x) # 2.
summary(modelo)
abline(lsfit(x, y))

summary(modelo)

anova(modelo)
par(mfrow = c(2, 2))
plot(modelo) # 3.