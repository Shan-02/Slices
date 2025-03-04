required_packages <- c(
  "worldfootballR", "geomtextpath","shiny", "shinybusy","bslib","tidyverse",
   "showtext","forcats", "glue", "ggtext", "magick", "rvest", "dplyr","xlsx",
   "RSQLite","DBI"
)

# Function to check and install missing packages
install_if_missing <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Install or load each required package
lapply(required_packages, install_if_missing)

Top5dfUrls<- read.csv("Top5PlayerUrls.csv")
Top5dfUrls<-purrr::discard(Top5dfUrls, ~all(is.na(.)))
