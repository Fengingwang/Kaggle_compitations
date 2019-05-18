## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard",
                  dropdownMenu(type = 'message',
                               messageItem(from = 'Datacut', message='Data update at 2019-05-01'),
                               messageItem(from = 'Update', message='Dashboard update at 2019-05-11')
                               ),
                  dropdownMenu(type = 'notifications',
                               notificationItem(
                                 text = 'Efficacy Data unavailable right now',
                                 icon = icon('warning'),
                                 status = 'warning'
                               ),
                               notificationItem(
                                 text = 'Safety Data fully updated',
                                 icon = icon('dashboard'),
                                 status = 'success'
                               )
                               ),
                  dropdownMenu(type = 'tasks',
                               taskItem(
                                 value = 30,
                                 color = 'aqua',
                                 'Contact sites for potential duplicate patients'
                               ),
                               taskItem(
                                 value = 35,
                                 color = 'red',
                                 'Site performance evluation'
                               )
                               )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem('xxxx CDRS', tabName = 'dashboard', icon = icon('dashboard')),
      menuItem('Patient Disposition', tabName = 'ds'),
       menuSubItem('Histogram', tabName = 'hist'),
       menuSubItem('Summary of Dispostion', tabName = 'sd'),
      menuItem('Randomization', tabName = 'rand'),
      menuItem('Demographic and Baseline Data', tabName = 'dm'),
      menuItem('Concomitant', tabName = 'cm'),
      menuItem('Laboratory Data', tabName = 'lab'),
      menuItem('Adverse Event', tabName = 'ae'),
      menuItem('Protocol Deviation', tabName = 'pd'),
      menuItem('Efficacy', tabName = 'eff'),
      menuItem('Scientific Misconduct', tabName = 'sm')
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = 'hist',
        fluidRow(
          column(
            width = 12,
            infoBox('AE', 10, color = 'red', icon = icon('warning')),
            infoBox('SAE', 0, icon = icon('thumbs-up')),
            infoBox('Death', 0, icon = icon('thumbs-up'))
          )
        ),
        fluidRow(
          box(title = 'Histogram', status = 'primary', solidHeader = T, background = 'aqua', plotOutput('hist')),
          box(title = 'Control for Histogram', status = 'warning', solidHeader = T,
              'Use these controls to fine tune your dashboard', br(),
              'Do not use lot of control as it confuses the user',
              sliderInput('bins', 'Number of Breaks', 1, 100, 50))
        )
      )
    )
  )
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(faithful$eruptions, breaks = input$bins, xlab = NULL, ylab = NULL, main = NULL)
  })
}

shinyApp(ui, server)