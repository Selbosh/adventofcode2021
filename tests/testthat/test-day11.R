test_that("Day 11, small inputs", {
  small_input <- c('11111
19991
19191
19991
11111', '34543
40004
50005
40004
34543', '45654
51115
61116
51115
45654')
  small <- lapply(small_input, \(x) read.matrix(textConnection(x)))
  expect_equal(step1(small[[1]]), small[[2]])
  expect_equal(step1(small[[2]]), small[[3]])
  expect_equal(count_flashes(small[[1]]), 9)
  expect_equal(count_flashes(small[[1]], 2), 9)
})

test_that("Day 11, larger inputs", {
  example_input <- c('5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526', '6594254334
3856965822
6375667284
7252447257
7468496589
5278635756
3287952832
7993992245
5957959665
6394862637', '8807476555
5089087054
8597889608
8485769600
8700908800
6600088989
6800005943
0000007456
9000000876
8700006848','0050900866
8500800575
9900000039
9700000041
9935080063
7712300000
7911250009
2211130000
0421125000
0021119000', '2263031977
0923031697
0032221150
0041111163
0076191174
0053411122
0042361120
5532241122
1532247211
1132230211', '4484144000
2044144000
2253333493
1152333274
1187303285
1164633233
1153472231
6643352233
2643358322
2243341322')
  example <- lapply(example_input, \(x) read.matrix(textConnection(x)))
  expect_equal(step1(example[[1]]), example[[2]])
  expect_equal(step1(example[[2]]), example[[3]])
  expect_equal(step1(step1(example[[1]])), example[[3]])
  expect_equal(step1(example[[3]]), example[[4]])
  expect_equal(step1(example[[4]]), example[[5]])
  expect_equal(step1(example[[5]]), example[[6]])
  expect_equal(count_flashes(example[[1]], 10), 204)
  expect_equal(count_flashes(example[[1]], 100), 1656)
  expect_equal(count_flashes(example[[1]], 200, part2 = TRUE), 195)
})
