library(shiny)
library(igraph)
suppressPackageStartupMessages(library(threejs, quietly=TRUE))

#ALL <- readRDS("ALL_NETWORKS.RDS")
ALL <- readRDS("T:/Research folders/CCWTG/Data/MERGEALL/ALL_NETWORKS.RDS")

role <-  c("mentee", "mentor", "mentor coach", "lead mentor coach", "instructor") 
color <- c("orange","green","dodgerblue", "red", "grey50")

# Define UI for application
ui <- fluidPage(
  titlePanel("Campus Connections Networks"),
  
  
  
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      # Select variable for Semester
      selectInput(inputId = "sem", 
                  label = "Semester",
                  choices = c("F15", "S16", "F16", "S17"), 
                  selected = "F15"),
      
      # Select variable for Night
      selectInput(inputId = "night", 
                  label = "Night",
                  choices = c("monday", "tuesday", "wednesday", "thursday"), 
                  selected = "monday"),
      
      # Select time point
      selectInput(inputId = "survey", 
                  label = "survey_number",
                  choices = c("g1", "g2", "g3", "g4", "g5"),
                  selected = "g1")
    ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "plot")
    )
  )
)

# Define server function
server <- function(input, output) {
  
  # Define output
  output$plot <- renderPlot({
    plot.igraph(ALL[[input$sem]][[input$night]][["graphs"]][[input$survey]], vertex.label = NA, edge.color = "black",
                edge.width=E(ALL[[input$sem]][[input$night]][["graphs"]][[input$survey]])$weight/3, vertex.size= 5)
    legend("bottomright", legend=role  , col = color , bty = "o", pch=20 , pt.cex = 1, cex = 1, text.col= color , horiz = FALSE, inset = c(0, 0))
  }, height = 1000, width = 1000)
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)