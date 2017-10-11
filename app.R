teams <- fread('team.csv', sep= ",", header = TRUE)
teams <- read.csv("team.csv", header=T, na.strings=c("","NA"))
group_by(teams, (year/20)*20)
wins = select(teams, team_id, w)

ui <- fluidPage(
  titlePanel("Baseball Data Analysis"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(inputId = "year",
                "Year:",
                choices = 1875:2015,
      selectizeInput(inputId = "ws_win", 
                     label = "Champions",
                     choices = NULL),
      selectizeInput(inputId = "w",
                     label = "wins",
                     choices = NULL)
      )))
     # selectInput(inputId = "pither_id",
                ##  label = "Pitcher",
                ##  choices = NULL), 
    #  selectizeInput(inputId = "w",
                   ##  label = "wins",
                    ## Choices = NULL),
     # selectizeInput(inputId= "era",
                   ##  label = "Earned Run Avg",
                  ##   choices= NULL)
   )
      mainPanel(
        plotOutput("AvgWins"),
        plotOutput("plot", click = "plot_click")
    ) 
  


server <- shinyServer(function(input, output, session) {
  observeEvent(input$year, {
    choices = unique(teams[year == (input$year), ws_win])
    updateSelectizeInput(session, inputId = "ws_win", choices = choices
                         )
  })
  observeEvent(input$w, {
    choices = unique(teams[year == (input$year) &
                             ws_win == input$ws_win, w])
    updateSelectizeInput(session, inputId = "w", choices = choices)
                       
    
 })
  
  
  output$AvgWins <- renderPlot( {
   
    teams[year == input$year &
                  ws_win == teams$ws_win &
                  w == teams$w, 
          by = year]  %>%
    
      gather(key = "team", value = AvgWins, Champions, wins) %>%
      ggplot(aes(x = years, y = AvgWins, fill = TRUE)) +
      geom_col(position = "dodge") + 
      ggtitle("AvgWins") 
  
      }) 

shinyApp(ui = ui, server = server)
})
