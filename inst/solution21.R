library(adventofcode2021)
input <- readLines(input_file(21))
start <- as.numeric(substring(input, nchar(input)))
deterministic_dice(start[1], start[2])
