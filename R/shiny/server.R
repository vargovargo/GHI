library(shiny)
library(datasets)
library(ITHIM)
library(ggplot2)
library(reshape2)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
#mpgData <- mtcars
#mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

  # Compute the forumla text in a reactive expression since it is
  # shared by the output$caption and output$mpgPlot expressions
#  formulaText <- reactive({
#    paste("mpg ~", input$variable)
#  })

  # Return the formula text for printing as a caption
 # output$caption <- renderText({
 #   formulaText()
  #})

  # Generate a plot of the requested variable against mpg and only
                                        # include outliers if requested

    parameters <- createParameterList(baseline = TRUE)
    means <- computeMeanMatrices(parameters)
    quintiles <- getQuintiles(means)

    ITHIM.baseline <- list( parameters = parameters, means = means, quintiles = quintiles )

    parameters <- createParameterList(baseline = FALSE)
    means <- computeMeanMatrices(parameters)
    quintiles <- getQuintiles(means)

    ITHIM.scenario <- list( parameters = parameters, means = means, quintiles = quintiles )

#)
## ITHIM.scenario <- list(
##   parameters = parameters <- createParameterList(baseline = FALSE),
##   means = means <- computeMeanMatrices(parameters),
##   quintiles = quintiles <- getQuintiles(means)
## )
    comparitiveRisk <- compareModels(ITHIM.baseline,ITHIM.scenario)


    output$ITHIMPlot <- renderPlot({
      #  hist(comparitiveRisk$RR.baseline[[as.character(input$variable)]]$M[,1])
      plotRR(comparitiveRisk$RR.baseline[[input$variable]],comparitiveRisk$RR.scenario[[input$variable]]) + coord_cartesian(ylim = c(0.75, 1.05))+ggtitle(as.character(input$variable))

  })
})
