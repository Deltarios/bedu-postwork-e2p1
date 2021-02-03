library(shiny)


shinyUI(
    pageWithSidebar(
        headerPanel("Aplicacion basica con Shiny"),
        sidebarPanel(
            p("Crear plots con el DF 'auto'"), 
            selectInput("x", "Seleccione el valor de X",
                        choices = names(mtcars))
        ),
        
        mainPanel(
            
            #Agregando pestañas     # <-----------
            tabsetPanel(              # <-----------
                                      tabPanel("Plots",   #Pestaña de Plots  <-----------
                                               h3(textOutput("output_text")), 
                                               plotOutput("output_plot"),
                                      ),
                                      
                                      tabPanel("imágenes",  #Pestaña de imágenes <-----------
                                               img( src = "cor_mtcars.png", 
                                                    height = 450, width = 450)
                                      ), 
                                      
                                      #Aprovehamos y agregamos las siguientes pestañas # <-----------
                                      tabPanel("Summary", verbatimTextOutput("summary")),    # salida del Summary <-----------
                                      tabPanel("Table", tableOutput("table")),               # salida de la tabla <-----------
                                      tabPanel("Data Table", dataTableOutput("datatable"))   # salida del data table <-----------
            )
        )
    )
    
)