library(adventofcode2021)
input <- read_draws(input_file(4))
do.call(play_bingo, input)
do.call(play_bingo2, input)
