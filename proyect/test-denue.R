# Title     : TODO
# Objective : TODO
# Created by: deltarios
# Created on: 25/01/21

library(httr)
library(jsonlite)
library(rjson)
library(here)
library(dplyr)

findDataDenue <- function (condition, lat, lng, dist)
{
  url <- paste0("https://www.inegi.org.mx/app/api/denue/v1/consulta/Buscar/", condition, "/")
  url <- paste0(url, lat, ",")
  url <- paste0(url, lng, "/")
  url <- paste0(url, dist, "/")
  url <- paste0(url, getToken())
  data <- GET(url)
  return(data)
}

findDataByStateDenue <- function (condition, numberState, min, max)
{
  url <- paste0("https://www.inegi.org.mx/app/api/denue/v1/consulta/BuscarEntidad/", condition, "/")
  url <- paste0(url, numberState, "/")
  url <- paste0(url, min, "/")
  url <- paste0(url, max, "/")
  url <- paste0(url, getToken())
  data <- GET(url)
  return(data)
}

getToken <- function ()
{
  pathTokenFile <- "auth/auth-data.json"
  token.denue <- fromJSON(file = pathTokenFile)
  return(token.denue$denue$token)
}

dataToJson <- function (data)
{
  rawData <- content(data,"text")
  flujoDatos <- paste(rawData, collapse = " ")
  flujoDatos <- fromJSON(flujoDatos)
  return(flujoDatos)
}

dataToDf <- function (data)
{
  df <- do.call(rbind.data.frame, data)
  return(df)
}

dirProyect <- here("proyect")
setwd(dirProyect)

result <- findDataDenue("ropa", "20.976148", "-89.6609935", "3000")
resultJSON <- dataToJson(result)
datosEmpresasGeneral <- dataToDf(resultJSON)

result <- findDataByStateDenue("ropa", 31, 1, 10000)
resultJSON <- dataToJson(result)
datosEmpresasByState <- dataToDf(resultJSON)
