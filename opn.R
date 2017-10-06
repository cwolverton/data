library(tools)

# Create a function to open a file, storing the name of the file into the variable 'filename'
# From http://tuxette.nathalievilla.org/?p=687&lang=en
selectFile = function(){
  file = file.choose()
  file
}
pathFilename = selectFile()
fullFilename = basename(pathFilename)
filename <- file_path_sans_ext(fullFilename)

# Read the selected file into a data frame called 'data' as a csv
data <- read.csv(pathFilename, header = TRUE) # these files do have a header row