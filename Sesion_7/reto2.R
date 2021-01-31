library(rvest)
url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
fil<-read_html(url)

tb<-html_nodes(fil, "table")
tb

table1 <- html_table(tb[1], fill = TRUE)
table1 <- as.data.frame(table1)

str(table1)

a <- gsub("MXN","",table1$Sueldo)
a <- gsub("[^[:alnum:][:blank:]?]", "", a)
a <- gsub("mes", "", a)
a <- as.numeric(a)
table1$Sueldo <- a

b <- gsub("Sueldos para Data Scientist en ", "", table1$Cargo)
table1$Cargo <- b

max.sueldo <- which.max(table1$Sueldo)
table1[max.sueldo,]

min.sueldo <- which.min(table1$Sueldo)
table1[min.sueldo,]
