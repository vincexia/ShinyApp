##
library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
    model1 <- lm(mpg ~ wt, data = mtcars)
    model2 <- lm(mpg ~ wt + cyl, data = mtcars)
    
    model1pred <- reactive({
        wtInput <- input$sliderWeight
        predict(model1, newdata = data.frame(wt = wtInput))
    })
    
    model2pred <- reactive({
        wtInput <- input$sliderWeight
        cylInput <- input$selectCylinder
        predict(model2, newdata = 
                    data.frame(wt = wtInput,
                               cyl = as.numeric(cylInput)))
    })
    
    output$plot1 <- renderPlot({
        wtInput <- input$sliderWeight
        
        plot(mtcars$wt, mtcars$mpg, xlab = "Weight (1000 lbs)", 
             ylab = "Miles/(US) gallon", bty = "n", pch = 16, 
             xlim = c(1.5, 6), ylim = c(10, 35))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        
        legend("topright", c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(wtInput, model1pred(), col = "red", pch = 16, cex = 2)
    })
    
    output$plot2 <- renderPlot({
        wtInput <- input$sliderWeight
        
        g <- ggplot(data = mtcars, aes(x=wt, y=mpg, group=cyl, color=as.factor(cyl))) +
            geom_point()
        g
        if(input$showModel2){
            g + geom_smooth(method = "lm") +
                geom_point(aes(x=wtInput, y=model2pred()), colour="blue", size = 4)
        }
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})
    