test_that("Day 21", {
  expect_equal(deterministic_dice(4, 8), 739785)
  expect_equal(dirac_dice(4, 8), 444356092776315)
})
