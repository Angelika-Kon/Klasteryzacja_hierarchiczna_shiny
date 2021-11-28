#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel(paste(c("Klasteryzacja Hierarchiczna"))),
    sidebarLayout(
        sidebarPanel(
            sliderInput("klastry",
                        "Liczba klastrów:",
                        min=1,
                        max=24,
                        value=8),
            selectInput("variable", "Nazwa",
                        list("cdr"="cdr",
                             "kgh"="kgh"),
                        selected =1)
        ),
        mainPanel(
            h2(textOutput("name1")),
            h3(verbatimTextOutput("print1")),
            fluidRow(
                column(6, plotOutput("Plot1")),
                column(6,plotOutput("Plot2"))
            )
        )
    )
))