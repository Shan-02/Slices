adjusted_score <- function(percentiles, alpha = 0.25, beta = 0.025) {
  # Calculate the mean of all percentiles
  M <- mean(percentiles)
  
  # Get the two lowest values and calculate their mean
  two_lowest <- sort(percentiles)[1:2]
  L <- mean(two_lowest)
  
  # Apply the formula
  S <- M + (M - 50) * alpha + (L - 50) * beta
  
  # Ensure the score is between 0 and 99
  S <- max(0, min(99, S))
  
  return(S)
}

