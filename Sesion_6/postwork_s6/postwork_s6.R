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

# Sacamos nuestros datos de nuestra serie de tiempo.
prom.goles <- ts(md$goles.promedio, start = 1, frequency = 2)

# Graficamos nuestra serie de tiempo
# Inicia la grafica desde agosto del 2010
ts.plot(prom.goles)
