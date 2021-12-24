#' Day 23
#' @name day23
NULL

#' @rdname day23
#' @param file A filename or text connection.
#' @export
read_amphipod <- function(file) {
  mat <- read.matrix(file)
  hallways <- mat[2, setdiff(2:12, c(4, 6, 8, 10))]
  rooms <- mat[cbind(rep(3:4, 4), c(4, 6, 8, 10))]
  rooms <- setNames(rooms, paste0(rep(LETTERS[1:4], each = 2), 1:2))
  list(rooms = rooms, hallways = hallways)
}

move_cost <-
  c(A = 1, B = 10, C = 100, D = 1000)

# there are 7 hallway spaces (2 either side plus 3 between rooms)
# and there are 8 room spaces (2 spaces in 4 rooms)
distance <- matrix(
  c(3, 4, 5, 6, 7, 8, 9, 10,
    2, 3, 4, 5, 6, 7, 8, 9,
    2, 3, 2, 3, 4, 5, 7, 8,
    5, 6, 2, 3, 2, 3, 4, 5,
    6, 7, 4, 5, 2, 3, 2, 3,
    8, 9, 6, 7, 4, 5, 2, 3,
    9, 10, 7, 8, 5, 6, 3, 4),
  nrow = 7, ncol = 8, byrow = TRUE,
  dimnames = list(hallway = NULL,
                  room = paste0(rep(LETTERS[1:4], each = 2), 1:2)))

State <- R6::R6Class(
  'State',
  public = list(
    rooms = NULL,     # named vector, A1, A2, B1, B2, C1, C2, D1, D2
    hallways = NULL,  # vector of length 7. Unnamed but order is important.
    score = NULL,
    initialize = function(rooms, hallways = NULL, score = 0) {
      self$rooms <- rooms
      self$hallways <- if(!is.null(hallways)) hallways else rep('.', 7)
      self$score <- score
    },
    move = function(from, to, from_hallway, score) { #TODO
      rooms <- self$rooms
      hallways <- self$hallways
      if (from_hallway) {
        rooms[to] <- hallways[from]
        hallways[from] <- '.'
      } else {
        hallways[to] <- rooms[from]
        rooms[from] <- '.'
      }
      State$new(rooms, hallways, score)
    })
)

hallway_paths <- list(
  list(A = 2,
       B = 2:3,
       C = 2:4,
       D = 2:5),
  list(A = NULL,
       B = 3,
       C = 3:4,
       D = 3:5),
  list(A = NULL,
       B = NULL,
       C = 4,
       D = 4:5),
  list(A = 3,
       B = NULL,
       C = NULL,
       D = 5),
  list(A = 3:4,
       B = 4,
       C = NULL,
       D = NULL),
  list(A = 3:5,
       B = 4:5,
       C = 5,
       D = NULL),
  list(A = 3:6,
       B = 4:6,
       C = 5:6,
       D = 6)
)

valid_moves <- function(state) {
  moves <- NULL
  for (i in seq_along(state$hallways)) {
    amphipod <- state$hallways[i]
    # If this spot is empty, nothing to move.
    if (amphipod == '.')
      next
    dest <- paste0(amphipod, 1:2)
    # If destination room contains other, different amphipods.
    if (any(setdiff(LETTERS[1:4], amphipod) %in% state$rooms[dest]))
      next
    # If any hallway between here and destination is blocked.
    path <- hallway_paths[[i]][[amphipod]]
    if (any(state$hallways[path] != '.'))
      next
    # Move to the deepest available space in destination room.
    dest <- dest[max(which(state$rooms[dest] == '.'))]
    stopifnot(length(dest) > 0)
    score <- state$score + distance[i, dest] * move_cost[amphipod]
    moves <- c(moves, state$move(from = i,
                                 to = dest,
                                 from_hallway = TRUE,
                                 score = score))
  }
  for (i in seq_along(state$rooms)) {
    amphipod <- state$rooms[i]
    room_cell <- names(amphipod)
    room <- substring(room_cell, 1, 1)
    # If this spot is empty, nothing to move.
    if (amphipod == '.')
      next
    # Can't leave this room if our exit is blocked by another amphipod.
    if (i %% 2 == 0 && state$rooms[i - 1] != '.')
      next
    # No point in leaving this room if we're at our destination at depth 2.
    if (i %% 2 == 0 && amphipod == room)
      next
    # No point in leaving our destination except to let another amphipod out.
    if (i %% 2 == 1 && amphipod == room &&
        state$rooms[i + 1] == amphipod)
      next
    # Which hallway tile should we move to?
    empty_hallways <- which(state$hallways == '.')
    # browser()
    for (h in empty_hallways) {
      if (all(hallway_paths[[h]][[room]] %in% empty_hallways)) {
        score <- state$score + distance[h, room_cell] * move_cost[amphipod]
        moves <- c(moves, state$move(from = i,
                                     to = h,
                                     from_hallway = FALSE,
                                     score = score))
      }
    }
  }
  moves[order(sapply(moves, \(s) s$score))]
}
