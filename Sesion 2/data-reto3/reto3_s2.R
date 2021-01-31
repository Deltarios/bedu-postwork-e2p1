suppressMessages(suppressWarnings(library(dplyr)))

bundesliga2017 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"
bundesliga2018 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
bundesliga2019 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
bundesliga2020 <- "https://www.football-data.co.uk/mmz4281/2021/D1.csv"

download.file(url = bundesliga2017, destfile = "B1_20.csv", mode = "wb")
download.file(url = bundesliga2018, destfile = "B1_19.csv", mode = "wb")
download.file(url = bundesliga2019, destfile = "B1_18.csv", mode = "wb")
download.file(url = bundesliga2020, destfile = "B1_17.csv", mode = "wb")

lista <- lapply(list.files(), read.csv)

lista <- lapply(lista, select, HomeTeam:FTR, Date)

juegos <- do.call(rbind, lista)
head(juegos); tail(juegos)
