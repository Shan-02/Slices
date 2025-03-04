# Load necessary libraries
library(shiny)
library(ggplot2)
library(glue)
library(worldfootballR)
library(magick)  # For image manipulation

# Placeholder for your custom functions (if they are in a separate file)
# source("your_functions.R") 

# Shiny UI
ui <- fluidPage(
  titlePanel("Football Player Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("player_url", "Player URL", value = "https://fbref.com/en/players/d85c238b/Mattia-Zaccagni"),
      textInput("league_comp_name", "League/Competition Name", value = "2023-2024 Serie A"),
      selectInput("template", "Select Template", 
                  choices = c("Winger", "Forward", "DLP", "Center Back", "Mezzala", "Full Back", "Attmid")),
      selectInput("style", "Select Style", 
                  choices = c("Liverpool", "Forest Green")),
      actionButton("analyze", "Generate Plot")
    ),
    
    mainPanel(
      plotOutput("plot"),  # Display the generated plot
      downloadButton("download", "Download Image")
    )
  )
)

# Server logic
server <- function(input, output, session) {

  # Analysis function to fetch and format data
  Analysis <- function(player_url, league_comp_name, template, style, country = "",
                       pos_versus = 'primary', stat_type = 'standard') {
    # Call the larger function to fetch data
    df <- larger_function(player_url, league_comp_name, pos_versus, stat_type)
    
    # Template selection logic
    df_selected <- switch(template,
                          "Winger" = WingerTemplate(),
                          "Forward" = ForwardTemplate(),
                          "DLP" = DLPTemplate(),
                          "Center Back" = CenterBackTemplate(),
                          "Mezzala" = MezzalaTemp(),
                          "Full Back" = Fullback_Template(),
                          "Attmid" = ATTMIDTemp())
    
    # Apply the selected design style
    Designer(style)
    
    # Save the plot using the same logic as in `simage()`
    plot_path <- tempfile(fileext = ".png")
    ggsave(
      filename = plot_path, 
      plot = last_plot(), 
      dpi = 300, 
      width = 20, height = 20, units = "cm", 
      device = "png", type = "cairo-png"
    )
    
    # Return the saved plot path
    return(plot_path)
  }
  
  # Event to trigger the Analysis function when the Analyze button is clicked
  plot_data <- eventReactive(input$analyze, {
    req(input$player_url, input$league_comp_name, input$template, input$style)
    
    # Run the Analysis function and get the plot path
    plot_path <- Analysis(
      player_url = input$player_url,
      league_comp_name = input$league_comp_name,
      template = input$template,
      style = input$style
    )
    
    # Read and return the image using magick
    magick::image_read(plot_path)
  })
  
  # Render the plot dynamically in the UI
  output$plot <- renderPlot({
    req(plot_data())  # Ensure the plot data is available
    plot_data()  # Render the plot as an image
  })
  
  # Download handler to allow the user to download the generated plot as PNG
  output$download <- downloadHandler(
    filename = function() {
      paste("player_analysis_", Sys.Date(), ".png", sep = "")
    },
    content = function(file) {
      # Run the Analysis function again to ensure the latest plot is saved
      plot_path <- Analysis(
        player_url = input$player_url,
        league_comp_name = input$league_comp_name,
        template = input$template,
        style = input$style
      )
      
      # Copy the generated plot to the download location
      file.copy(plot_path, file)
    }
  )
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
