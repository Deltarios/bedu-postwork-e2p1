ran <- rnorm(44)
result <- 0
for(i in 1:15)
{
  result[i] <- ran[i]**3 + 12
}
df.al <- data.frame(ale = ran[1:15], res = result) 
print(df.al)

# pseudocódigo 

# ran <- {se genera el vetor con rnorm de 44 entradas}
# 
# result <- {Vector donde se almacenará el resultado}
# 
# for (contador desde 1 hasta 15 ){
#   result[contador] <- operación aritmética
# }
