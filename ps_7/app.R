#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readr)
ps7 <- readRDS("ps7.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Deez nutz"),
   
   # Sidebar with a select input for seat flip 
   sidebarLayout(
      sidebarPanel(
         selectInput("flip",
                     "Seat Status",
                     choices = unique(ps7$flip))
      ),
      
      # Show a plot of the generated distribution. Include description text. 
      mainPanel(
         plotOutput("myPlot"), 
         "We set out to judge how accurate The Upshot was in calculating final_weight 
          We did this by finding the correlation between margin of error (forecasted 
         Democratic advantage minus actual Democratic advantage) and the percentage 
         of outliers in each poll (respondents with a high final_weight). Given all 
         the slack polling is getting these days with failing to properly sample and 
         weigh their respective populations, we were expecting a strong correlation 
         between the two variables. Instead, we found no correlation. We are currently 
         at work on making a Shiny app displaying these results. Do we need to do any 
         more work with the data, or is our conclusion interesting enough to stand on 
         its own? While the headline 'Upshot Correctly Weighed Results' isn't attractive 
         on its own, given most people distrust polling these days, I think our findings 
         are rather significant."
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$myPlot <- renderPlot({
    ps7 %>% 
       filter(flip %in% input$flip) %>% 
       ggplot(aes(x = margin_of_error, y = outlier_per, color = win_party)) +
       geom_point() +
       geom_smooth(method = "lm") +
       ggtitle("Margin of Error vs. Outlier Percentage in Upshot Polling", subtitle = "Sorted by Seat Status, Colored by Winning Party") +
       xlab("Margin of Error") +
       ylab("Outlier Percentage") +
       scale_color_manual(values = c(D = "blue", R = "red"))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

