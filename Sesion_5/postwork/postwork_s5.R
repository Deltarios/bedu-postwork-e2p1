# Postwork Sesión 5

library(dplyr) # Cargamos la bibliotecas de dplyr como dice el problema.
library(fbRanks) # Cargamos la biblioteca fbRanks

# Traemos nuestros datos que se encuentran almacenados en la página web
sp1.esp.1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
sp1.esp.1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
sp1.esp.1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

sp1.esp.1720 <- list(sp1.esp.1718, sp1.esp.1819, sp1.esp.1920)

sp1.esp.1720 <- lapply(sp1.esp.1720, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

# Obtnemos informacion de los datos.
lapply(sp1.esp.1720, FUN = function(x) { str(x)}) 

# Cambiamos el tipo de dato dentro de nuestro dataframe en la lista
sp1.esp.1720[[1]] <- mutate(sp1.esp.1720[[1]], Date = as.Date(Date, "%d/%m/%y"))
sp1.esp.1720[[2]] <- mutate(sp1.esp.1720[[2]], Date = as.Date(Date, "%d/%m/%Y"))
sp1.esp.1720[[3]] <- mutate(sp1.esp.1720[[3]], Date = as.Date(Date, "%d/%m/%Y"))

# Combinamos nuestros dataframe almacenados utilizando rbind
sp1.esp.1720 <- do.call(rbind, sp1.esp.1720)

str(sp1.esp.1720)  # Verificamos nuestra salida
dim(sp1.esp.1720)  # Obtenemos las dimensiones
head(sp1.esp.1720) # Vemos los primeros 6 elementos.
tail(sp1.esp.1720) # Vemos los ultimos 6 elementos.

# Se crea el dataframe que contiene nuestros datos limpios.
SmallData <- select(sp1.esp.1720, date = Date, home.team = HomeTeam, 
                    home.score = FTHG, away.team = AwayTeam, 
                    away.score = FTAG)

# Creamos un nuevo archivo llamado soccer.csv que contiene los datos.
write.csv(SmallData, "soccer.csv", row.names = F)

# En lista soccer se creara la lista de elementos scores y teams para nuestra funcion rank.teams
listasoccer <- create.fbRanks.dataframes("soccer.csv")

# La lista de las anotaciones
anotaciones <- listasoccer$scores

# La lista de los equipos
equipos <- listasoccer$teams

# La fechas unicas por cada partido
fecha <- unique(anotaciones$date)

# El tamaño de la lista de las fechas
n <- length(fecha)

# Se obtiene el ranking por equipo
ranking.teams <- rank.teams(scores = anotaciones, teams = equipos, min.date = fecha[1], max.date = fecha[n-1])

# Las probabilidades de los eventos
predicion <- predict(ranking.teams, date = fecha[n])
