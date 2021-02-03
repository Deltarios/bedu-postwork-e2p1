# Postwork 8 
# Realizado por el equipo 11

# Llamamos las librerias que usaremos.
library(shiny)
library(shinydashboard)
library(shinythemes)

ui <- fluidPage(
    dashboardPage(
        skin = "red",
        dashboardHeader(title = "¡Bedu - Postwork 8!"),
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("Resumenes", tabName = "summary", icon = icon("futbol-o")),
                menuItem("Probabilidades", tabName = "probability", icon = icon("bar-chart-o")),
                menuItem("Partidos", tabName = "match", icon = icon("clock-o")),
                menuItem("Ganacias", tabName = "gain", icon = icon("money"))
            )
        ),
        
        dashboardBody(
            tags$head(tags$style(HTML('
              .content-wrapper {
                background-color: white
              }
              .tab-pane h2 {
                margin-top: 10px;
                margin-bottom: 10px;
                margin-left: 10px;
                font-weight: bold;
                text-align:center;
              }
              .tab-pane h3 {
                margin-bottom: 10px;
                margin-left: 10px;
                font-weight: bold;
              }
              .shiny-input-container {
                padding: 10px;
              }
              img {
                display: block;
                margin-left: auto;
                margin-right: auto;
                padding: 10px;
              }
            '))),
            tabItems(
                # Summary
                tabItem(
                    tabName = "summary",
                    fluidRow(
                        titlePanel("Resumenes de partidos"),
                        selectInput("x", "Tipo de equipo: ", 
                        choices = c("home.score", "away.score")),
                        plotOutput("scoresPlot", height = 450, width = 750)
                    )
                ),
                # Probability
                tabItem(
                    tabName = "probability",
                    fluidRow(
                        titlePanel("Probabilidades"),
                        img(src = "img/p3/pm_fthg.png"),
                        img(src = "img/p3/pm_ftag.png"),
                        img(src = "img/p3/pc_maphead.png")
                    )
                ),
                # Match
                tabItem(
                    tabName = "match",
                    fluidRow(
                        titlePanel("Partidos"),
                        dataTableOutput ("data_table")
                    )
                ),
                # Gain
                tabItem(
                    tabName = "gain",
                    fluidRow(
                        titlePanel("Ganacias"),
                        p(h3("Factor de ganancia máximo")),
                        img(src = "img/momios/max.png"),
                        p(h3("Factor de ganancia mínimo")),
                        img(src = "img/momios/min.png"),
                    )
                )
            )
        )
    )
)

server <- function(input, output) {
    library(ggplot2)
    
    # Agregarle el .csv completo al archivo que se encuentra en el mismo programa para funcionamiento. "match.data.cs"
    data <-  read.csv("./match.data.csv", header = T)
    
    output$scoresPlot <- renderPlot({
        
        x <- data[,input$x]
        
        data %>% ggplot(aes(x, fill = input$x)) + 
            geom_bar() + 
            facet_wrap("away.team") +
            labs(x = input$x, y = "Goles")
    })
    
    # Generacion del data table
    output$data_table <- renderDataTable({data}, 
                                          options = list(aLengthMenu = c(10,25,50),
                                                    iDisplayLength = 5))
}

shinyApp(ui = ui, server = server)
