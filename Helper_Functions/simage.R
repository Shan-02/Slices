simage <- function(
  Player_head = "Empty.png",  # Default value
  inscaleset = 3, 
  phead_yset = 4600, 
  phead_xset = 4500, 
  logoImage = glue::glue("{Logo}"), 
  #BadgeImage = glue::glue("{Badge}"),
  df_selected. = df_selected, 
  mainImage
) {
  # Ensure Player_head is within the 'Images' folder
  if (!grepl("^Images/", Player_head)) {
    Player_head <- file.path("Logos", Player_head)
  }  # Get the values from df_selected
  
  gc()
  Logo = Logo
  player_name <- df$Player[1]
  season <- df$Season[1]
  template <- df_selected$template[1]
  team <- df$Squad[1]
  comp<-  gsub("/", "&", df$Versus[1])
  date<-Sys.Date()
  # Create the filename using the values from df_selected
  kfilename <- paste( season, template, sep = ", ",collapse = "")
  #print(kfilename)
  filename <- paste0(kfilename, ".png")
  tfile <- paste(player_name, season, template, team,comp, date, sep = ", ")
  tfile <- paste0(tfile, ".png")
  # Specify the save directory
  save_directory <- file.path(getwd(), "Radars")
  #Guide<-"Auora.png"
  # Calculate the width and height in inches
  dimension<-6000
  dpi <- 225
  width_in <- dimension / dpi
  height_in <- dimension / dpi
  
  # Save the image with the filename
  mainImage <- file.path(save_directory, filename)
  ggsave(mainImage, width = width_in, height = height_in, dpi = dpi, device = png,type = "cairo-png")
  #Player_head<-"https://buttonmuseum.org/sites/default/files/SL-No-Means-No-busy-beaver-button-museum.png"
  
  # Read the main image and the logo image
  main <- image_read(mainImage)
  logo <- image_read(logoImage)
  #badge <- image_read(BadgeImage)
  phead<- image_read(Player_head)
  #guide<-image_read(Guide)
  # Get the dimensions of the main image
  main_width <- image_info(main)$width
  main_height <- image_info(main)$height
  
  # Resize the logo and Badge to a suitable size
  logo <- image_scale(logo, paste0(main_width / 6, "x"))
  #badge<- image_scale(badge, paste0(main_width / 0.5, "x"))
  #guide<- image_scale(guide,paste0(main_width / 6, "x"))
  inscale = inscaleset
  # Calculate the dimensions of the phead image
  phead_width <- main_width / inscale
  phead_height <- main_height  / inscale
  
  # Resize the head to the calculated dimensions
  phead <- image_scale(phead, paste0(phead_width, "x", phead_height))
  
  
  # Calculate the position to place the logo (bottom-right corner in this example)
  logo_x <- 150
  logo_y <- 5000
  
  #guide_x<- 150
  #guide_y<- 5000
  
  # Calculate the position to place the head
  phead_x <- phead_xset #right
  phead_y <- phead_yset #down
  
 # badge_x <-150
  #badge_y <-3000
  
  # Composite the logo,head, and guide onto the main image
  resultu <- image_composite(main, logo, offset = paste0("+", logo_x, "+", logo_y))
  resulti <- image_composite(resultu, phead, offset = paste0("+", phead_x, "+", phead_y))
  #resultb <- image_composite(resulti, badge, offset = paste0("+", badge_x, "+", badge_y))

  #resultg <- image_composite(resulti, guide, offset = paste0("+", guide_x, "+", guide_y))
  
  
  # Save the result to the output file
  output_path <- file.path(save_directory, tfile)
  image_write(resulti, output_path,depth = 16)
  
  invisible(file.remove(mainImage))
}

