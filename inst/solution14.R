library(adventofcode2021)
polymer <- read_polymer(input_file(14))
with(polymer, insert_polymer(template, rules, 10)) |>
  count_polymer() |> range() |> diff()
with(polymer, insert_polymer(template, rules, 40)) |>
  count_polymer() |> range() |> diff() |>
  format(scientific = FALSE)
