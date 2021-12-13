library(adventofcode2021)
input <- c(read_origami(input_file(13)), n = 1)
nrow(do.call(fold_paper, input))
input$n <- nrow(input[[2]])
folded <- do.call(fold_paper, input)

library(ggplot2)
ggplot(folded) +
  aes(x, y) +
  geom_tile(fill = '#f5c966') +
  coord_fixed() +
  scale_y_reverse() +
  theme_void()
