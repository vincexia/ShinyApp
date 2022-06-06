## Shiny App UI

# load shiny package
library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict MPG from Weight and Cylinder"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderWeight", "What is the weight of the car?", 1.5, 6, value = 3.5),
            selectInput("selectCylinder", "Cylinder number:",
                        c(4, 6, 8)),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit")
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Model Prediction", 
                                 plotOutput("plot1"),
                                 plotOutput("plot2"),
                                 h3("Predicted MPG from Model 1:"),
                                 textOutput("pred1"),
                                 h3("Predicted MPG from Model 2:"),
                                 textOutput("pred2")), 
                        tabPanel("Documentation", h3("The Shiny application shows 
                                                     the predictions of MPG based on the weight and cylinder in mtcars
                                                     dataset."),
                                 h3("The 1st model is the linear model of mpg over wt."),
                                 h3("The 2nd model is the linear model of mpg over wt and cyl, where cyl 
                                    is the number of cylinders with selection of value 4, 6 or 8. "),
                                 
                                 h3("In general, the line for the 1st model is straight line, and the 2nd model has 
                                    one line for each cylinder selection.")) 
            )
        )
    )
))

