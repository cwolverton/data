avg <- function( g, a, w = 11, f = 60, n = 180 ){
  # Set up, slightly modified from the gravitropism averaging
  # g is the time the light was switched on
  # a is the light intensity setting for the experiment
  # w is the window size, in minutes; hw is the half-window for plus/minus
  # f is the frequency of sampling, in min
  # n is the span over which to sample, in min
  hw = (w - 1)/2 # half-window
  samples <- n/f
  x <- 0 # Set the variable x to 0 to start loop
  results <- c(filename, a, g) # Create a frame to store values
  while (x <= samples ) {
    r <- subset(data, minutes > ( (g + (x * f)) -hw ) & minutes < ( ( g + (x * f) ) + hw ), select = c(cDiff) )
    m <- mean(r$rotation)
    results <- c(results, m)
    x <- x + 1
  }
  return(results)
} 