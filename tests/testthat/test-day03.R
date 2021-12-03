test_that("Day 3", {
  example <- read.fwf(textConnection('00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010'), widths = rep(1, 5))
  expect_equal(binary_to_int(c(0, 1, 0, 0, 1)), 9)
  expect_equal(binary_to_int(c(1, 0, 1, 1, 0)), 22)
  expect_equal(binary_diagnostic(example), 198)
})
