showfontsadder <- function() {
  # Define the font directory path
  font_dir <- file.path(getwd(), "www/fonts")
  
  # Use tryCatch to gracefully handle missing fonts
  try_add_font <- function(family, file) {
    tryCatch({
      file_path <- file.path(font_dir, file)
      if (file.exists(file_path)) {
        sysfonts::font_add(family, file_path)
        cat("Added font:", family, "from", file_path, "\n")
      } else {
        cat("Font file not found:", file_path, "\n")
      }
    }, error = function(e) {
      cat("Error adding font", family, ":", e$message, "\n")
    })
  }
  
  try_add_font("Sagona Book","SAGONABOOK.ttf")
  font_add_google("EB Garamond", "EB Garamond")
  font_add_google("Josefin Slab", "Josefin")
  font_add_google("Gruppo", "Gruppo")
  font_add_google("Cinzel", "Cinzel")
  font_add_google("Arapey", "Arapey")
  font_add_google("Chakra Petch", "Chakra")
  font_add_google("Overpass", "Overpass")
  font_add_google("Coda", "Coda")
  font_add_google("Yuji Syuku", "Yuji")
  
  # Activate showtext
  showtext::showtext_auto()
}