# Postwork Sesión 7

# Trabajar solo con RStudio el codigo se probo en MacOS
library(mongolite) # Se carga la biblioteca de mongolite

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
dirDataFrame <- paste(dirProyect, "/data-postwork7", sep = "")

# Ponemos el directorio de trabajo en la carpeta donde se guardaran nuestro archivos
setwd(dirDataFrame)

# URL de los datos
url.data <- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv"

# Obtenemos los datos y los almacenamos en los data frames.
download.file(url = url.data, destfile = "data.csv", mode = "wb")

# Se crea conexion con mongo y se crea la coleccion.
mongo_collection = mongo(collection = "match", db = "match_games")

# Insertamos nuestros datos a la base de daatos
mongo_collection$insert(match)

# Realizar un count para conocer el número de registros que se tiene en la base
mongo_collection$count()

# el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?
mongo_collection$find('{"Date":"2015-12-20", "HomeTeam":"Real Madrid"}')

# No se encontraron resultados para esa fecha
mongo_collection$find('{"Date":"2017-08-27", "HomeTeam":"Real Madrid"}')
# En este si se encontro resultados  fue Real Madrid Valencia y fue empate 2-2

# Se termina la conexion con mongo
rm(mongo_collection)