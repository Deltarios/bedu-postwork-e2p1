# install.packages("stringr") # Descomentar si no esta instalada la libreria
library(stringr)

# Obtenemos el directorio del proyecto
dirProyect <- dirname(rstudioapi::getSourceEditorContext()$path)

nameFolder <- "/Sesion 3"

dirMainFolder <- str_replace(dirProyect, nameFolder, "")

setwd(dirMainFolder)

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

# 1
str(sp1.esp.1720)
size.registers <- dim(sp1.esp.1720)[1]

goals.fthg <- sp1.esp.1720$FTHG
goals.ftag <- sp1.esp.1720$FTAG

pm.fthg <- (table(goals.fthg) / size.registers) * 100
pm.ftag <- (table(goals.ftag) / size.registers) * 100
pmc <- (table(goals.fthg, goals.ftag) / size.registers) * 100

# 2
library(ggplot2)

barplot(pm.fthg, xlab = "Goles por equipo en casa", ylab = "Probabilidades marginales", main = "Probabilidades de anotar un gol jugando en casa", col = "blue", border = "red")

barplot(pm.ftag, xlab = "Goles por equipo en visitante", ylab = "Probabilidades marginales", main = "Probabilidades de anotar un gol jugando de visitante", col = "red", border = "blue")

# heatmap(pmc, Colv = NA, Rowv = NA, scale="row")

chart.pmc <- as.data.frame(pmc)
chart.pmc <- rename(chart.pmc, golesH = goals.fthg, golesV = goals.ftag, Frecuencia = Freq)
str(chart.pmc)

chart.pmc %>% ggplot(aes(golesH, golesV)) + 
  geom_tile(aes(fill=Frecuencia)) + 
  ggtitle("Probabilidades conjuntas") + 
  scale_fill_gradient(low = "white", high = "steelblue")
