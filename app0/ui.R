#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(colourpicker)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Pope's Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 30,
                        value = 20,
                        animate = animationOptions(interval= 1000, loop = FALSE)),
            selectInput(inputId = "couleur",
                        label = "choisir une couleur",
                        choices = c("green", "blue", "white"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)
