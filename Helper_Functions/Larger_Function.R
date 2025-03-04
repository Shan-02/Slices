larger_function= function(player_url, league_comp_name, pos_versus = 'primary', stat_type = 'standard') {
  result <- tryCatch({
    df <- fb_player_scouting_report(player_url, pos_versus, league_comp_name,time_pause = 1.5) %>%
      filter(!duplicated(Statistic))
    #print (time_pause)
    #TMURL <- mapped_players$UrlTmarkt[mapped_players$UrlFBref== player_url]
    #print(TMURL)
    #TM_bio<-tm_player_bio(player_urls= TMURL)
    #print(TM_bio)
    dfseason <- fb_player_season_stats(player_url, stat_type,time_pause = 1.5)
    
    season_pattern <- paste0(substr(league_comp_name, 1, 4), "-", substr(league_comp_name, 6, 9))
    #season_pattern <- paste0(substr(league_comp_name, 1, 4))
    #print(season_pattern)
    # Helper function to extract country code and league name
    comparison<-"Next 14 Leagues"
    level<-"1. "
    get_country_and_league <- function(league_comp_name) {
      if (grepl("Ligue 1", league_comp_name)) {
        country_code <- "FRA"
        league_name <- "Ligue 1"
        comparison<-"Top 5 Leagues"
      } else if (grepl("Premier League", league_comp_name)) {
        country_code <- "ENG"
        league_name <- "Premier League"
        comparison<-"Top 5 Leagues"
      } else if (grepl("La Liga", league_comp_name)) {
        country_code <- "ESP"
        league_name <- "La Liga"
        comparison<-"Top 5 Leagues"
      } else if (grepl("Bundesliga", league_comp_name)) {
        country_code <- "GER"
        league_name <- "Bundesliga"
        comparison<-"Top 5 Leagues"
      } else if (grepl("Primeira Liga", league_comp_name)) {
        country_code <- "POR"
        league_name <- "Primeira Liga"
      } else if (grepl("Belgian Pro League", league_comp_name)) {
        country_code <- "BEL"
        league_name <- "Pro League A"
      } else if (grepl("Serie A", league_comp_name)) {
        country_code <- "ITA"
        league_name <- "Serie A"
        comparison<-"Top 5 Leagues"
      } else if (grepl("Women's Super League", league_comp_name)) {
        country_code <- "ENG"
        league_name <- "WSL"
      } else if (grepl("Liga MX", league_comp_name)) {
        country_code <- "MEX"
        league_name <- "Liga MX"
      } else if (grepl("Liga Profesional Argentina", league_comp_name)) {
        country_code <- "ARG"
        league_name <- "Liga Argentina"
        season_pattern <- paste0(substr(league_comp_name, 1, 4))
      } else if (grepl("Eredivisie", league_comp_name)) {
        country_code <- "NED"
        league_name <- "Eredivisie"
      } else if (grepl("Série A", league_comp_name)) {
        country_code <- "BRA"
        league_name <- "Série A"
        season_pattern <- paste0(substr(league_comp_name, 1, 4))
      } else if (grepl("Major League Soccer", league_comp_name)) {
        country_code <- "USA"
        league_name <- "MLS"
        season_pattern <- paste0(substr(league_comp_name, 1, 4))
      } else if (grepl("Last 365 Days Men's Big 5 Leagues, UCL, UEL", league_comp_name)) {
        country_code <- "ENG"
        league_name <- "Premier League"
        season_pattern <- "2024-2025"
      # comparison<-"Top 5 Leagues"
      } else if (grepl("Last 365 Days Men's Next 14 Competitions", league_comp_name)) {
        country_code <- "POR"
        league_name <- "Primeira Liga"
        season_pattern <- "2024-2025"
      } else if (grepl("Championship", league_comp_name)) {
        country_code <- "ENG"
        league_name <- "Championship"
        level <- "2. "
      } else if (grepl("Segunda División", league_comp_name)) {
        country_code <- "ESP"
        league_name <- "La Liga 2"
        level <- "2. "
      } else if (grepl("Europa League", league_comp_name)) {
        country_code <- ""
        league_name <- "Europa Lg"
        level <- "2. "
      } else if (grepl("Champions League", league_comp_name)) {
        country_code <- ""
        league_name <- "Champions Lg"
      }
      return(list(country_code = country_code, league_name = league_name,comparison = comparison, level = level,season_pattern = season_pattern))
    }
    #season_pattern<-"2022-2023"
    #print(df)
    
    league_info <- get_country_and_league(league_comp_name)
    country_code <- league_info$country_code
    league_name <- league_info$league_name
    comparison <- league_info$comparison
    level <- league_info$level
    season_pattern<-league_info$season_pattern
    #print(country_code)
    #print(season_pattern)
    #print(comparison)
    
    lastrow_dfseason <- dfseason %>%
      filter(grepl(season_pattern, Season)) %>%
      filter(grepl(country_code, Country)) %>%
      filter(Comp == paste0(level, league_name))
      #filter(Comp == paste0("2. ", league_name))
    #print(lastrow_dfseason)
    Compdf<-merge(df,comparison)  
    TotalDF <- merge(Compdf, lastrow_dfseason) %>%
      distinct()
    
    return(TotalDF)
  }, error = function(e) {
    stop(glue::glue("❌ Error: Invalid Competition or Scouting Period."))
  })
  return(result)
}
