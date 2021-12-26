test_that("Day 25", {
  input <- 'v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>'
  example <- read.matrix(textConnection(input))
  expect_equal(move_cucumbers(example), 58)
})
