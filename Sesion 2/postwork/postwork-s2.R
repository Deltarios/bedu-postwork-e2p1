# Obtenemos el directorio de trabajo actual
currentWD <- getwd()

# Obtenemos el directorio del proyecto
dirProyect <- dirname(rstudioapi::getSourceEditorContext()$path)

# Verificamos si estamos en el mismo directorio del proyecto
if (dirProyect != currentWD)
{
  setwd(dirProyect) # Ponemos el directorio del proyecto
}

# Obtenemos el directorio donde se guardaran los archivos
dirDataFrame <- paste(dirProyect, "/data-postwork3", sep = "")

# Ponemos el directorio de trabajo en la carpeta donde se guardaran nuestro archivos
setwd(dirDataFrame)

# URL de los datos
u1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

# Obtenemos los datos y los almacenamos en los data frames.
download.file(url = u1718, destfile = "sp1-esp-1718.csv", mode = "wb")
download.file(url = u1819, destfile = "sp1-esp-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "sp1-esp-1920.csv", mode = "wb")

# Revisamos los archivos en el directorio
dir()

# Cargamos los archivos en una lista
files.sp1.esp <- lapply(dir(), read.csv)

# Obtenemos sus caracteristicas
# str nos sirve para conocer el tipo y el nombre de cada todo dentro de nuestro dataframe
str(files.sp1.esp[1])

# head nos trae los primeros 6 elementos dentro nuestro data frame.
head(files.sp1.esp[1])

# View nos muestra los datos en formato de tabla para visualizar el contenido
View(files.sp1.esp[1])

# summary nos data un resumen de cada columna de nuestro data frame.
summary(files.sp1.esp[1])

# Invocamos nuestra biblioteca dplyr
library(dplyr)

# Seleccionamos nuestras 6 variables de interes.
files.sp1.esp <- lapply(files.sp1.esp, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
str(files.sp1.esp) # Verificamos que nuestra salida sea la correcta
# Cambiamos el tipo de nuestras variables de cada archivo en la lista
files.sp1.esp <- lapply(files.sp1.esp, mutate, Date = as.Date(Date, "%Y-%m-%d"))
str(files.sp1.esp) # Verificamos que nuestra salida sea correcta

# Combinamos nuestros documentos en un solo data frame.
sp1.esp.1720 <- do.call(rbind, files.sp1.esp)

# Ordenamos nuestro dataframe de forma creciente.
sp1.esp.1720 <- sp1.esp.1720[order(sp1.esp.1720$Date), ]

str(sp1.esp.1720)  # Verificamos nuestra salida
dim(sp1.esp.1720)  # Obtenemos las dimensiones
head(sp1.esp.1720) # Vemos los primeros 6 elementos.
tail(sp1.esp.1720) # Vemos los ultimos 6 elementos.

# Guardamos nuestro nuestro nuevo data frame como csv.
write.csv(sp1.esp.1720, "sp1-esp-1720.csv", row.names = F)
