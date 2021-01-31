# install.packages("stringr") # Descomentar si no esta instalada la libreria
# install.packages("here")

library(stringr)
library(reshape2)
library(here)
library(dplyr)

# Obtenemos el directorio del proyecto
nameFolder <- "Sesion 4"
dirProyect <- here(nameFolder)

dirMainFolder <- str_replace(dirProyect, nameFolder, "")

setwd(dirMainFolder)
getwd()
# Correr el postwork-s2.R primero dentro de la carpeta Sesion 2
pathDataSp1720 <- "Sesion 2/data-postwork2/sp1-esp-1720.csv"
sp1.esp.1720 <- read.csv(pathDataSp1720)

# Obtenemos el directorio de trabajo actual
currentWD <- getwd()

# Verificamos si estamos en el mismo directorio del proyecto
if (dirProyect != currentWD)
{
  setwd(dirProyect) # Ponemos el directorio del proyecto
  currentWD <- dirProyect
}

# Obtenemos las probabilidades marginales estimadas y la probalidad conjunta
str(sp1.esp.1720)
size.registers <- dim(sp1.esp.1720)[1]

goals.fthg <- sp1.esp.1720$FTHG
goals.ftag <- sp1.esp.1720$FTAG

pm.fthg <- (table(goals.fthg) / size.registers)
pm.ftag <- (table(goals.ftag) / size.registers)
(pmc <- (table(goals.fthg, goals.ftag) / size.registers))

# Tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
(t_cocientes <- apply(pmc, 2, function (c) c / pm.fthg))
(t_cocientes <- apply(t_cocientes, 1, function (r) r / pm.ftag))

(t_cocientes <- t(t_cocientes))



#Extraer de manera aleatoria algunas filas de nuestro data frama.
set.seed(66)
muestras <- sample(size.registers, size = 250, replace = TRUE)
nuevos.sp1.esp.1720 <- sp1.esp.1720[muestras, ]

pm.fthg <- table(nuevos.sp1.esp.1720$FTHG) / size.registers

pm.ftag <- table(nuevos.sp1.esp.1720$FTAG) / size.registers

pmc <- table(nuevos.sp1.esp.1720$FTHG, nuevos.sp1.esp.1720$FTAG) / size.registers

t_cocientes <- apply(pmc, 2, function (c) c / pm.fthg)
t_cocientes <- apply(t_cocientes, 1, function (r) r / pm.ftag)

(t_cocientes <- t(t_cocientes))