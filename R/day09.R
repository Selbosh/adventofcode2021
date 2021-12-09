#' Day 9: Smoke Basin
#'
#' These caves seem to be lava tubes. Parts are even still volcanically active; small hydrothermal vents release smoke into the caves that slowly settles like rain.
#'
#' If you can model how the smoke flows through the caves, you might be able to avoid it and be that much safer. The submarine generates a heightmap of the floor of the nearby caves for you (your puzzle input).
#'
#' Smoke flows to the lowest point of the area it's in. For example, consider the following heightmap:
#'
#'     2199943210
#'     3987894921
#'     9856789892
#'     8767896789
#'     9899965678
#'
#' Each number corresponds to the height of a particular location, where 9 is the highest and 0 is the lowest a location can be.
#'
#' Your first goal is to find the low points - the locations that are lower than any of its adjacent locations. Most locations have four adjacent locations (up, down, left, and right); locations on the edge or corner of the map have three or two adjacent locations, respectively. (Diagonal locations do not count as adjacent.)
#'
#' In the above example, there are four low points, all highlighted: two are in the first row (a 1 and a 0), one is in the third row (a 5), and one is in the bottom row (also a 5). All other locations on the heightmap have some lower adjacent location, and so are not low points.
#'
#' The risk level of a low point is 1 plus its height. In the above example, the risk levels of the low points are 2, 1, 6, and 6. The sum of the risk levels of all low points in the heightmap is therefore 15.
#'
#' Find all of the low points on your heightmap. What is the sum of the risk levels of all low points on your heightmap?
#'
#' ## Part Two:
#'
#' Next, you need to find the largest basins so you know what areas are most important to avoid.
#'
#' A basin is all locations that eventually flow downward to a single low point. Therefore, every low point has a basin, although some basins are very small. Locations of height 9 do not count as being in any basin, and all other locations will always be part of exactly one basin.
#'
#' The size of a basin is the number of locations within the basin, including the low point. The example above has four basins.
#'
#' The top-left basin, size 3:
#'
#'     21
#'     3
#'
#' The top-right basin, size 9:
#'
#'          43210
#'           4 21
#'              2
#'
#' The middle basin, size 14:
#'
#'       878
#'      85678
#'     87678
#'      8
#'
#' The bottom-right basin, size 9:
#'
#'            8
#'           678
#'          65678
#'
#' Find the three largest basins and multiply their sizes together. In the above example, this is 9 * 14 * 9 = 1134.
#'
#' What do you get if you multiply together the sizes of the three largest basins?
#'
#' @source <https://adventofcode.com/2021/day/9>
#' @name day09
NULL

lowest <- function(h) {
  # right
  h < cbind(h, Inf)[, -1] &
  # down
  h < rbind(h, Inf)[-1, ] &
  # left
  h < cbind(Inf, h[, -ncol(h)]) &
  # up
  h < rbind(Inf, h[-nrow(h), ])
}

#' @rdname day09
#' @param h A numeric matrix of heights.
#' @return `lowest_point`: A vector of heights at the lowest points.
#' @export
lowest_points <- function(h) {
  h[lowest(h)]
}

#' @rdname day09
#' @return `basins`: sizes of the three largest basins.
#' @export
basins <- function(h) {
  l <- lowest(h)
  h[] <- ifelse(h < 9, NA, Inf)
  h[l] <- 1:sum(l)
  while (anyNA(h)) {
    for (i in 1:nrow(h)) for (j in 1:ncol(h)) {
      if (is.na(h[i, j])) {
        nbrs <- h[cbind(c(pmax(i - 1, 1), pmin(i + 1, nrow(h)), i, i),
                        c(j, j, pmax(j - 1, 1), pmin(j + 1, ncol(h))))]
        if (any(is.finite(nbrs)))
          h[i, j] <- nbrs[is.finite(nbrs)][1]
      }
    }
  }
  sizes <- table(h[is.finite(h)])
  head(sort(sizes, decreasing = TRUE), 3)
}
