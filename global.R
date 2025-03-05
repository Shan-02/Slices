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
library(RSQLite)
# Safe file loading with GitHub repository context
files <- tryCatch(
  list.files("Helper_Functions", full.names = TRUE, pattern = "\\.R$"),
  error = function(e) character(0)
)
lapply(files, source)

# Load dataset with error handling

# if (!file.exists("Top5PlayerUrls.csv")) {
#   stop("Error: Data/Top5PlayerUrls.csv not found! Check the file path.")
# } else {
#   stop("File Found")
# }
csv_path <- "Data3/Top5PlayerUrls.csv"
if (!file.exists(csv_path)) {
  stop(paste("⚠️ Error: CSV file not found at:", csv_path, "\nCheck file location and working directory:", getwd()))
 }
 Top5dfUrls <- read.csv(csv_path)


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
