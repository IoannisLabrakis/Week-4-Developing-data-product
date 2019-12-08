Course Project: Week 4 assignment
========================================================
author: Ioannis Labrakis
date: 7 December 2019
autosize: true
width: 1440
height:1440

Introduction
========================================================

The Shiny application represented shows a barplot of the Countries savings dated from 1960-1970, presenting their disposable income and calculates two differences between two selected countries. Those differences concern the disposable income and aggregate personal savings. It refers to the percentage of population being less than 15 years old and the percentage of the population being over 75 years old.

The user can select between 50 different countries in order to calculate the available differences

More details:

- Shiny application: https://ioannisla.shinyapps.io/Course_project_week4/

- source code: https://github.com/IoannisLabrakis/Week-4-Developing-data-product


The Data
========================================================

The data used were take from the r dataset LifeCycleSavings, developed by Franco Modigliani. It contains variables about the per-capita disposable income (dpi), the aggregate personal savings (sr), the percentage rate of change in per-capita disposable income (ddpi), and two demographic ones: the percentage of population less than 15 years old (pop15) and the percentage of the population over 75 years old (pop75). The data are averaged over the decade 1960–1970 to remove the business cycle or other short-term fluctuations. 


```
             sr pop15 pop75     dpi ddpi
Australia 11.43 29.35  2.87 2329.68 2.87
Austria   12.07 23.32  4.41 1507.99 3.93
Belgium   13.17 23.80  4.43 2108.47 3.82
Bolivia    5.75 41.89  1.67  189.13 0.22
Brazil    12.88 42.19  0.83  728.47 4.56
Canada     8.79 31.72  2.85 2982.88 2.43
```

The app
========================================================
- The app provides a graph of the countries' savings with their disposable income 
- The user selects two different countries of his or her choice
- The calculation of the two results is automatically generated

R code for the application


```r
#ui.R code
library(shiny)
library(datasets)
library(ggplot2)
# Defining the UI
fluidPage(
  titlePanel("Intercountry Life-Cycle Savings"),
  # Inserting a sidebar
  sidebarLayout(
  # Inserting the sliderbars 
  sidebarPanel(
    selectInput("input1", "Select the first country", choices = rownames(LifeCycleSavings)),
    selectInput("input2", "Select the second country", choices = rownames(LifeCycleSavings)),
    hr(),
    helpText("This shiny app calculates the difference of two variables about the countries selected: the disposable income and the percent of the aggregate personal savings. By selecting the available countries the results can be observed below. Note that a result with minus (-), indicates that the first country selected has less value than the second one."),
    hr(),
    helpText("The source code of this programme, can be found at ")),
  mainPanel(
       plotOutput("plot"),
       h3("The difference of selected countries' disposable income"),
       textOutput("diff1"),
       h3("The difference of selected countries' aggregate personal savings (%)"),
       textOutput("diff2")
    )))
```

=========================================================

```r
#server.R
shinyServer(function(input, output) {
    #Difference in countries' disposable income
    output$diff1 <- renderText({as.numeric(LifeCycleSavings[which(rownames(LifeCycleSavings) == input$input1),][4] - 
                                        LifeCycleSavings[which(rownames(LifeCycleSavings) == input$input2),][4])})
        
    #Difference in countries' aggregate personal savings
    output$diff2 <-  renderText({as.numeric(LifeCycleSavings[which(rownames(LifeCycleSavings) == input$input1),][1] - 
                                         LifeCycleSavings[which(rownames(LifeCycleSavings) == input$input2),][1])})
    ##creating the plot
    output$plot <- renderPlot({
        g <- ggplot(LifeCycleSavings, mapping = aes(x=rownames(LifeCycleSavings), y=sr, fill = dpi)) +
            geom_bar(stat = "identity", width = 0.5) + geom_col() +
            xlab("Countries") + ylab("Aggregate Personal Savings") + labs(fill = "Disposable income") +
            coord_flip()
        g

   })
})
```


