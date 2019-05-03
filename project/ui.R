#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("un employement rate in newyork "),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("SliderYear", "hom many years",1900, 2100, value = 1990),
      sliderInput("Sliderlab", "labour force ",1000, 100000000, value = 10000),
       
      
      checkboxInput("ShowModel1", "Show/Hide Model 1", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted unemployement from Model1:"),
      textOutput("pred1"),
      h3(" data  :"),
      textOutput("data")
    )
  )
))
