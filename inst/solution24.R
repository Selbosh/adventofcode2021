library(adventofcode2021)
instructions <- read_alu(input_file(24))
alu_model_number(instructions)
alu_model_number(instructions, minimize = TRUE)

