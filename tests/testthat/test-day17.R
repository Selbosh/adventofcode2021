test_that("Day 17", {
  target <- read_target('target area: x=20..30, y=-10..-5')
  expect_equal(search_trajectories(target, TRUE), 45)
  expect_equal(search_trajectories(target, FALSE), 112)
})
