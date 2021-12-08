library(adventofcode2021)
digits <- do.call(rbind, strsplit(readLines(input_file(8)), '[^a-z]+'))
count_unique(digits)
sum(apply(digits, 1, output_value))
