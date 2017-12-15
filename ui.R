#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

CHI_ResInspections = read.csv("Food_Inspections.csv", sep = ",") 

library(shiny)
library(leaflet)
install.packages("plotly")
library(plotly)
install.packages("shinythemes")
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("united"),

  
  # Application title
  headerpanel("Chicago Restaurant Analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sidebarPanel(
        div(style="display: inline-block;vertical-align:top; width: 120px;",
            selectInput("year", label = "Select Year:",
                        choices = list("2015" = '2015', "2016" = '2016'),
                        selected = "2015")),
        div(style="display: inline-block;vertical-align:top; width: 120px;",
            selectInput("month", label = "Select Month:", 
                        choices = list("Jan"='01',
                                       "Feb"='02',
                                       "Mar"='03',
                                       "Apr"='04',
                                       "May"='05',
                                       "Jun"='06',
                                       "Jul"='07',
                                       "Aug"='08',
                                       "Sep"='09',
                                       "Oct"='10',
                                       "Nov"='11',
                                       "Dec"='12',
                                       "None"='None'), selected= "Jan")),
        div(style="display: inline-block;vertical-align:top; width: 120px;",
            selectInput("day", label = "Select Day:",choices=unique_days)),

        selectInput("Risk",
                    choices = sort(factor(unique(CHI_ResInspections$Risk), levels = "Risk 1 (High)", "Risk 2 (Medium)", "Risk 3 (Low)")))    
                    ),
        checkboxInput("checkbox", label = ("High Risk Areas of Chicago by Zip Code"), value = FALSE),
      
        selectInput("bar_postcode",
                    "Plot Total Number of Violations for Top 5 Zip Codes"),
                    choices = c("60618", "60625", "60616", "60639", "60634"))
  ),
    
    # Show CHICAGO MAP with location markers for respective restaurants
    mainPanel(
      tabsetPanel(
        tabPanel("Chicago Restaurant Map", leafletOutput("map", width = "100%", height = 400)),
        tabPanel("Bar Chart: Risk Violations by Chicago Zip Codes ", plotlyOutput("zip", width = "100%", height = 400)),
        tabPanel(paste("Bar Chart: Top 5 Restaurants in Zip"),
                 plotlyOutput("Zip", width = "100%", height=400))
        
        
        )
      )
    )
  )

