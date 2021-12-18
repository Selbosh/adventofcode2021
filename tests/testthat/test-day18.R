test_that("Day 18", {

  # Add
  expect_equal(
    read_sf(c('[1,2]', '[[3,4],5]')),
    list(list(1, 2), list(list(3, 4), 5))
  )

  # Split
  expect_equal(sf_split(list(10)), list(list(5, 5)))
  expect_equal(sf_split(list(11)), list(list(5, 6)))
  expect_equal(sf_split(list(12)), list(list(6, 6)))

  # Utility function for reading in example data
  read_ex <- function(x, reduce = TRUE) {
    snails <- read_sf(readLines(textConnection(x)))
    if (reduce) Reduce(list, snails) else snails
  }

  # Explode
  expect_equal(sf_explode(read_ex('[[[[[9,8],1],2],3],4]')),
               list(list(list(list(0, 9), 2), 3), 4))
  expect_equal(sf_explode(read_ex('[7,[6,[5,[4,[3,2]]]]]')),
               list(7, list(6, list(5, list(7, 0)))))
  expect_equal(sf_explode(read_ex('[[6,[5,[4,[3,2]]]],1]')),
               list(list(6, list(5, list(7, 0))), 3))
  expect_equal(sf_explode(read_ex('[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]')),
               read_ex('[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]'))
  expect_equal(sf_explode(read_ex('[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]')),
               read_ex('[[3,[2,[8,0]]],[9,[5,[7,0]]]]'))

  # Step through example reduction process
  input1 <- read_sf(c('[[[[4,3],4],4],[7,[[8,4],9]]]', '[1, 1]'))
  step1 <- read_sf('[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]')
  step2 <- read_sf('[[[[0,7],4],[7,[[8,4],9]]],[1,1]]')
  step3 <- read_sf('[[[[0,7],4],[15,[0,13]]],[1,1]]')
  step4 <- read_sf('[[[[0,7],4],[[7,8],[0,13]]],[1,1]]')
  step5 <- read_sf('[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]')
  step6 <- read_sf('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]')
  expect_equal(input1, step1)
  expect_equal(sf_explode(step1), step2)
  expect_equal(sf_explode(step2), step3)
  expect_equal(sf_split(step3), step4)
  expect_equal(sf_split(step4), step5)
  expect_equal(sf_explode(step5), step6)

  # Reduce
  expect_equal(sf_reduce(read_ex('[1,1]\n[2,2]\n[3,3]\n[4,4]')),
               read_sf('[[[[1,1],[2,2]],[3,3]],[4,4]]'))
  expect_equal(sf_reduce(read_ex('[1,1]\n[2,2]\n[3,3]\n[4,4]\n[5,5]')),
               read_sf('[[[[3,0],[5,3]],[4,4]],[5,5]]'))
  # This will cause a stack overflow if you try to apply without reducing:
  expect_equal(sf_reduce(read_ex('[1,1]\n[2,2]\n[3,3]\n[4,4]\n[5,5]\n[6,6]')),
               read_sf('[[[[5,0],[7,4]],[5,5]],[6,6]]'))

  # Slightly larger example
  input <- read_ex('[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
[7,[5,[[3,8],[1,4]]]]
[[2,[2,2]],[8,[8,1]]]
[2,9]
[1,[[[9,3],9],[[9,0],[0,7]]]]
[[[5,[7,4]],7],1]
[[[[4,2],2],6],[8,7]]', FALSE) # if reduce = TRUE will cause stack overflow!
  result <- sf_reduce(input)
  expected <- read_sf('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]')
  expect_equal(result, expected)

  # Magnitude
  expect_equal(magnitude(list(list(9, 1), list(1, 9))), 129)
  expect_equal(magnitude(read_sf('[[1,2],[[3,4],5]]')), 143)
  expect_equal(magnitude(read_sf('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]')), 1384)
  expect_equal(magnitude(read_sf('[[[[1,1],[2,2]],[3,3]],[4,4]]')), 445)
  expect_equal(magnitude(read_sf('[[[[3,0],[5,3]],[4,4]],[5,5]]')), 791)
  expect_equal(magnitude(read_sf('[[[[5,0],[7,4]],[5,5]],[6,6]]')), 1137)
  expect_equal(magnitude(expected), 3488)

  # Maximum magnitude of pairs
  hw <- read_ex('[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]', FALSE)
  combos <- t(combn(length(hw), 2))
  combos <- rbind(combos, combos[, 2:1])
  mags <- apply(combos, 1, \(i) magnitude(sf_reduce(hw[i])))
  expect_equal(max(mags), 3993)
})
