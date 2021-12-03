library(adventofcode2021)
input <- read.fwf(input_file(3), widths = rep(1, 12))
power_consumption(input)
life_support(input)
