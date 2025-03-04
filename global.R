# global.R

# Load required libraries
library(shiny)          # Core Shiny framework
library(shinybusy)      # Loading spinners and busy indicators
library(bslib)         # Bootstrap themes for Shiny
library(tidyverse)      # Data manipulation and visualization (includes dplyr, ggplot2, etc.)
library(forcats)        # Handling categorical variables (factor levels)
library(glue)           # String interpolation and templating
library(ggtext)         # Enhanced text rendering in ggplot2
library(magick)         # Image processing and manipulation
library(rvest)          # Web scraping with R
library(dplyr)         # Data wrangling (already included in tidyverse, but explicit here)
library(xlsx)           # Read and write Excel files
library(RSQLite)        # Interface for SQLite databases
library(DBI)            # Database interface (works with RSQLite, PostgreSQL, MySQL, etc.)
library(worldfootballR) # Web scraping football data from FBref, Transfermarkt, etc.
library(geomtextpath)   # Adds text along ggplot2 paths

# Additional Shiny Extensions (ensure these are installed if used)
library(shinyjs)        # JavaScript extensions for Shiny
library(showtext)       # Load and use custom fonts in plots

# Load function files (if needed)
files <- list.files("Helper_Functions", full.names = TRUE, pattern = "\\.R$")
lapply(files, source)

# Load dataset
Top5dfUrls <- read.csv("Data/Top5PlayerUrls.csv")

# Setup database connection
setupDatabase <- function() {
  db_path <- file.path(getwd(), "radar_history.sqlite")  
  db <- dbConnect(RSQLite::SQLite(), db_path)

  if (!dbExistsTable(db, "image_history")) {
    dbExecute(db, "
      CREATE TABLE image_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filepath TEXT NOT NULL,
        player_name TEXT NOT NULL,
        competition TEXT NOT NULL,
        period TEXT NOT NULL,
        template TEXT NOT NULL,
        style TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ")
  }
  
  return(db)
}

DB_CONNECTION <<- setupDatabase()
