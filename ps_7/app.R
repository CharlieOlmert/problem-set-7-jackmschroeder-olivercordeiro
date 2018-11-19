#We load in the necessary libraries.
library(shiny)
library(tidyverse)
library(readr)

#We read in the RDS file.
ps7 <- readRDS("ps7.rds")

#Defining the UI.
ui <- fluidPage(
   
   #We make an application title,
   titlePanel("Upshot Correctly Weighed Poll Results"),
   
   #We make a sidebar that selects based on seat status. 
   sidebarLayout(
      sidebarPanel(
         selectInput("flip",
                     "Seat Status",
                     choices = unique(ps7$flip))
      ),
      
      # Show a plot of the generated distribution. Include description text. 
      mainPanel(
        p("We set out to judge how accurate The Upshot was in calculating final weight in its polling.
          We did this by finding the correlation between margin of error (forecasted Democratic
        advantage minus actual Democratic advantage) and the percentage of outliers in each poll
        (respondents with a high final_weight). Given all the slack polling is getting these days
        with failing to properly sample and weigh their respsective populations, we were expecting
        a strong correlation between the two variables. Instead, as a whole, we found no correlation."),
        br(),
        plotOutput("myPlot"),
        br(),
        p("Two notes:"),
        p("(1) UT-04 is still yet to be officially called, but is looking like a Republican hold. Our
          data reflect that."),
        p("(2) Our outlier percentage is based on all available polls for each district in order to get
          an accurate tally of Upshot outliers. However, when calculating margin of error, we used
          only the most recent poll in each district. We did this because within each district, the
          percentage of outliers is not dependent on time, but the forecasted margin of error is.")
        
      )
   )
)

#We make the server logic necessary to make the output plot.
server <- function(input, output) {
   
   output$myPlot <- renderPlot({
#We use ps7 and filter by seat status to make our graph.
    ps7 %>% 
       filter(flip %in% input$flip) %>% 
#We make a scatter plot using margin of error and outlier percentage (with party as color).
       ggplot(aes(x = margin_of_error, y = outlier_per, color = win_party)) +
       geom_point() +
#This regression line changes color according to which party it tracks.
       geom_smooth(method = "lm") +
#We also add graph and axis titles.
       ggtitle("Margin of Error vs. Outlier Percentage in Upshot Polling", subtitle = "Sorted by Seat Status, Colored by Winning Party") +
       xlab("Margin of Error") +
       ylab("Outlier Percentage") +
#This code assigns colors to our D and R values.
       scale_color_manual(values = c(D = "blue", R = "red"))
   })
}

#We run the application. 
shinyApp(ui = ui, server = server)

