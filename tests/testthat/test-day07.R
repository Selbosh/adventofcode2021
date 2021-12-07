test_that("Day 7", {
  example <- c(16, 1, 2, 0, 4, 2, 7, 1, 2, 14)
  expect_equal(minimize_fuel(example), 37)
  expect_equal(minimize_fuel2(example), 168)
})
