## Shiny App UI

# load shiny package
library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict MPG from Weight"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderWeight", "What is the weight of the car?", 1.5, 6, value = 3.5),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit")
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Model Prediction", 
                                 plotOutput("plot1"),
                                 h3("Predicted MPG from Model 1:"),
                                 textOutput("pred1"),
                                 h3("Predicted MPG from Model 2:"),
                                 textOutput("pred2")), 
                        tabPanel("Documentation", h3("The Shiny application shows 
                                                     the predictions of MPG based on the weight in mtcars
                                                     dataset."),
                                 h3("The 1st model is the linear model of mpg over wt."),
                                 h3("The 2nd model is the linear model of mpg over wt and wtsp, where wtsp 
                                    takes the threshold value 3.5 in wt. If wt is larger than 3.5, wtsp is 
                                    the difference below wt and 3.5, otherwise wtsp is zero. "),
                                 
                                 h3("In general, the line for the 1st model is straight line, and the line 
                                    for the 2nd model is a broken line at point wt = 3.5. ")) 
            )
        )
    )
))

