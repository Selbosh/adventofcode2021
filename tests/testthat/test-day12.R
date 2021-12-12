test_that("Day 12", {
  inputs <- c('start-A\nstart-b\nA-c\nA-b\nb-d\nA-end\nb-end',
              'dc-end\nHN-start\nstart-kj\ndc-start\ndc-HN\nLN-dc\nHN-end\nkj-sa\nkj-HN\nkj-dc',
              'fs-end\nhe-DX\nfs-he\nstart-DX\npj-DX\nend-zg\nzg-sl\nzg-pj\npj-he\nRW-he\nfs-DX\npj-RW\nzg-RW\nstart-pj\nhe-WI\nzg-he\npj-fs\nstart-RW')
  examples <- lapply(inputs, textConnection) |> lapply(read_edges)
  path_counts <- sapply(examples, count_paths)
  expect_equal(path_counts, c(10, 19, 226))
  path_counts2 <- sapply(examples, count_paths2)
  expect_equal(path_counts2, c(36, 103, 3509))
})
