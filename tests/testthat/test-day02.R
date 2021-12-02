test_that("Day 2", {
  example <- data.frame(cmd = c('forward', 'down', 'forward', 'up',
                                'down', 'forward'),
                        value = c(5, 5, 8, 3, 8, 2))
  expect_equal(dive(example), 150)
  expect_equal(dive2(example), 900)
})
