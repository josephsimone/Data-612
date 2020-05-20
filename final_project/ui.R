#ui.R
library(shiny)

gl<- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film.Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci.Fi", "Thriller", "War", "Western")

shinyUI(fluidPage(theme = "bootstrap.css",
  
  fluidRow(column(1, offset = 5 ,h1("What2Watch")
    )
  
  ),
  
  fluidRow(column(6,  offset = 5 ,h3("Recommendation System for Movies")
                  
    )
  
  
  ),
  
  fluidRow(
    column(2, 
           helpText("Project Github", 
                    a("Link", href="https://github.com/josephsimone/Data-612/tree/master/final_project", target="_blank")),
            )
  ),
  
  fluidRow(
    
    column(4, offset = 1 ,style = "height:450px",h4("Please Select your Favorite Three Movie Genres: Remember Order Matters!"),
           wellPanel(
      selectInput("input_genre", "Genre #1",
                  genre_list),
      selectInput("input_genre2", "Genre #2",
                  genre_list),
      selectInput("input_genre3", "Genre #3",
                  genre_list),
      submitButton("Update Movie Lists")
    )),
    
    column(4, offset=1, h4("Now Pick a Movie from the Selected Genres:"),
           wellPanel(
      # This outputs the dynamic UI component
      uiOutput("ui"),
      uiOutput("ui2"),
      uiOutput("ui3"),
      submitButton("Get Movie Recommendations")
    ))),
    
   fluidRow( column(7, offset = 4,
           h3("Results:"),
           tableOutput("table")
           #verbatimTextOutput("dynamic_value")
    )
  )
  

))