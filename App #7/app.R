library(shinydashboard)
library(shiny)

eyeData <- read.csv("eye_diseases_refined.csv")
glaucoma <- eyeData[13:18, ]
macular <- eyeData[1:6, ]
cataract <- eyeData[7:12, ]
diabetic <- eyeData[19:23, ]

ui <- dashboardPage(
 
   skin = "black",
  dashboardHeader(title = "Eye Diseases in Adults Over 40: 2011", titleWidth = 250),
  dashboardSidebar( width = 350,
    sidebarMenu(
      menuItem("Data Table", tabName = "dataTable", icon = icon("DataTable")), 
      menuItem("Cataracts Plot", tabName = "cataracts", icon = icon("Cataracts")),
      menuItem("Glaucoma Plot", tabName = "glaucoma", icon = icon("Glaucoma")),
      menuItem("Diabetic Retinopathy Plot", tabName = "diabeticRetinopathy", icon = icon("DiabeticRetinopathy")),
      menuItem("Macular Degeneration Plot", tabName = "macularDegeneration", icon = icon("MacularDegeneration"))
    )
  ),
  dashboardBody(
    
    tabItems(
      tabItem(tabName = "dataTable",
              fluidRow(
                box(tableOutput("table")
                )
              )
      ),

      tabItem(tabName = "cataracts",
              fluidRow(
                box(plotOutput("plotCataracts")
                )
              )
      ),
      
      tabItem(tabName = "glaucoma",
              fluidRow(
                box(plotOutput("plotGlaucoma")
                )
              )
      ), 
      
      tabItem(tabName = "diabeticRetinopathy",
              fluidRow(
                box(plotOutput("plotDiabetic")
                )
              )
        
      ), 
      
      tabItem(tabName = "macularDegeneration",
              fluidRow(
                box(plotOutput("plotMacular")
                )
              )
      )
    )
  )
)



server <- function( input, output ){
  
  output$table <- renderDataTable({ 
      print(eyeData) 
    })
  
  output$plotCataracts <- renderPlot ({
    states1 <- c("Alaska", "California", "Massachusetts", "New Jersey", "Ohio", "Texas")
    barplot(cataract$Data_Value, names.arg = states1, xlab = "State",
            ylab = "Percent of Adults Who Have Cataracts", 
            ylim = c(0, 25), main = "Cataracts", col = "darkcyan")
    
  })
  
  output$plotGlaucoma <- renderPlot({
    states1 <- c("Alaska", "California", "Massachusetts", "New Jersey", "Ohio", "Texas")
    barplot(glaucoma$Data_Value, names.arg = states1, xlab = "State",
            ylab = "Percent of Adults Who Have Glaucoma", 
            ylim = c(0, 6), main = "Glaucoma", col = "violetred2")
    
  })
  
  output$plotDiabetic <- renderPlot({
    states2 <- c("Alaska", "California", "Massachusetts", "New Jersey", "Ohio")
    barplot(diabetic$Data_Value, names.arg = states1, xlab = "State",
            ylab = "Percent of Adults Who Have Diabetic Retinopathy",
            ylim = c(0,30), main = "Diabetic Retinopathy", col = "palegreen")
    
    
  })
  
  output$plotMacular <- renderPlot({
    states1 <- c("Alaska", "California", "Massachusetts", "New Jersey", "Ohio", "Texas")
    barplot(macular$Data_Value, names.arg = states1, xlab = "State",
            ylab = "Percent of Adults Who Have Age-Related Macular Degeneration",
            ylim = c(0,6), main = "Age-Related Macular Degeneration", col = "orange")
    
    
  })
  
}


shinyApp( ui = ui, server = server )