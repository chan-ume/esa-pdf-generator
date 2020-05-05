library(shiny)
library(httr)
library(dplyr)

esa_info <- read.csv("esa_info.csv")
headers <- httr::add_headers(`Authorization` = paste("Bearer", esa_info[1, 1]),
                           `Content-Type`  = "application/json")
team_name <- esa_info[1, 2]

shinyServer(function(input, output, session) {  
  output$text <- renderText({    
    paste(markdown_text())
  })

  markdown_text <- reactive({
    input$render_md
    input_id <- isolate(input$numericInput_data)

    api_result <- GET("http://api.esa.io",
           path = paste("v1/teams", team_name, "posts", input_id, sep = "/"),
           config = headers)
    
    if (api_result %>% status_code() != 200){
        return(paste("API Error:", api_result %>% status_code()))
    }

    contents <- api_result %>% content()
    write(contents$body_md, paste("www/sample_", input_id, ".md", sep=""))

    if (reference_word_file() == ""){
      reference_word_file_path <- "www/reference.docx"
    }
    else {
      reference_word_file_path <- reference_word_file()
    }

    system(paste("pandoc -f markdown -t docx www/sample_", input_id, ".md -o www/sample_", input_id, ".docx --reference-doc=", reference_word_file_path, sep=""))
    system(paste("pandoc -t latex www/sample_", input_id, ".docx -o www/sample_", input_id, ".pdf  --pdf-engine=xelatex -V documentclass=bxjsarticle -V classoption=pandoc", sep=""))
    
    return(contents$body_md)
  })

  reference_word_file <- reactive({
    inFile <- input$template
    
    if (is.null(inFile)){
      return("")
    }

    return(inFile$datapath)
  })

  output$download_files <- renderUI({
    input_id <- input$numericInput_data
    tagList(
      h3(tags$a(href=paste("sample_", input_id, ".docx", sep=""), target="blank", "Download Word", download=paste("sample_", input_id, ".docx", sep=""))),
      h3(tags$a(href=paste("sample_", input_id, ".pdf", sep=""), target="blank", "Download PDF", download=paste("sample_", input_id, ".pdf", sep=""))),
    )
  })
})