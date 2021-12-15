test_that("Day 15", {
  input <- '1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581'
  m <- read.matrix(textConnection(input))
  g <- lattice_from_matrix(m)
  expect_equal(lowest_total_risk(g), 40)
  expect_equal(tile_matrix(as.matrix(8), 5),
               matrix(c(8, 9, 1, 2, 3,
                        9, 1, 2, 3, 4,
                        1, 2, 3, 4, 5,
                        2, 3, 4, 5, 6,
                        3, 4, 5, 6, 7), 5, 5))
  g2 <- lattice_from_matrix(tile_matrix(m, 5))
  expect_equal(lowest_total_risk(g2), 315)
})
