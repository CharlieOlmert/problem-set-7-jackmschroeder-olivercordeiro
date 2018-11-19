#We load in the necessary libraries.
library(shiny)
library(tidyverse)
library(readr)
library(ggrepel)

#We read in the RDS file.
ps7 <- readRDS("ps7.rds")

#Defining the UI.
ui <- fluidPage(
   
   #We make an application title,
   titlePanel("The Upshot Correctly Weighed Poll Results"),
   
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
        (respondents with a high final_weight)."),
        br(),
        plotOutput("myPlot"),
        br(),
        h4("Correlation Results:"),
        p("(1) Given all the slack polling is getting these days with failing to properly sample and weigh their respsective populations, we were expecting
                a strong correlation between the two variables. Instead, the correlation between margin of error and outlier percentage was -0.1437853. This is not
                statistically significant, and shows that the model was largely correct in weighing its respondents."),
        p("(2) The correlation among Democratic flips was 0.05736348. This implies that The Upshot was very precise in weighing outliers
                in districts that actually flipped."),
        p("(3) The correlation among Republican holds was -0.2637483. This is a very weak correlation, but it demonstrates that the largest fault in
                The Upshot's model was over-emphasizing Democrat-leaning outliers in Republican incumbent districts.")
        
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
       geom_label_repel(aes(label = district), size = 3, force = 3) +
#This code assigns colors to our D and R values.
       scale_color_manual(values = c(D = "blue", R = "red"))
   })
}

#We run the application. 
shinyApp(ui = ui, server = server)

