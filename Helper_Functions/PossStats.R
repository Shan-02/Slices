PossStats <- function(position) {
  # Ensure position exists in stat_order
  if (!position %in% names(stat_order)) {
    stop("Invalid position entered.")
  }
  # Remove duplicate statistiCustomStats
  modified_df <- df[!duplicated(df$Statistic), ]

  # Get required stats for the position
  required_stats <- stat_order[[position]]

  if (position == "CB" | position == "DM"){
    CustomStats = CS
  } else if (position == "FB"){
    CustomStats = FCS
  } else{
    CustomStats = WCS
  }

  # Identify relevant custom stats (only those appearing in stat_order for this position)
  relevant_custom_stats <- intersect(names(CustomStats), required_stats)

  # Function to compute average percentile for a stat (custom or base)
  compute_stat_percentile <- function(stat_name, components) {
    data <- modified_df[modified_df$Statistic %in% components, ]
    if (stat_name %in% AdjStats){
      return (adjusted_score(data$Percentile))
    }
    else if (nrow(data) > 0) {
      return(mean(data$Percentile, na.rm = TRUE))  # Properly compute the mean percentile
    } else {
      return(NA)
    }
  }


  # Compute percentiles for required stats (base + relevant custom stats)
  all_stats <- unique(c(required_stats, relevant_custom_stats))  # Only include relevant custom stats
  df_selected <- data.frame(Statistic = all_stats) %>%
    rowwise() %>%
    mutate(
      components = if_else(Statistic %in% names(CustomStats), list(CustomStats[[Statistic]]), list(Statistic)),
      Percentile = compute_stat_percentile(Statistic, components)
    ) %>%
    ungroup()
  stat_order_levels <- c("Attack", "Defending","Passing", "Dribbling")
  # Assign categories dynamically using category_dict
  get_category <- function(stat) {
    for (category in names(stat_categories)) {
      if (stat %in% stat_categories[[category]]) {
        return(category)
      }
    }
    return("Uncategorized")  # Default category
  }

  df_selected <- df_selected %>%
    mutate(stat = sapply(Statistic, get_category)) %>%
    mutate(stat = factor(stat, levels = stat_order_levels)) %>%  # Convert to factor with the given order
    arrange(stat)  # Sort by stat column
  
  # Assign order dynamically using position-specific stat order
  df_selected <- df_selected %>%
    group_by(stat) %>%  # Ensure stats are grouped within categories
    mutate(stat_order = row_number()) %>%  # Assign order within each category
    ungroup()
    
  # Assign template name based on position
  df_selected$template <- position
  
  return(df_selected)
}