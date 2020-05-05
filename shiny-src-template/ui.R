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
      h3("テンプレート用のファイルをアップロードしてください"),
      a(href="reference.docx", target="blank", "サンプルのテンプレートファイル", download="reference.docx"),
      p("上のファイルをダウンロードして、Wordで開き見出し等のフォントを変更してください"),
      fileInput("template", "Choose Template Docx File",
                multiple = FALSE,
                accept = c(".docx")),
      uiOutput("download_files")
    ),
    mainPanel(
      verbatimTextOutput("text")
    )
  )
))