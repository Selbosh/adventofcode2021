#' Generate path to puzzle input file
#'
#' Puzzle inputs are typically saved in the form of text files with the name
#' `input01.txt`, `input02.txt`, ... etc. in the package's `inst/` folder.
#' This helper function makes it easy to read in the data using `readLines`,
#' `scan` or `read.csv` as appropriate.
#'
#' Sometimes inputs are simple strings or numbers and passed directly to
#' the function, rather than being read from file. So not every day will have an
#' `input.txt` file associated with it.
#'
#' @param day integer between 1 and 25
#'
#' @return File path, e.g. `"/inst/input01.txt"`.
#' If that file does not exists, or if the argument `day` is not between 1 and
#' 25, an error will be thrown.
#'
#' @export
input_file <- function(day) {
  stopifnot(day >= 1 & day <= 25)
  system.file(c('inst', sprintf('input%02d.txt', day)),
              package = 'adventofcode2021', mustWork = TRUE)
}
