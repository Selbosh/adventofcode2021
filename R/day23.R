#' Day 23
#' @name day23
NULL

#' @rdname day23
#' @param file A filename or text connection.
#' @export
read_amphipod <- function(file) {
  mat <- read.matrix(file)
  hallways <- mat[2, setdiff(2:12, c(4, 6, 8, 10))]
  rooms <- mat[cbind(rep(3:4, 4), rep(c(4, 6, 8, 10), each = 2))]
  rooms <- setNames(rooms, paste0(rep(LETTERS[1:4], each = 2), 1:2))
  State$new(rooms, hallways)
}

#' @rdname day23
#' @param start A `State` R6 object describing the initial position.
#' @export
min_amphipod_energy <- function(start) {
  states <- list(start)
  best_score <- Inf
  while (length(states)) {
    new_states <- list()
    for (state in states) {
      if (is.finite(best_score))
        message('Best score: ', best_score)
      for (move in valid_moves(state)) {
        if (move$finished) {
          best_score <- min(best_score, move$score)
        } else if (move$score < best_score) {
          if (move$key %in% names(new_states)) {
            old_score <- new_states[[move$key]]$score
            if (old_score > move$score)
              new_states[[move$key]]$score <- move$score
          } else new_states[[move$key]] <- move
        }
      }
    }
    message('Exploring ', length(new_states), ' new states')
    states <- new_states
  }
  best_score
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

distance2 <- cbind(distance[, 1:2], distance[, 2] + 1, distance[, 2] + 2,
                   distance[, 3:4], distance[, 4] + 1, distance[, 4] + 2,
                   distance[, 5:6], distance[, 6] + 1, distance[, 6] + 2,
                   distance[, 7:8], distance[, 8] + 1, distance[, 8] + 2)
colnames(distance2) <- paste0(rep(LETTERS[1:4], each = 4), 1:4)

State <- R6::R6Class(
  'State',
  public = list(
    rooms = NULL,     # named vector, A1, A2, B1, B2, C1, C2, D1, D2
    hallways = NULL,  # vector of length 7. Unnamed but order is important.
    score = NULL,
    finished = NULL,
    key = NULL,
    initialize = function(rooms, hallways = NULL, score = 0) {
      self$rooms <- rooms
      self$hallways <- if(!is.null(hallways)) hallways else rep('.', 7)
      self$score <- score
      self$finished <- all(self$hallways == '.') &&
        all(self$rooms == rep(LETTERS[1:4], each = length(rooms) / 4))
      self$key = paste(c(hallways, rooms), collapse = ',')
    },
    move = function(from, to, from_hallway, score) {
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
  room_depth <- length(state$rooms) / 4
  if (room_depth == 4)
    distance <- distance2
  moves <- NULL
  for (i in seq_along(state$hallways)) {
    amphipod <- state$hallways[i]
    # If this spot is empty, nothing to move.
    if (amphipod == '.')
      next
    dest <- paste0(amphipod, seq_len(room_depth))
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
    if (!dest %in% colnames(distance)) browser()
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
    pos_in_room <- as.integer(substring(room_cell, 2, 2))
    # If this spot is empty, nothing to move.
    if (amphipod == '.')
      next
    # Can't leave this room if our exit is blocked by another amphipod.
    if (pos_in_room > 1 && state$rooms[i - 1] != '.')
      next
    # No point in leaving destination room except to let other types out.
    if (room == amphipod &&
        all(state$rooms[paste0(room, pos_in_room:room_depth)] == amphipod))
      next
    # Which hallway tile should we move to?
    empty_hallways <- which(state$hallways == '.')
    for (h in empty_hallways) {
      if (all(hallway_paths[[h]][[room]] %in% empty_hallways)) { # not blocked
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
