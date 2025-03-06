# global.R
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
library(future)        
library(promises)       

# Ensure future supports multiprocess
plan(multisession)

# Load helper functions
files <- list.files("Helper_Functions", full.names = TRUE, pattern = "\\.R$")
lapply(files, source)

# Load dataset with error handling
csv_path <- "Data/Top5PlayerUrls.csv"  # Ensure correct path
if (!file.exists(csv_path)) {
  stop(paste("⚠️ Error: CSV file not found at:", csv_path, "\nCheck file location and working directory:", getwd()))
}
Top5dfUrls <- read.csv(csv_path)

# Database setup function
setupDatabase <- function() {
  db_path <- file.path("radar_history.sqlite")  # Use relative path for Shiny Server
  
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
    stop("Database setup error: ", e$message)
  })
}
