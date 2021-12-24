library(adventofcode2021)
input <- read_amphipod(input_file(23))
start <- State$new(input$rooms, input$hallways)
start
valid <- valid_moves(start)
