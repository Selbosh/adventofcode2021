test_that("Day 24", {
  alu <- read_alu(input_file(24))
  # Maximum
  inputs <- c(9, 7, 9, 1, 9, 9, 9, 7, 2, 9, 9, 4, 9, 5)
  w <- x <- y <- z <- 0
  eval(str2expression(alu$expr))
  expect_equal(z, 0)
  # Minimum
  inputs <- c(5, 1, 6, 1, 9, 1, 3, 1, 1, 8, 1, 1, 3, 1)
  w <- x <- y <- z <- 0
  eval(str2expression(alu$expr))
  expect_equal(z, 0)
})
