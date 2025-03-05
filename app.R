source("global.R")

ui <- fluidPage(
  useShinyjs(),  
  use_busy_spinner(spin = "radar", position = "top-right", color = "#fff"),
  # Add custom CSS styling
  tags$style(
    HTML("
      #radarPlot img {
        max-width: 100%;  /* Ensure it fits within the container */
        max-height: 80vh; /* Limits image height to 80% of viewport height */
        display: block;
        margin: auto;  /* Centers the image */
      }
      .error-card {
        position: relative;
        max-width: 600px;
        margin: 10px auto;
        text-align: left;
      }
      .history-nav {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
      }
      .history-nav button {
        margin: 0 10px;
      }
      .image-info {
        text-align: center;
        margin-bottom: 10px;
        font-style: italic;
      }
      /* Style disabled buttons */
      .history-nav .btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
      }
    ")
  ),
  
  titlePanel("Slices35"),  # App Title
  sidebarLayout(
    sidebarPanel(
      page_fluid(
        input_dark_mode(id = "dark"), 
        textOutput("mode")
      ),
      selectizeInput("selected_player", "Select Player:", 
               choices = NULL,  # Initially empty
               options = list(placeholder = "Bukayo Saka", maxOptions = 10)
                ),
      selectInput("competition", "Select Competition:", 
      choices = c("Premier League", "Bundesliga", "La Liga", "Serie A", "Ligue 1")),
      selectInput("scouting_period", "Select Scouting Period:", 
      choices = rev(paste0(2017:2024, "-", (2018:2025)))),  # Generates "2017-18" to "2024-25"
      
      selectInput("template", "Player Position Template:", 
                  choices = c("Striker" = "ST", "Winger" = "W","Attacking Mid" = "AM", "Central Mid" = "CM", 
                              "Defensive Mid" = "DM","Full Back" = "FB","Center Back" = "CB" )),
      selectInput("style", "Select Style:", choices = c("Liverpool", "Politik","Severance")),
      selectInput("pos_versus", "Position Versus:", choices = c("primary", "secondary")),
      selectInput("benchmark", "Benchmark Type:", choices = c("Numeric", "Dummy")),
      
      actionButton("generate", "Generate Radar Plot"),
      downloadButton('downloadImage', ' Save The Slice'),
      
    ),
    
    mainPanel(
      uiOutput("errorMessage"),   # Add error message display
      
      # Add navigation controls with shinyjs enabled
      
      # Add image info
      div(class = "image-info", 
          textOutput("imageInfo")
      ),
      
      div(style = "display: flex; justify-content: center; align-items: center; height: 80vh;",
          imageOutput("radarPlot", width = "100%", height = "100%"),
      ),
      div(class = "history-nav",
      actionButton("prevImage", icon("arrow-left")),
      span(textOutput("imageCounter"), style = "margin: 0 10px;"),
      actionButton("nextImage", icon("arrow-right"))
      )
    )
  )
)

server <- function(input, output, session) {
  # Local database connection
  tryCatch({
    DB_CONNECTION <- setupDatabase()
  }, error = function(e) {
    showNotification(
      paste("Database Connection Error:", e$message), 
      type = "error"
    )
    DB_CONNECTION <- NULL
  })  
  # Reactive values for tracking current image and total images
  values <- reactiveValues(
    currentImageIndex = 1,
    totalImages = 0,
    imageHistoryData = NULL,  # Store all image records as a dataframe
    currentFilePath = NULL    # Track the current image filepath
  )
  
  # Function to get all image history entries (limited to 5)
  getImageHistory <- function() {
    query <- dbGetQuery(DB_CONNECTION, "
      SELECT * FROM image_history 
      ORDER BY created_at DESC 
      LIMIT 5
    ")
    return(query)
  }
  
  # Function to update the display based on current index
  updateDisplay <- function() {
    # Make sure we have image history and valid index
    if (is.null(values$imageHistoryData) || nrow(values$imageHistoryData) == 0) {
      shinyjs::disable("prevImage")
      shinyjs::disable("nextImage")
      output$imageCounter <- renderText({ "No images" })
      output$imageInfo <- renderText({ "" })
      output$radarPlot <- renderImage({ 
        list(src = "", alt = "No images available") 
      }, deleteFile = FALSE)
      return()
    }
    
    # Enable/disable navigation buttons based on position
    shinyjs::toggleState("prevImage", condition = values$currentImageIndex > 1)
    shinyjs::toggleState("nextImage", condition = values$currentImageIndex < values$totalImages)
    
    # Update image counter
    output$imageCounter <- renderText({
      paste(values$currentImageIndex, "of", values$totalImages)
    })
    
    # Get current image data
    currentImage <- values$imageHistoryData[values$currentImageIndex, ]
    
    # Update image info
    output$imageInfo <- renderText({
      paste0(currentImage$player_name, " - ", currentImage$competition, " (", currentImage$period, ")")
    })
    
    # Debug
    cat("Displaying image:", currentImage$filepath, "Index:", values$currentImageIndex, "\n")
    
    # Update displayed image - force reactivity with invalidateLater
    values$currentFilePath <- currentImage$filepath
    output$radarPlot <- renderImage({
      list(
        src = values$currentFilePath,
        contentType = "image/png",
        alt = paste("Radar Chart for", currentImage$player_name)
      )
    }, deleteFile = FALSE)
  }
  observe({
    req(Top5dfUrls)  # Ensure dataset exists before updating input
    
    updateSelectizeInput(session, "selected_player", 
                         choices = setNames(Top5dfUrls$UrlFBref, Top5dfUrls$Name), 
                         server = TRUE)
  })
  # Initialize by loading image history
  observeEvent(TRUE, {
    values$imageHistoryData <- getImageHistory()
    if (!is.null(values$imageHistoryData) && nrow(values$imageHistoryData) > 0) {
      values$totalImages <- nrow(values$imageHistoryData)
      values$currentImageIndex <- 1  # Start with the most recent image
      updateDisplay()
    }
  }, once = TRUE)
  
  # Navigate to previous image
  observeEvent(input$prevImage, {
    req(values$imageHistoryData)  # Ensure there is history available
    if (values$currentImageIndex > 1) {
      # Debug
      cat("Moving to previous image. Old index:", values$currentImageIndex)
      values$currentImageIndex <- values$currentImageIndex - 1
      cat(", New index:", values$currentImageIndex, "\n")
      updateDisplay()
    }
  })
  
  # Navigate to next image
  observeEvent(input$nextImage, {
    req(values$imageHistoryData)  # Ensure there is history available
    if (values$currentImageIndex < values$totalImages) {
      # Debug
      cat("Moving to next image. Old index:", values$currentImageIndex)
      values$currentImageIndex <- values$currentImageIndex + 1
      cat(", New index:", values$currentImageIndex, "\n")
      updateDisplay()
    }
  })
  
  # Extract player name from URL for database storage
  getPlayerNameFromUrl <- function(url) {
    player_name <- "Unknown Player"
    
    # Try to find the player name in Top5dfUrls
    if (exists("Top5dfUrls")) {
      match_idx <- match(url, Top5dfUrls$UrlFBref)
      if (!is.na(match_idx)) {
        player_name <- Top5dfUrls$Name[match_idx]
      }
    }
    
    return(player_name)
  }
  
  # Generate new radar plot
  observeEvent(input$generate, {
    req(input$selected_player, input$competition, input$scouting_period, input$template, input$style)    
    show_spinner()
    # Clear error message before running new analysis
    output$errorMessage <- renderUI(NULL)
    player_url <- input$selected_player  
    league_input <- paste(input$scouting_period, input$competition)
      
    isolate({
      cat("🚀 Running Analysis function with league:", league_input, "\n")
      
      result <- tryCatch({
        Analysis(
          player_url = player_url, 
          league_comp_name = league_input,  
          template = input$template, 
          style = input$style, 
          pos_versus = input$pos_versus, 
          benchmark = input$benchmark
        )
        NULL  # No error, return NULL
      
      }, error = function(e) {
        output$errorMessage <- renderUI({
          div(class = "error-card",
              div(style = "padding: 10px; background-color: #ffdddd; color: #a94442; border-left: 5px solid #a94442; border-radius: 5px; margin-bottom: 10px;",
                  strong("❌ Error: "), as.character(e$message)
              )
          )
        })
        return(e$message)  # Return error message
      })
      
      if (!is.null(result)) {
        hide_spinner()
        return()
      }
      
      cat("✅ Analysis function completed.\n")
    })
    
    # Get the latest generated image
    img_dir <- file.path(getwd(), "Radars")
    latest_file <- list.files(img_dir, full.names = TRUE, pattern = "\\.png$") %>%
 
      file.info() %>%
      dplyr::as_tibble(rownames = "filepath") %>%
      dplyr::arrange(desc(mtime)) %>%
      dplyr::slice(1) %>%
      dplyr::pull(filepath)    
    
    # Add to database
    player_name <- getPlayerNameFromUrl(player_url)
    
    
    
    # Reload image history and reset to first (newest) image
    values$imageHistoryData <- getImageHistory()
    if (!is.null(values$imageHistoryData) && nrow(values$imageHistoryData) > 0) {
      values$totalImages <- nrow(values$imageHistoryData)
      values$currentImageIndex <- 1  # Reset to the most recent image
      updateDisplay()
    }
    
    # Clean up old images (keep only latest 5)
    old_images <- dbGetQuery(DB_CONNECTION, "
      SELECT filepath FROM image_history 
      ORDER BY created_at DESC 
      LIMIT -1 OFFSET 5
    ")
    
    if (!is.null(old_images) && nrow(old_images) > 0) {
      # Delete files
      for (file in old_images$filepath) {
        if (file.exists(file)) {
          file.remove(file)
        }
      }
      
      # Delete database entries
      dbExecute(DB_CONNECTION, "
        DELETE FROM image_history 
        WHERE id NOT IN (
          SELECT id FROM image_history 
          ORDER BY created_at DESC 
          LIMIT 5
        )
      ")
    }
    
    hide_spinner()
    output$downloadImage <- downloadHandler(
      filename = function() {
        basename(latest_file)
      },
      content = function(file) {
        file.copy(latest_file, file)
      })
  })
  
  # Clean up database connection when app closes
  onStop(function() {
    if (!is.null(DB_CONNECTION) && 
        inherits(DB_CONNECTION, "DBIConnection") && 
        dbIsValid(DB_CONNECTION)) {
      dbDisconnect(DB_CONNECTION)
    }
  })
}
shinyApp(ui = ui, server = server)
