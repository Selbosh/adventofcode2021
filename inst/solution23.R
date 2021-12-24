library(adventofcode2021)
# Part 1
start <- read_amphipod(input_file(23))
min_amphipod_energy(start) # ~ 120s
# Part 2
start2 <- start$clone()
start2$rooms <- setNames(c(rbind(matrix(start$rooms, 2)[1, ],
                                 c('D', 'C', 'B', 'A'),
                                 c('D', 'B', 'A', 'C'),
                                 matrix(start$rooms, 2)[2, ])),
                         paste0(rep(LETTERS[1:4], each = 4), 1:4))
min_amphipod_energy(start2) # ~ 135s
