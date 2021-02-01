# Postwork Sesión 6 
library(dplyr)

# Importamos los datos desde el link en github
url.match.data <- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv"
match.data <- read.csv(url.match.data)

# Verificamos los datos que vienen del csv.
str(match.data)

# Convertimos el tipo fecha
md <- mutate(match.data, date = as.Date(date, "%Y-%m-%d")) 

# Verificamos nuestra salida
str(md)
tail(md)

# Agregamos nuestra columna para sumar los goles
md <- mutate(md, sumagoles = home.score + away.score)

# Creamos una columna con solo los meses y el año
md <- mutate(md, xmonth = format(date, "%Y-%m"))

# Agrupamos mediante el mes de la columna previamente creada
md <- group_by(md, xmonth)

# Sumamos y obtenemos el promedio de goles.
md <- summarise(md, goles.promedio = mean(sumagoles))

typeof(md) # Es para ver la salida de nuestro datos (Es una lista)

# Convertimos nuestra lista a un dataframe.
md <- as.data.frame(md)

# Obtenemos el indice hasta la fecha de 12 de diciembre.
indexDiciembre2019 <- which(md$xmonth == "2019-12")

# Obtenemos los meses hasta la fecha del indice
md1219 <- md[1:indexDiciembre2019, ]

# Sacamos nuestros datos de nuestra serie de tiempo.
prom.goles <- ts(md1219$goles.promedio, start = 1, frequency = 10)

# Graficamos nuestra serie de tiempo
# Inicia la grafica desde agosto del 2010
ts.plot(prom.goles) # Obtenemos un outlier del mes de agosto del 2013.

# Eliminamos el valor de nuestros datos para tener una frecuencia de entre año y año de 10 meses
md1219 <- filter(md1219, md1219$xmonth != "2013-06")

dim(md1219) # Verificamos las dimensiones del df

# Sacamos nuestros datos de nuestra serie de tiempo.
prom.goles <- ts(md1219$goles.promedio, start = 1, frequency = 10)

# Graficamos nuestra serie de tiempo
# Inicia la grafica desde agosto del 2010
ts.plot(prom.goles) # Ahora tenemos una frecuencia de 10
