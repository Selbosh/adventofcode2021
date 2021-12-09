library(adventofcode2021)
heights <- read.matrix(input_file(9))
sum(lowest_points(heights) + 1)
prod(basins(heights))
