library(adventofcode2021)
input <- read_sf(readLines(input_file(18)))
# Part 1
reduced <- sf_reduce(input)
magnitude(reduced)
# Part 2
combos <- t(combn(length(input), 2))
combos <- rbind(combos, combos[, 2:1])
magnitudes <- apply(combos, 1, \(i) magnitude(sf_reduce(input[i])))
max(magnitudes)
