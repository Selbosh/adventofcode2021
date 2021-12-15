
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Advent of Code 2021

[![R-CMD-check](https://github.com/Selbosh/adventofcode2021/actions/workflows/r.yml/badge.svg)](https://github.com/Selbosh/adventofcode2021/actions)

*By [David Selby](https://selbydavid.com)*

This repository contains some of my attempts to solve programming
puzzles in the [Advent of Code 2021](https://adventofcode.com/2021). I
will be mostly using the programming language R, with data and solutions
presented as this downloadable R package.

## Installation

Install the package from GitHub with

``` r
remotes::install_github('Selbosh/adventofcode2021')
```

## Development

Most puzzles in the Advent of Code include a few simple examples of
input and expected output, before asking you to apply code to a larger
dataset. We can incorporate these into a *test-driven development*
framework by writing them as expectations in the `tests` folder.

Write a `test_that` expectation for each day, or part thereof, with
these example inputs and outputs. Then, we don’t attempt to run our code
on the main puzzle input until it generates the expected output for all
of these tests.

## Usage

To print the numerical outputs, we can write vignettes, add our working
to the GitHub `README.Rmd` file, or else write scripts in the `inst/`
folder and to `source()` when required.

``` r
library(adventofcode2021)
get_solution(1)
#> [1] 1266
#> [1] 1217
get_solution(2)
#> [1] 1746616
#> [1] 1741971043
get_solution(3)
#> [1] 4191876
#> [1] 3414905
get_solution(4)
#> [1] 64084
#> [1] 12833
get_solution(5)
#> [1] 5167
#> [1] 17604
get_solution(6)
#> [1] 391888
#> [1] "1754597645339"
get_solution(7)
#> [1] 356922
#> [1] 100347031
get_solution(8)
#> [1] 321
#> [1] 1028926
get_solution(9)
#> [1] 560
#> [1] 959136
get_solution(10)
#> [1] 394647
#> [1] 2380061249
get_solution(11)
#> [1] 1688
#> [1] 403
get_solution(12)
#> [1] 3292
#> [1] 89592
get_solution(13)
#> [1] 671
```

<img src="man/figures/README-day1-1.png" width="100%" />

``` r
get_solution(14)
#> [1] 2947
#> [1] "3232426226464"
get_solution(15)
#> [1] 388
#> [1] 2819
```

## Attribution

Puzzles and their descriptions are by Eric Wastl.
