"Ahora investigar?s la dependencia o independencia del n?mero de goles anotados por el equipo de casa
y el n?mero de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap
revisa bibliograf?a en internet para que tengas nociones de este desarrollo."
library(dplyr)

uliga1.1920 = 'https://www.football-data.co.uk/mmz4281/1920/SP1.csv'
data <- read.csv(uliga1.1920)
size.registers <- dim(data)[1]

goals.fthg <- data$FTHG
goals.ftag <- data$FTAG

marginal_casa <- (table(goals.fthg) / size.registers)
marginal_fuera <- (table(goals.ftag) / size.registers)
conjunta <- (table(goals.fthg, goals.ftag) / size.registers)


"1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8),
y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obt?n una tabla de cocientes al dividir
estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes."


(t_cocientes <- apply(conjunta, 2, function (c) c / marginal_casa))
(t_cocientes <- apply(t_cocientes, 1, function (r) r / marginal_fuera))
(t_cocientes <- t(t_cocientes))

t_cocientes  #Esta es la tabla de cocientes.

"2. Mediante un procedimiento de boostrap, obt?n m?s cocientes similares a los obtenidos en la tabla del punto anterior.
Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior.
Menciona en cu?les casos le parece razonable suponer que los cocientes de la tabla en el punto 1,
son iguales a 1 (en tal caso tendr?amos independencia de las variables aleatorias X y Y)."
#Extraer de manera aleatoria algunas filas de nuestro data frama.

set.seed(66)

Lista_matrices_BOT = list() #Se crea una lista vac?a en donde se guardaran las muestras generadas.
Num.muestras.bot = 10 #Esta variable nos da el n?mero de muestras que queremos que nos realice le proceso de bootstrap.



for (k in 1:100) {
  muestras <- sample(size.registers, size = 380, replace = TRUE) #Genera n?meros aleatorios del 1 al n?meor maximo de registros; en este caso 380.
  BOT <- data[muestras, ] #Esos n?meros aleatorios ser?n los ?ndices que tomara de la base de datos para remuestrear.
  marginal_casa_bot <- table(BOT$FTHG) / size.registers
  marginal_fuera_bot <- table(BOT$FTAG) / size.registers
  conjunta_bot <- table(BOT$FTHG, BOT$FTAG) / size.registers
  t_cocientes_bot <- apply(conjunta_bot, 2, function (c) c / marginal_casa_bot)
  t_cocientes_bot <- apply(t_cocientes_bot, 1, function (r) r / marginal_fuera_bot)
  t_cocientes_bot <- data.matrix(t(t_cocientes_bot))
  row = nrow(t_cocientes_bot)
  col = ncol(t_cocientes_bot)
  if( (row == 7)&(col == 6) ){
    Lista_matrices_BOT <- append(Lista_matrices_BOT,list(t_cocientes_bot),k)
    Lista_matrices_BOT <- Lista_matrices_BOT[seq(1,Num.muestras.bot,1)]
  }
  
}

Lista_matrices_BOT #Esta es la lista con el n?mero de muestras indicado por el usuario.


################################################################################################################
##################################### AN?LISIS DE LA TABLA DE COEFICIENTES #####################################
################################################################################################################
"Para que exista independencia entre las variables los valores de la tabla de cocientes deben ser igual a 1
ya que el teorema de independencia de variables dice que la multiplicaci?n de las probabilidades
marginales de dos variables debe ser igual a la conjunta de las mismas; por lo tanto si dividimos la conjunta
entre la multiplicaci?n de las marginales se espera que haya independencia cuando el resultado sea uno. Este teorema de independencia 
se debe comprobar en cada una de las casillas.
Aquellos caso en los que el cociente es mayor que uno es porque el producto de las marginales es un n?mero menor a la probabilidad
conjunta; mientras que aquellos casos donde el cociente es menor a uno es porque el producto de las marginales es un
n?mero mayor a la probabilidad conjunta"


"En aquellos casos en los que se obtuvo un cociente mayor a uno, pero menor a 1.1, podr?amos tomar dicho coeficientes
como uno, y decir que existe independencia de las variables"