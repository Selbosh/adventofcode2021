#' Day 22
#' @name day22
NULL

#' @rdname day22
#' @param file A filename or text connection.
#' @export
read_cubes <- function(file) {
    input <- gsub("[xyz]=", "", readLines(file))
    input <- strsplit(input, "[ ,]|\\.{2}")
    out <- type.convert(as.data.frame(do.call(rbind, input)), as.is = TRUE)
    setNames(out, c("mode", "x1", "x2", "y1", "y2", "z1", "z2"))
}

#' @rdname day22
#' @param reactor A data frame as produced by [read_cubes].
#' @param init Limit reboot to initialization procedure region?
#' @export
reboot_reactor <- function(reactor, init = FALSE) {
    if (init)
      reactor <- reactor[abs(reactor$x1) <= 50 &
                         abs(reactor$x2) <= 50, ]
    cuboids <- cuboid_list(reactor)
    rebooted <-
        Reduce(cuboids, f = \(a, b) {
               setdiff <- cuboid_setdiff(a$set, b$set[[1]])
               if (b[[2]] == 'off') 
                   return(list(set = setdiff))
               list(set = union(setdiff, b$set))
        })
    sum(sapply(rebooted$set, \(x) x$volume()))
}

#' @import R6
Cuboid <- R6::R6Class('Cuboid',
    public = list(
        x = NULL, y = NULL, z = NULL,
        initialize = function(x, y, z) {
            self$x <- x
            self$y <- y
            self$z <- z
        },
        volume = function() {
            (diff(self$x) + 1) *
            (diff(self$y) + 1) *
            (diff(self$z) + 1)
        },
        cubes = function() { # for debugging purposes
            expand.grid(self$x[1]:self$x[2],
                        self$y[1]:self$y[2],
                        self$z[1]:self$z[2])
        },
        is_overlapping = function(that) {
            is_overlapping(self$x, that$x) &&
            is_overlapping(self$y, that$y) &&
            is_overlapping(self$z, that$z)
        },
        remove = function(that) {
            stopifnot(is.R6(that))
            if (!self$is_overlapping(that))
              return(list(self))
            x <- self$x
            y <- self$y
            z <- self$z
            olx <- interval_intersect(x, that$x)
            oly <- interval_intersect(y, that$y)
            setdiff <- list(
                if (that$x[1] > x[1])
                    Cuboid$new(c(x[1], that$x[1] - 1), y, z),
                if (that$y[1] > y[1])
                    Cuboid$new(olx, c(y[1], that$y[1] - 1), z),
                if (that$y[2] < y[2])
                    Cuboid$new(olx, c(that$y[2] + 1, y[2]), z),
                if (that$z[1] > z[1])
                    Cuboid$new(olx, oly, c(z[1], that$z[1] - 1)),
                if (that$z[2] < z[2])
                    Cuboid$new(olx, oly, c(that$z[2] + 1, z[2])),
                if (that$x[2] < x[2])
                    Cuboid$new(c(that$x[2] + 1, x[2]), y, z)
            )
            setdiff[lengths(setdiff) > 0]
        }
    )
)

cuboid_list <- function(reactor) {
    # Generate list of R6 'Cuboid' class objects.
    cuboids <- apply(reactor[, -1], 1, \(i)
        list(set = list(Cuboid$new(i[c('x1', 'x2')],
                                   i[c('y1', 'y2')],
                                   i[c('z1', 'z2')]))),
                                   simplify = FALSE)
    # Label with the modes.
    mapply(c, cuboids, reactor$mode, SIMPLIFY = FALSE)
}

cuboid_setdiff <- function(set, x) {
  unlist(lapply(set, \(y) y$remove(x)))
}

interval_intersect <- function(a, b) {
    c(max(a[1], b[1]), min(a[2], b[2]))
}

is_overlapping <- function(a, b) {
    a[1] <= b[2] && a[2] >= b[1]
}

# When two cuboids intersect (both on, or on + off) the resulting volume is non-convex.
# But we can still describe the shape as the union of several non-overlapping cuboids.
# Hence on each operation we split the volume(s) into a set of such cuboids.
# Clearly there's more than one way to do this.
# ________           ____             ___              ____           ___
#| A   __|____      | A1|   ____     |__| } A2        | A1|   ____   |__| A3  ___
#|____|__|   |  =   |___|  | B1|  +  |__| } }      =  |___|  | B1|    ___    |__| C
#     |____B_|             |___|     |__|   } B2             |___|   |__| B3
#
#
# Split each rectangle into 2.
# Start with x. We see that A_x2 > B_x1
# So divide A into A_x1..B_x1, A_y1..A_y2
#       and B into A_x2..B_x2, B_y1..B_y2
#         + C with B_x1..A_x2, ??? (y coordinates as yet unknown)
# Next we see that B_y2 > A_y1 (assuming 'up' is positive)
# So       AC with B_x1..A_x2, B_y2..A_y2
#          AB with B_x1..A_x2, B_y1..A_y1
#      and  C   is B_x1..A_x2, A_y1..B_y2
# And we return the new cuboids A', B', AC, AB and C, i.e. 2 rectangles become 5 (though AC, AB might be empty if the overlap in y is total)
#
# If they don't overlap in both x and y directions, then skip, no partition needed.
# The process is therefore: in coordinate 1 (i.e. x), divide A into A1, A2 and B into B1, B2
#                           for any overlaps in A1, A2, B1, B2 (in the Figure above denoted by A2 & B2):
#                           divide A2, B2 into A21, A22, B21, B22
#                           then simply remove duplicates (because A22 and B22 overlap entirely, represented above by 'C')
#  The last step allows for the possibility that A and B overlap exactly in y coords. Then we'd get A21, A22, B21 and B22 all dupes
#
# This process should be repeated for all pairs of rows xyz, xyz until no more overlaps remain.
