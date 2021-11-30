test_that("Generate paths to puzzle input files", {
  if (Sys.Date() > as.Date('2021-12-01')) {
    expect_equal(input_file(1), 'inst/input01.txt')
  } else {
    expect_error(input_file(1))
  }

  if (Sys.Date() > as.Date('2021-12-25')) {
    expect_equal(input_file(25), 'inst/input25.txt')
  } else {
    expect_error(input_file(25))
  }

  expect_error(input_file(0))
})
