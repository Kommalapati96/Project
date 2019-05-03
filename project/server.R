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
  output$data  <-   renderPlot(
    
   "My source : https://catalog.data.gov/dataset/local-area-unemployment-statistics-beginning-1976
My question: how the un employement rate varies in newyork state from 1976 to 2019 with respective labor force and area.
   Firstly linear approach to modelling the relationship between a scalar response (or dependent variable) and one or more explanatory variables (or independent variables). The case of one explanatory variable is called simple linear regression. For more than one explanatory variable, the process is called multiple linear regression.
   In my data  dependent variable: Unemployment.Rate
   independent variables: year, Labor.Force,area.
   Using my data I have taken three models
   In model1  I chose  simple linear regression. 
   lm(formula = Unemployment.Rate~Year,data = NewYork)
   we predicted the unemployment using the data. we have determined that the intercept -5.806986 is  and the coefficient for the year  is 0.005687. we can predict unemployemen.rate by using formula = -5.806986 + 0.005687*year.in my question asks what the expected un employment for the particular year . by using above formula I calculated expected un employment .rate. I get Adjusted R-squared:  0.0005619.
   
   In model2 chose multiple linear regression. 
   lm(formula = Unemployment.Rate~Year+Labor.Force,data = NewYork) we predicted the unemployment using the data. we have determined that the intercept -1.032e+01
   is  and the coefficient for the year  is 7.909e-03
   . the coefficient for the  Labor.Force is 1.988e-07
   . we can predict unemployemen.rate by using formula = -1.032e+01+ 7.909e-03
   *year +  1.988e-07 + Labor.Force. in my question asks what the expected un employment for the particular year . by using above formula I calculated expected un employment .rate. I get Adjusted R-squared:  0.009488
   .
   
   In model2 chose multiple linear regression. 
   Lm(Unemployment.Rate~Year+Labor.Force+ factor(Area))predicted the unemployment using the data. we have determined that the intercept -1.032e+01
   is  and the coefficient for the year  is 7.909e-03
   . the coefficient for the  Labor.Force is 1.988e-07
   . we can predict unemployemen.rate by using formula = -1.032e+01+ 7.909e-03
   *year +  1.988e-07 + Labor.Force + co-efficent of different area * factor(Area)). in my question asks what the expected un employment for the particular year . by using above formula I calculated expected un employment .rate. I get Adjusted R-squared:  Adjusted R-squared:  0.3633.
   
   
   By using Adjusted R-squared I selected model 3 as best model and I created a shiny app . I created a slider on the x-axis moving that slider on the selected year we get predicted  un employmentrate  value . 
   "
    
  )
  
  output$pred1  <-  renderText({
    model1pred()
  })
})
