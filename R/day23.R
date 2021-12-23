#' Day 23
#' @name day23
NULL

#' @rdname day23
#' @param file A filename or text connection.
#' @export
read_amphipod <- function(file) {
    input <- read.matrix(file)
    do.call(rbind,
            lapply(LETTERS[1:4],
                   \(x) data.frame(type = x, which(input == x, arr.ind = T))))
}
