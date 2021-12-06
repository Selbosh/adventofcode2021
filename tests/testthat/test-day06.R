test_that("Day 6", {
  example <- c(3, 4, 3, 1, 2)
  expect_equal(lanternfish(example, 18), 26)
  expect_equal(lanternfish(example, 80), 5934)
})
