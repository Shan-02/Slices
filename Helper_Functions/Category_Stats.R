WCS <- list(
  `Non-Pen Goals + Assists` = c("Non-Penalty Goals", "Assists"),

  `Progressive Passing` = c("Progressive Passing Distance", "Progressive Passes"),
  `Progressive Carrying` = c("Progressive Carrying Distance", "Progressive Carries"),
  `Final-Third & Pen Touches` = c("Touches (Att 3rd)", "Touches (Att Pen)"),
  `Opposition Half Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)", "Touches (Att Pen)"),
  `Final Third Entries` = c("Passes into Final Third", "Carries into Final Third"),
  `Penalty Area Entries` = c("Passes into Penalty Area", "Carries into Penalty Area"),
  `Distance Passing` = c("Passes Attempted (Medium)", "Passes Attempted (Long)", "Pass Completion % (Medium)", "Pass Completion % (Long)"),
  `Through-Balls & Switches` = c("Through Balls", "Switches"),
  `Mid-Att Third Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)"),
  `Def-Mid Third Touches` = c("Touches (Def 3rd)", "Touches (Mid 3rd)"),
  `Take On Ability` = c("Take-Ons Attempted", "Successful Take-On %"),
  `Miscontrols & Dispossessions` = c("Dispossessed", "Miscontrols"),

  #'Playmaking Efficiency' = c("Pass Completion %","SCA (Live-ball Pass)", "Passes into Penalty Area"),
  `Passing Security` = c("Pass Completion %", "Passes Completed"),
  `Threat Created From Carries` = c("Successful Take-Ons", "Carries into Penalty Area", "SCA (Take-On)"),
  `Threat Created From Passing` = c("SCA (Live-ball Pass)", "Key Passes", "Passes into Penalty Area"),

  `Ints, Blocks, Clearences` = c("Interceptions", "Blocks", "Clearances"),
  `Ints + Blocks + Tackles` = c("Interceptions", "Blocks", "Tackles"),
  `Tackling Volume Mid` = c("Dribbles Challenged", "Tackles", "Tackles (Mid 3rd)"),
  `Tackling Volume Def` = c("Tackles", "Tackles (Def 3rd)"),
  `Tackling Quality` = c("% of Dribblers Tackled"),
  `Aerial Duels` = c("Aerials Won", "% of Aerials Won")
)

FCS <- list(
  `Non-Pen Goals + Assists` = c("Non-Penalty Goals", "Assists"),

  `Progressive Passing` = c("Progressive Passing Distance", "Progressive Passes"),
  `Progressive Carrying` = c("Progressive Carrying Distance", "Progressive Carries"),
  `Final-Third & Pen Touches` = c("Touches (Att 3rd)", "Touches (Att Pen)"),
  `Opposition Half Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)", "Touches (Att Pen)"),
  `Final Third Entries` = c("Passes into Final Third", "Carries into Final Third"),
  `Penalty Area Entries` = c("Passes into Penalty Area", "Carries into Penalty Area"),
  `Distance Passing` = c("Passes Attempted (Medium)", "Passes Attempted (Long)", "Pass Completion % (Medium)", "Pass Completion % (Long)"),
  `Through-Balls & Switches` = c("Through Balls", "Switches"),
  `Mid-Att Third Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)"),
  `Def-Mid Third Touches` = c("Touches (Def 3rd)", "Touches (Mid 3rd)"),
  `Take On Ability` = c("Take-Ons Attempted", "Successful Take-On %"),
  `Miscontrols & Dispossessions` = c("Dispossessed", "Miscontrols"),

  #'Playmaking Efficiency' = c("Pass Completion %","SCA (Live-ball Pass)", "Passes into Penalty Area"),
  `Passing Security` = c("Pass Completion %", "Passes Completed"),
  `Threat Created From Carries` = c("Successful Take-Ons","Progressive Carries","Carries into Penalty Area","SCA (Take-On)"),
  `Threat Created From Passing` = c("SCA (Live-ball Pass)","Key Passes","Passes into Penalty Area","Progressive Passes"),

  `Ints, Blocks, Clearences` = c("Interceptions", "Blocks", "Clearances"),
  `Ints + Blocks + Tackles` = c("Interceptions", "Blocks", "Tackles"),
  `Tackling Volume Mid` = c("Dribbles Challenged", "Tackles", "Tackles (Mid 3rd)"),
  `Tackling Volume Def` = c("Tackles", "Tackles (Def 3rd)"),
  `Tackling Quality` = c("% of Dribblers Tackled"),
  `Aerial Duels` = c("Aerials Won", "% of Aerials Won")
)


CS <- list(
  `Non-Pen Goals + Assists` = c("Non-Penalty Goals", "Assists"),

  `Progressive Passing` = c("Progressive Passing Distance", "Progressive Passes"),
  `Progressive Carrying` = c("Progressive Carrying Distance", "Progressive Carries"),
  `Final-Third & Pen Touches` = c("Touches (Att 3rd)", "Touches (Att Pen)"),
  `Opposition Half Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)", "Touches (Att Pen)"),
  `Final Third Entries` = c("Passes into Final Third", "Carries into Final Third"),
  `Penalty Area Entries` = c("Passes into Penalty Area", "Carries into Penalty Area"),
  `Distance Passing` = c("Passes Attempted (Medium)", "Passes Attempted (Long)", "Pass Completion % (Medium)", "Pass Completion % (Long)"),
  `Through-Balls & Switches` = c("Through Balls", "Switches"),
  `Mid-Att Third Touches` = c("Touches (Mid 3rd)", "Touches (Att 3rd)"),
  `Def-Mid Third Touches` = c("Touches (Def 3rd)", "Touches (Mid 3rd)"),
  `Take On Ability` = c("Take-Ons Attempted", "Successful Take-On %"),
  `Miscontrols & Dispossessions` = c("Dispossessed", "Miscontrols"),

  #'Playmaking Efficiency' = c("Pass Completion %","SCA (Live-ball Pass)", "Passes into Penalty Area"),
  `Passing Security` = c("Pass Completion %", "Passes Completed"),
  `Threat Created From Carries` = c("Successful Take-Ons","Progressive Carries","Carries into Final Third","SCA (Take-On)"),
  `Threat Created From Passing` = c("SCA (Live-ball Pass)","Key Passes","Passes into Final Third"),

  `Ints, Blocks, Clearences` = c("Interceptions", "Blocks", "Clearances"),
  `Ints + Blocks + Tackles` = c("Interceptions", "Blocks", "Tackles"),
  `Tackling Volume Mid` = c("Dribbles Challenged", "Tackles", "Tackles (Mid 3rd)"),
  `Tackling Volume Def` = c("Tackles", "Tackles (Def 3rd)"),
  `Tackling Quality` = c("% of Dribblers Tackled"),
  `Aerial Duels` = c("Aerials Won", "% of Aerials Won")
)

AdjStats = c("Final Third Entries","Penalty Area Entries","Distance Passing",
              "Take On Ability","Threat Created From Carries","Threat Created From Passing")

stat_categories <- list(
  Attack = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Shots Total", "npxG/Shot", 
    "Penalty Area Entries", "Final Third Entries" ,"Non-Pen Goals + Assists", "npxG + xAG"
  ),
  Defending = c(
    "Tackling Quality", "Aerial Duels", "Ball Recoveries", 
    "Tackling Volume Def", "Tackling Volume Mid", "Ints, Blocks, Clearences", 
    "Interceptions", "Blocks", "Clearances", "Dribbles Challenged", 
    "Tackles", "Tackles (Def 3rd)", "Tackles (Mid 3rd)"
  ),
  Passing = c(
    "Progressive Passing Distance", "Progressive Passes", 
    "Passes into Final Third", "Passes into Penalty Area", 
    "Passes Attempted (Medium)", "Passes Attempted (Long)", 
    "Pass Completion % (Medium)", "Pass Completion % (Long)", 
    "Through Balls", "Switches", "Pass Completion %", 
    "Passes Completed", "SCA (Live-ball Pass)", "Progressive Passing", 
    "Distance Passing", "Passing Security", "Threat Created From Passing", 
      "Shot-Creating Actions",
    "xAG: Exp. Assisted Goals", "Assists","Key Passes", "xA: Expected Assists"
  ),
  Dribbling = c(
    "Progressive Carrying Distance", "Progressive Carries", "Mid-Att Third Touches","Def-Mid Third Touches",
    "Take-Ons Attempted", "Successful Take-On %", "Miscontrols", "Progressive Passes Rec",
    "Dispossessed", "Threat Created From Carries", "Take On Ability", "Touches",
    "Progressive Carrying", "Miscontrols & Dispossessions" , "Final-Third & Pen Touches" , "Opposition Half Touches"
  )
)

stat_order <- list(
  CF = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Shots Total", "npxG/Shot", 
    "xAG: Exp. Assisted Goals", "Assists", "Shot-Creating Actions", 
    "Penalty Area Entries", "Threat Created From Carries", "Take On Ability", 
    "Threat Created From Passing", "Key Passes", "Final-Third & Pen Touches", 
    "Progressive Passes Rec", "Aerial Duels"
  ),
  ST = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Shots Total", "npxG/Shot", 
    "xAG: Exp. Assisted Goals", "Assists", "Threat Created From Passing","Shot-Creating Actions", 
    "Penalty Area Entries",
     "Key Passes",  
    "Progressive Passes Rec", "Final-Third & Pen Touches","Aerial Duels", "Take On Ability","Threat Created From Carries"
  ),
  SS = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Shots Total", "npxG/Shot", 
    "xAG: Exp. Assisted Goals", "Assists", "Shot-Creating Actions", 
    "Penalty Area Entries", "Threat Created From Carries", "Take On Ability", 
    "Threat Created From Passing", "Key Passes", "Final-Third & Pen Touches", 
    "Progressive Passes Rec", "Aerial Duels"
  ),
  LW = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Assists", "xAG: Exp. Assisted Goals", 
    "Penalty Area Entries", "Shot-Creating Actions", "Threat Created From Carries", 
    "Take On Ability", "Miscontrols & Dispossessions", "Threat Created From Passing", 
    "Key Passes", "Final-Third & Pen Touches", "Progressive Passes Rec"
  ),
  RW = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Assists", "xAG: Exp. Assisted Goals", 
    "Penalty Area Entries", "Shot-Creating Actions", "Threat Created From Carries", 
    "Take On Ability", "Miscontrols & Dispossessions", "Threat Created From Passing", 
    "Key Passes", "Final-Third & Pen Touches", "Progressive Passes Rec"
  ),
  W = c(
    "Non-Penalty Goals", "npxG: Non-Penalty xG", "Assists", "xAG: Exp. Assisted Goals", 
    "Penalty Area Entries","Threat Created From Passing", 
    "Shot-Creating Actions","Miscontrols & Dispossessions","Final-Third & Pen Touches", "Passing Security",
    "Take On Ability",  "Threat Created From Carries", 
    "Key Passes"
  ),
  AM = c(
    "Non-Pen Goals + Assists", "npxG + xAG", "Shot-Creating Actions", "Penalty Area Entries", 
    "Final Third Entries", "Threat Created From Passing", "Through Balls", "Key Passes", 
    "Passing Security", "Distance Passing", "Miscontrols & Dispossessions", "Opposition Half Touches", "Take On Ability", "Threat Created From Carries"
    
  ),
  RB = c(
    "Shot-Creating Actions", "Final Third Entries", "Threat Created From Carries", 
    "Progressive Carrying", "Take On Ability", "Miscontrols & Dispossessions", 
    "Threat Created From Passing", "Progressive Passing", "Distance Passing", 
    "Mid-Att Third Touches", "Progressive Passes Rec", "Tackling Quality", 
    "Aerial Duels", "Ball Recoveries", "Tackling Volume Def", "Ints, Blocks, Clearences", 
    "Dribbles Challenged"
  ),
  LB = c(
    "Shot-Creating Actions", "Final Third Entries", "Threat Created From Carries", 
    "Progressive Carrying", "Take On Ability", "Miscontrols & Dispossessions", 
    "Threat Created From Passing", "Progressive Passing", "Distance Passing", 
    "Mid-Att Third Touches", "Progressive Passes Rec", "Tackling Quality", 
    "Aerial Duels", "Ball Recoveries", "Tackling Volume Def", "Ints, Blocks, Clearences", 
    "Dribbles Challenged"
  ),
  FB = c(
    "Shot-Creating Actions", "Final Third Entries", "Miscontrols & Dispossessions",
    "Progressive Carrying", "Take On Ability",  "Threat Created From Carries", 
    "Mid-Att Third Touches", "Progressive Passing", "Distance Passing", 
    "Threat Created From Passing",  "Tackling Quality", 
    "Aerial Duels", "Ball Recoveries", "Tackling Volume Def", "Ints, Blocks, Clearences", 
    "Dribbles Challenged"
  ),
  DM = c(
    "npxG + xAG", "Shot-Creating Actions", "Final Third Entries", "Threat Created From Passing", 
    "Progressive Passing", "Distance Passing", "Passing Security",  "Miscontrols & Dispossessions", 
     "Def-Mid Third Touches","Progressive Carrying",
   "Take On Ability", "Threat Created From Carries",  "Tackling Quality", "Aerial Duels", 
    "Ball Recoveries", "Tackling Volume Mid", "Ints, Blocks, Clearences"
  ),
  CM = c(
    "npxG + xAG", "Shot-Creating Actions", "Final Third Entries", "Threat Created From Passing", 
    "Progressive Passing", "Distance Passing", "Passing Security","Miscontrols & Dispossessions", 
    "Mid-Att Third Touches",  "Progressive Carrying", "Take On Ability", "Threat Created From Carries" , "Tackling Quality", "Aerial Duels", 
    "Ball Recoveries", "Tackling Volume Mid", "Ints, Blocks, Clearences"
  ),
  CB = c(
    "Shot-Creating Actions", "Final Third Entries", "Touches", "Threat Created From Passing", 
    "Progressive Passing", "Distance Passing", "Progressive Carrying", 
    "Miscontrols & Dispossessions", "Tackling Quality", "Aerial Duels", 
    "Ball Recoveries", "Tackling Volume Def", "Ints, Blocks, Clearences", 
    "Dribbles Challenged"
  )
)

style_stats = c("Final Third & Pen Touches","Opposition Half Touches","Through-Balls & Switches","Mid-Att Third Touches","Def-Mid Third Touches",
               "Miscontrols & Dispossessions","Ints, Blocks, Clearences","Ints + Blocks + Tackles","Tackling Volume Mid","Tackling Volume Def",
               "Tackling Quality","Aerial Duels","Non-Pen Goals + Assists")
