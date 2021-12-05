library(adventofcode2021)

lines <- read_segments(input_file(5))
count_intersections(lines)
count_intersections(lines, part2 = TRUE)
