library(adventofcode2021)
depths <- scan(input_file(1))
increases(depths)
increases(rolling_sum(depths))
