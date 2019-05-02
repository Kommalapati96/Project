#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  model1 <-  lm(formula = Unemployment.Rate~Year+Labor.Force+ factor(Area),data = NewYork)
  
  model1pred  <-  reactive({
    yearInput  <-  input$SliderYear
    linput <- input$Sliderlab
    
    
    predict(model1, newdata = data.frame( Year = yearInput,
                                          Labor.Force = linput,
                                          Area = 'Albany City'
                                          
                                          ))
  })
  
  year  <-  reactive({
  
    
    yearInput  <-  input$SliderYear
    
  })
  output$plot1  <-   renderPlot(
    
    
    ggplot(NewYork, aes(x = Year, y = residuals)) + geom_point()+ 
      geom_segment(aes(xend = Year, yend = 0), alpha = .2) + geom_hline(
        yintercept=0) + geom_point(aes(x = year() , y = 0), color = 'blue')
    
  )
  
  output$pred1  <-  renderText({
    model1pred()
  })
})
