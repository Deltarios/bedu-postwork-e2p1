library(dplyr)

liga.football <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
size.registers <- dim(liga.football)[1]

goals.fthg <- liga.football$FTHG
goals.ftag <- liga.football$FTAG

pm.fthg <- (table(goals.fthg) / size.registers) * 100
pm.ftag <- (table(goals.ftag) / size.registers) * 100
pmc <- (table(goals.fthg, goals.ftag) / size.registers) * 100

print(pm.fthg)
print(pm.ftag)
print(pmc)
