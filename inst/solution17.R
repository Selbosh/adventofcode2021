library(adventofcode2021)
target <- read_target(readLines(input_file(17)))
search_trajectories(target, trick = TRUE)
search_trajectories(target, trick = FALSE)
