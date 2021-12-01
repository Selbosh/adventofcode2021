test_that("Day 1", {
  depths <- c(199, 200, 208, 210, 200, 207, 240, 269, 260, 263)
  expect_equal(increases(depths), 7)
  expect_equal(increases(rolling_sum(depths)), 5)
})
