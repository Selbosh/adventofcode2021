test_that("Day 14", {
  input <- 'NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C'
  example <- read_polymer(textConnection(input))
  insert10 <- with(example, insert_polymer(template, rules, 10))
  expect_equal(count_polymer(insert10), c(B = 1749, C = 298, H = 161, N = 865))
  insert40 <- with(example, insert_polymer(template, rules, 40))
  expect_equal(range(count_polymer(insert40)), c(3849876073, 2192039569602))
})
