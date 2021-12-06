library(adventofcode2021)
input <- scan(input_file(6), sep = ',', quiet = TRUE)
lanternfish(input)
format(lanternfish(input, 256), scientific = FALSE)
