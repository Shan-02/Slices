# global.R
# Load all required libraries
library(shiny)          
library(shinybusy)      
library(bslib)         
library(tidyverse)      
library(forcats)        
library(glue)           
library(ggtext)         
library(magick)         
library(rvest)          
library(dplyr)         
library(xlsx)           
library(RSQLite)        
library(DBI)            
library(worldfootballR) 
library(geomtextpath)   
library(shinyjs)        
library(showtext)       

# Safe file loading with GitHub repository context
files <- tryCatch(
  list.files("Helper_Functions", full.names = TRUE, pattern = "\\.R$"),
  error = function(e) character(0)
)
lapply(files, source)

# Load dataset with error handling
Top5dfUrls <- tryCatch(
  read.csv("Data/Top5PlayerUrls.csv"),
  error = function(e) {
    warning("Could not load Top5PlayerUrls.csv: ", e$message)
    data.frame() # Return empty dataframe
  }
)

# Database setup function
setupDatabase <- function() {
  db_path <- file.path(getwd(), "radar_history.sqlite")
  
  tryCatch({
    db <- dbConnect(RSQLite::SQLite(), db_path)
    
    if (!dbExistsTable(db, "image_history")) {
      dbExecute(db, "
        CREATE TABLE IF NOT EXISTS image_history (
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
  }, error = function(e) {
    warning("Database setup error: ", e$message)
    NULL
  })
}
