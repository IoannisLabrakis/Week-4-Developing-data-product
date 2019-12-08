library(shiny)


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

