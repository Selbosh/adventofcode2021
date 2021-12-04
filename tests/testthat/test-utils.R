test_that("Generate paths to puzzle input files", {
  expect_type(input_file(1), 'character')
  expect_error(input_file(0))
})

test_that("Fixed-width files parse correctly as matrices", {
  txt <- '1010101
1101010
1010101
0110101
0100010'
  m_num <- read.matrix(textConnection(txt), 'numeric')
  m_txt <- read.matrix(textConnection(txt), 'character')
  expect_type(m_num, 'double')
  expect_type(m_txt, 'character')
  expect_true(is.matrix(m_num))
  expect_true(is.matrix(m_txt))
  expect_equal(dim(m_num), c(5, 7))
  expect_equal(dim(m_txt), c(5, 7))
})
