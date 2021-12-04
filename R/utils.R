#' Generate path to puzzle input file
#'
#' Puzzle inputs are typically saved in the form of text files with the name
#' `input01.txt`, `input02.txt`, ... etc. in the package's `inst/` folder.
#' This helper function makes it easy to read in the data using the `readLines`,
#' `scan` or `read.csv` functions, as appropriate.
#'
#' Sometimes inputs are simple strings or numbers and passed directly to
#' the function, rather than being read from file. So not every day will have an
#' `input.txt` file associated with it.
#'
#' @param day integer between 1 and 25
#'
#' @return File path, e.g. `"path/to/input01.txt"`.
#' If that file does not exist, or if the argument `day` is not between 1 and
#' 25, an error will be thrown.
#'
#' @export
input_file <- function(day) {
  stopifnot(day >= 1 & day <= 25)
  system.file(sprintf('input%02d.txt', day),
              package = 'adventofcode2021',
              mustWork = TRUE)
}

#' Run solution script for a particular day
#'
#'
#' @inheritParams input_file
#' @export
get_solution <- function(day) {
  stopifnot(day >= 1 & day <= 25)
  filename <- system.file(sprintf('solution%02d.R', day),
                          package = 'adventofcode2021',
                          mustWork = TRUE)
  source(filename, print.eval = TRUE)
}

#' Read a fixed-width matrix with no delimiter or header
#'
#' Equivalent to `read.fwf` but faster and width does not need to be specified.
#'
#' @examples
#' read.matrix(input_file(3))
#'
#' @param file A text file or connection
#' @param type Storage mode, defaults to numeric
#'
#' @return A matrix
#'
#' @export
read.matrix <- function(file, type = 'numeric') {
  type <- match.arg(type,
                    c('numeric', 'logical', 'integer', 'character'))
  mat <- do.call(rbind, strsplit(readLines(file), ''))
  storage.mode(mat) <- type
  mat
}
