test_that("Day 23", {
  input <- '#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########'
  example <- read_amphipod(textConnection(input))
  expect_equal(min_amphipod_energy(example), 12521)
})
