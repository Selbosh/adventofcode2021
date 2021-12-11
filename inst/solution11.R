library(adventofcode2021)
energy <- read.matrix(input_file(11))
count_flashes(energy)
count_flashes(energy, 500, part2 = TRUE)
