test_that("Generate paths to puzzle input files", {
  expect_type(input_file(1), 'character')
  expect_error(input_file(0))
})
