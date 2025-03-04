Style= function(df_selected. = df_selected,logoholder,bgcolor,outlinecolor, 
  benchmarktype,benchmarkminsize = 13.5, benchmarktextcolor,benchmarkfillcolor,benchmarkfont,
  textcolor,basetextfont,subtitlefont,titlefont,
  passcolor,attcolor,defcolor,dribcolor,
basetextsize=30,subtitlesize=35,titlezie=70){
  showtext_auto() 
  showtext_opts(dpi = 225) 
  n<-nrow(df_selected)+0.5
  date<-Sys.Date()
  Logo<<-logoholder
  if (benchmarktype == "Numeric"){
    benchmarks = c(10,30,50,70,90)
  }
  if (benchmarktype == "Dummy"){
    benchmarks = c("Bad (10)","Meh (30)","Avg (50)","Good (70)","Elite (90)")
  }

  df_selected$Statistic <- gsub(" ","\n",df_selected$Statistic)
  #print(df_selected$Statistic)  
  #print(df_selected$stat_order) 
  ggplot(df_selected, aes(x = factor(Statistic, levels = Statistic), y = Percentile)) +                      
    geom_bar(aes(y = 100), fill = bgcolor, stat = "identity", width = 1, colour = outlinecolor,                 
             alpha = 0.5, show.legend = FALSE) +      
    
    
    
    geom_bar(stat="identity",width=1,aes(fill=stat),colour=outlinecolor,alpha=1) + 
    coord_curvedpolar(clip = "on")+
    geom_hline(yintercept=10, colour=outlinecolor,linetype="longdash",alpha=0.15,linewidth = 1.5)+
    annotate("label", x = n, y = 10, label = benchmarks[1], size = benchmarkminsize, colour = benchmarktextcolor,fill = benchmarkfillcolor,alpha = 1, family = benchmarkfont) +
    geom_hline(yintercept=30, colour=outlinecolor,linetype="longdash",alpha=0.2,linewidth = 1.5)+
    annotate("label", x = n, y = 30, label = benchmarks[2], size = benchmarkminsize, colour = benchmarktextcolor,fill = benchmarkfillcolor,alpha = 1, family = benchmarkfont) +    
    geom_hline(yintercept=50, colour=outlinecolor,linetype="longdash",alpha=0.3,linewidth = 1.5)+
    annotate("label", x = n, y = 50, label = benchmarks[3], size = benchmarkminsize, colour = benchmarktextcolor,fill = benchmarkfillcolor,alpha = 1, family = benchmarkfont) +
    geom_hline(yintercept=70, colour=outlinecolor,linetype="longdash",alpha=0.4,linewidth = 1.5)+
    annotate("label", x = n, y = 70, label = benchmarks[4], size = benchmarkminsize, colour = benchmarktextcolor,fill = benchmarkfillcolor,alpha = 1, family = benchmarkfont) +
    geom_hline(yintercept=90, colour=outlinecolor,linetype="longdash",alpha=0.5,linewidth = 1.5)+
    annotate("label", x = n, y = 90, label = benchmarks[5], size = benchmarkminsize + 2, colour = benchmarktextcolor,fill = benchmarkfillcolor,alpha = 1, family = benchmarkfont) +
    geom_hline(yintercept=100, colour=outlinecolor,linetype="solid",alpha=1,linewidth = 1.5)+

    scale_fill_manual(values=c("Passing" = passcolor,
                               "Dribbling" = dribcolor,                                   
                               "Attack" = attcolor,
                               "Defending" = defcolor)) +                                                        
    #geom_label(aes(label=Percentile,fill=stat),size=9,color="white",label.padding = unit(0.2, "lines"),show.legend = FALSE,family  = "Lora SemiBold")+ 
    scale_y_continuous(limits = c(-5,108))+
    labs(fill="",   
         caption = glue("Data from Opta via FBref, All Per90 adjusted\nStyle Originally based off of Tom Worville /@worville\nPublication Date: {date}"),     
         title=glue("{df$Player[1]} , {tail(df$Squad,n=1)}"),
         df$Comp<-gsub('[[:digit:]]+[.]', '', df$Comp),
         subtitle = glue::glue("{df$Season[1]} {df$Comp[1]} | Comp: {df$Versus[1]} | Age : {tail(df$Age,n=1)+0} | Minutes : {df$BasedOnMinutes[1]} | Template : {df_selected$template[1]}"))+                                             
    theme_minimal() +                                                                     
    theme(plot.background = element_rect(fill = bgcolor,color = bgcolor),
          panel.background = element_rect(fill = bgcolor,color = bgcolor),
          legend.position = "bottom",
          legend.key.width = unit(4,'cm'),
          legend.key.height = unit(0.3,'cm'),
          legend.box.background = element_rect(color = "black"),
          #legend.spacing.x = unit(4,"cm"),
          legend.text = element_text(size=30),
          axis.title.y = element_blank(),
          axis.title.x = element_blank(),
          axis.text.y = element_blank(),
          axis.text.x = element_text(size = basetextsize,colour = textcolor),
          text = element_text(family=basetextfont,colour= textcolor),
          plot.subtitle= element_text(family = subtitlefont, size = subtitlesize,hjust = 0.5),
          plot.title = element_text(hjust = 0.5,family = titlefont, size = titlezie),
          plot.caption = element_text(hjust=0.5,size=20),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank())

  #return(list(Guide = Guide, logoImage = logoImage))
  
}


