source("global.R")
library(promises)
library(future)

# Ensure future supports multiprocess execution
plan(multisession)

# Prevent Shiny from timing out too soon
options(shiny.maxRequestSize = 50 * 1024^2)  # Increase request size limit
Sys.setenv(SHINY_HOST = "0.0.0.0", SHINY_PORT = 3838, SHINY_TIMEOUT = 600)

ui <- fluidPage(
  useShinyjs(),  
  use_busy_spinner(spin = "radar", position = "top-right", color = "#fff"),
  
  titlePanel("Slices35"),
  
  sidebarLayout(
    sidebarPanel(
      input_dark_mode(id = "dark"), 
      textOutput("mode"),
      
      # Server-side processing for selectize input (improves performance)
      selectizeInput("selected_player", "Select Player:", choices = NULL, options = list(placeholder = "Select a player")),
      selectInput("competition", "Select Competition:", choices = c("Premier League", "Bundesliga", "La Liga", "Serie A", "Ligue 1")),
      selectInput("scouting_period", "Select Scouting Period:", choices = rev(paste0(2017:2024, "-", (2018:2025)))),
      selectInput("template", "Player Position Template:", choices = c("Striker" = "ST", "Winger" = "W", "Attacking Mid" = "AM", "Central Mid" = "CM", "Defensive Mid" = "DM", "Full Back" = "FB", "Center Back" = "CB")),
      selectInput("style", "Select Style:", choices = c("Liverpool", "Politik", "Severance")),
      selectInput("pos_versus", "Position Versus:", choices = c("primary", "secondary")),
      selectInput("benchmark", "Benchmark Type:", choices = c("Numeric", "Dummy")),
      
      actionButton("generate", "Generate Radar Plot"),
      downloadButton("downloadImage", "Save The Slice")
    ),
    
    mainPanel(
      uiOutput("errorMessage"),
      textOutput("imageInfo"),
      
      div(style = "display: flex; justify-content: center; align-items: center; height: 80vh;",
          imageOutput("radarPlot", width = "100%", height = "auto")),
      
      div(class = "history-nav",
          actionButton("prevImage", icon("arrow-left")),
          span(textOutput("imageCounter")),
          actionButton("nextImage", icon("arrow-right"))
      )
    )
  )
)

server <- function(input, output, session) {
  DB_CONNECTION <- setupDatabase()
  
  values <- reactiveValues(
    currentImageIndex = 1,
    totalImages = 0,
    imageHistoryData = NULL
  )
  
  getImageHistory <- function() {
    dbGetQuery(DB_CONNECTION, "SELECT * FROM image_history ORDER BY created_at DESC LIMIT 5")
  }

  updateDisplay <- function() {
    if (is.null(values$imageHistoryData) || nrow(values$imageHistoryData) == 0) {
      output$radarPlot <- renderImage({ list(src = "", alt = "No images available") }, deleteFile = FALSE)
      return()
    }

    currentImage <- values$imageHistoryData[values$currentImageIndex, ]
    img_path <- file.path("www", currentImage$filepath)
    
    output$imageInfo <- renderText({
      paste0(currentImage$player_name, " - ", currentImage$competition, " (", currentImage$period, ")")
    })
    
    output$radarPlot <- renderImage({
      list(src = img_path, contentType = "image/png", alt = "Radar Chart")
    }, deleteFile = FALSE)
  }

  # ✅ Enable server-side processing for selectize input
  observe({
    req(Top5dfUrls)
    updateSelectizeInput(session, "selected_player", choices = setNames(Top5dfUrls$UrlFBref, Top5dfUrls$Name), server = TRUE)
  })

  # ✅ Fix timeout: Run Analysis() asynchronously
  observeEvent(input$generate, {
    req(input$selected_player, input$competition, input$scouting_period, input$template, input$style)
    show_spinner()
    
    player_url <- input$selected_player  
    league_input <- paste(input$scouting_period, input$competition)

    future_promise({
      Analysis(
        player_url = player_url, 
        league_comp_name = league_input,  
        template = input$template, 
        style = input$style, 
        pos_versus = input$pos_versus, 
        benchmark = input$benchmark
      )
    }) %...>% {
      img_dir <- "Radars"
      latest_file <- list.files(img_dir, full.names = TRUE, pattern = "\\.png$", ignore.case = TRUE) %>%
        file.info() %>%
        dplyr::as_tibble(rownames = "filepath") %>%
        dplyr::arrange(desc(mtime)) %>%
        dplyr::slice(1) %>%
        dplyr::pull(filepath)
      
      www_path <- file.path("www", basename(latest_file))
      file.copy(latest_file, www_path, overwrite = TRUE)
      
      dbExecute(DB_CONNECTION, "
        INSERT INTO image_history (filepath, player_name, competition, period, template, style)
        VALUES (?, ?, ?, ?, ?, ?)", 
        params = list(basename(latest_file), getPlayerNameFromUrl(player_url), input$competition, input$scouting_period, input$template, input$style)
      )
      
      values$imageHistoryData <- getImageHistory()
      values$totalImages <- nrow(values$imageHistoryData)
      values$currentImageIndex <- 1
      updateDisplay()
    } %...!% {
      function(e) {
        output$errorMessage <- renderUI({
          div(class = "error-card",
              div(style = "padding: 10px; background-color: #ffdddd; color: #a94442; border-left: 5px solid #a94442; border-radius: 5px; margin-bottom: 10px;",
                  strong("❌ Error: "), as.character(e$message)
              )
          )
        })
      }
    }
    
    hide_spinner()
  })

  observeEvent(input$prevImage, {
    if (values$currentImageIndex > 1) {
      values$currentImageIndex <- values$currentImageIndex - 1
      updateDisplay()
    }
  })

  observeEvent(input$nextImage, {
    if (values$currentImageIndex < values$totalImages) {
      values$currentImageIndex <- values$currentImageIndex + 1
      updateDisplay()
    }
  })

  onStop(function() {
    if (!is.null(DB_CONNECTION) && dbIsValid(DB_CONNECTION)) {
      dbDisconnect(DB_CONNECTION)
    }
  })
}

shinyApp(ui = ui, server = server)
