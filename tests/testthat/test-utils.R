test_that("Generate paths to puzzle input files", {
  expect_type(input_file(1), 'character')
  expect_error(input_file(0))
})

test_that("Fixed-width files parse correctly as matrices", {
  txt <- '1010101\n1101010\n1010101\n0110101\n0100010'
  m <- read.matrix(textConnection(txt))
  expect_type(m, 'integer')
  expect_true(is.matrix(m))
  expect_equal(dim(m), c(5, 7))
})
