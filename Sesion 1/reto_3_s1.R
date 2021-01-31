getwd()
setwd("/Users/deltarios/Documents/Bedu/Etapa 2/Sesion 1")
amazon.best <- read.csv("bestsellers_with_categories.csv")
tamazon <-as.data.frame(t(amazon.best))
colnames(tamazon) <- tamazon[1,]
row.names(tamazon)

which.max(tamazon["Price", ])
which.min(tamazon["Price", ])
  