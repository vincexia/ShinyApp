##
library(shiny)
shinyServer(function(input, output) {
    mtcars$wtsp <- ifelse(mtcars$wt - 3.5 > 0, mtcars$wt - 3.5, 0)
    model1 <- lm(mpg ~ wt, data = mtcars)
    model2 <- lm(mpg ~ wtsp + wt, data = mtcars)
    
    model1pred <- reactive({
        wtInput <- input$sliderWeight
        predict(model1, newdata = data.frame(wt = wtInput))
    })
    
    model2pred <- reactive({
        wtInput <- input$sliderWeight
        predict(model2, newdata = 
                    data.frame(wt = wtInput,
                               wtsp = ifelse(wtInput - 3.5 > 0,
                                              wtInput - 3.5, 0)))
    })
    
    output$plot1 <- renderPlot({
        wtInput <- input$sliderWeight
        
        plot(mtcars$wt, mtcars$mpg, xlab = "Weight (1000 lbs)", 
             ylab = "Miles/(US) gallon", bty = "n", pch = 16, 
             xlim = c(1.5, 6), ylim = c(10, 35))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                wt = 1.5:6, wtsp = ifelse(1.5:6 - 3.5 > 0, 1.5:6 - 3.5, 0)
            ))
            lines(1.5:6, model2lines, col = "blue", lwd = 2)
        }
        
        legend("topright", c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(wtInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(wtInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})
    