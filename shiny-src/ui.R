library(shiny)

shinyUI(fluidPage(
  
  titlePanel("esa記事をWord or PDFで出力"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("numericInput_data",
                   "esaの記事IDを入力",
                   min = 1,
                   value = 1),
      actionButton("render_md", "Markdownを取得"),
      br(),
      uiOutput("download_files")
    ),
    mainPanel(
      verbatimTextOutput("text")
    )
  )
))