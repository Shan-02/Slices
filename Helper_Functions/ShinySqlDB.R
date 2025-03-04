setupDatabase <- function() {
  db <- dbConnect(SQLite(), "radar_history.sqlite")
  
  # Create the table if it doesn't exist
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
