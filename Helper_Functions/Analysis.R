Analysis = function(player_url, league_comp_name,template,style,country = "", pos_versus = 'primary', stat_type = 'standard',benchmark = "Numeric") {
  ST<- Sys.time()
  country <<- country
  assign("df", larger_function(player_url, league_comp_name, pos_versus, stat_type), envir = .GlobalEnv)
  
  if (template == "W"|template == "Winger") {
    assign("df_selected", PossStats("W"), envir = .GlobalEnv)
  } else if (template == "ST"|template == "Forward"|template == "Striker") {
    assign("df_selected", PossStats("ST"), envir = .GlobalEnv)
  } else if (template == "DM"|template == "dlp"|template == "DLP") {
    assign("df_selected", PossStats("DM"), envir = .GlobalEnv)
  } else if (template == "CB"|template == "BPD") {
    assign("df_selected", PossStats("CB"), envir = .GlobalEnv)
  } else if (template == "CM"|template == "Mezzala") {
    assign("df_selected", PossStats("CM"), envir = .GlobalEnv)
  } else if (template == "FB"|template == "Full Back"|template == "full back") {
    assign("df_selected", PossStats("FB"), envir = .GlobalEnv)
  } else if (template == "AM"|template == "Attmid" | template == "AM") {
    assign("df_selected", PossStats("AM"), envir = .GlobalEnv)
  } else if (template == "T10") {
    assign("df_selected", T10(), envir = .GlobalEnv)
  } else if (template == "Saka") {
    assign("df_selected", SakaTemp(), envir = .GlobalEnv)
  }
  
  Designer(style, benchmark = benchmark)
 
  simage()
  ET<- Sys.time()
  TT<-ET-ST
  TT
}
