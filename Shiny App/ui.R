library(shiny)


# Load the required libraries
library(datasets)
library(ggplot2)


# Defining the UI
shinyUI(fluidPage(
    
  # Defining the title
  titlePanel("Intercountry Life-Cycle Savings"),
   
  # Inserting a sidebar
  sidebarLayout(
      
    # Inserting the sliderbars 
    sidebarPanel(
        selectInput("input1", "Select the first country", choices = rownames(LifeCycleSavings)),
        selectInput("input2", "Select the second country", choices = rownames(LifeCycleSavings)),
        hr(),
        helpText("This shiny app calculates the difference of two variables about the countries selected: the disposable income and the percent of the aggregate personal savings. By selecting the available countries the results can be observed below. 
                 Note that a result with minus (-), indicates that the first country selected has less value than the second one."),
        hr(),
        helpText("The source code of this programme, can be found at: https://github.com/IoannisLabrakis/Week-4-Developing-data-product ")
        ),
    

    mainPanel(
       plotOutput("plot"),
       h3("The difference of selected countries' disposable income"),
       textOutput("diff1"),
       h3("The difference of selected countries' aggregate personal savings (%)"),
       textOutput("diff2")
    
    )
  )
))
