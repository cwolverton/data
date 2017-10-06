library(ggplot2)
library(tools)

setwd("~/Documents/Data Analysis/pin7lateral_MATATO")
source("opn.R")
# Read the selected file into a data frame called 'data' as a csv
#data <- read.csv(pathFilename, header = TRUE) # these files do have a header row
# Create a new column for the cumulative rotation (cDiff)
data$cDiff <- cumsum(data$difference)
# Plot the whole data set to see the overall response
ggplot(data, aes(x=minutes, y=cDiff)) + geom_point(shape=1) + ggtitle(filename)
plotFilename <- sprintf("%s.%s", filename, "png")
ggsave(filename = plotFilename, height = 3, width = 4, dpi = 300)
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
    m <- mean(r$cDiff)
    results <- c(results, m)
    x <- x + 1
  }
  return(results)
} 
# include lag, angle at minimum
avgResult <- avg(g=30, a=45) 
# This creates a matrix with the results of output from avg function
output1 <- as.matrix(t(avgResult))
# This appends the results of output1 to a file
write.table(output1, file = "data_pin7lateral.csv", sep = ",", col.names = FALSE, append=TRUE)
