test_that("Day 13", {
  input <- '6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5'
  f <- tempfile()
  writeLines(readLines(textConnection(input)), f)
  data <- read_origami(f)
  fold1 <- fold_paper(data[[1]], data[[2]], 1)
  fold2 <- fold_paper(data[[1]], data[[2]], 2)
  expect_equal(nrow(fold1), 17)
  expect_equal(nrow(fold2), 16)
})
