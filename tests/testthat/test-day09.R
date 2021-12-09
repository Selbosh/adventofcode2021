test_that("Day 9", {
  example <- '2199943210
3987894921
9856789892
8767896789
9899965678'
  h <- read.matrix(textConnection(example))
  expect_equal(sort(lowest_points(h)), c(0, 1, 5, 5))
  expect_equal(basins(h), c(14, 9, 9), ignore_attr = TRUE)
})



