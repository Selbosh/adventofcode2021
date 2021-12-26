#' Day 23: Amphipod
#'
#' A group of amphipods notice your fancy submarine and flag you down. "With such an impressive shell," one amphipod says, "surely you can help us with a question that has stumped our best scientists."
#'
#' They go on to explain that a group of timid, stubborn amphipods live in a nearby burrow. Four types of amphipods live there: Amber (A), Bronze (B), Copper (C), and Desert (D). They live in a burrow that consists of a hallway and four side rooms. The side rooms are initially full of amphipods, and the hallway is initially empty.
#'
#' They give you a diagram of the situation (your puzzle input), including locations of each amphipod (A, B, C, or D, each of which is occupying an otherwise open space), walls (`#`), and open space (`.`).
#'
#' For example:
#'
#'     #############
#'     #...........#
#'     ###B#C#B#D###
#'       #A#D#C#A#
#'       #########
#'
#' The amphipods would like a method to organize every amphipod into side rooms so that each side room contains one type of amphipod and the types are sorted A-D going left to right, like this:
#'
#'     #############
#'     #...........#
#'     ###A#B#C#D###
#'       #A#B#C#D#
#'       #########
#'
#' Amphipods can move up, down, left, or right so long as they are moving into an unoccupied open space. Each type of amphipod requires a different amount of energy to move one step: Amber amphipods require 1 energy per step, Bronze amphipods require 10 energy, Copper amphipods require 100, and Desert ones require 1000. The amphipods would like you to find a way to organize the amphipods that requires the least total energy.
#'
#' However, because they are timid and stubborn, the amphipods have some extra rules:
#'
#' - Amphipods will never stop on the space immediately outside any room. They can move into that space so long as they immediately continue moving. (Specifically, this refers to the four open spaces in the hallway that are directly above an amphipod starting position.)
#' - Amphipods will never move from the hallway into a room unless that room is their destination room and that room contains no amphipods which do not also have that room as their own destination. If an amphipod's starting room is not its destination room, it can stay in that room until it leaves the room. (For example, an Amber amphipod will not move from the hallway into the right three rooms, and will only move into the leftmost room if that room is empty or if it only contains other Amber amphipods.)
#' - Once an amphipod stops moving in the hallway, it will stay in that spot until it can move into a room. (That is, once any amphipod starts moving, any other amphipods currently in the hallway are locked in place and will not move again until they can move fully into a room.)
#'
#' In the above example, the amphipods can be organized using a minimum of 12521 energy. One way to do this is shown below.
#'
#' Starting configuration:
#'
#'     #############
#'     #...........#
#'     ###B#C#B#D###
#'       #A#D#C#A#
#'       #########
#'
#' One Bronze amphipod moves into the hallway, taking 4 steps and using 40 energy:
#'
#'     #############
#'     #...B.......#
#'     ###B#C#.#D###
#'       #A#D#C#A#
#'       #########
#'
#' The only Copper amphipod not in its side room moves there, taking 4 steps and using 400 energy:
#'
#'     #############
#'     #...B.......#
#'     ###B#.#C#D###
#'       #A#D#C#A#
#'       #########
#'
#' A Desert amphipod moves out of the way, taking 3 steps and using 3000 energy, and then the Bronze amphipod takes its place, taking 3 steps and using 30 energy:
#'
#'     #############
#'     #.....D.....#
#'     ###B#.#C#D###
#'       #A#B#C#A#
#'       #########
#'
#' The leftmost Bronze amphipod moves to its room using 40 energy:
#'
#'     #############
#'     #.....D.....#
#'     ###.#B#C#D###
#'       #A#B#C#A#
#'       #########
#'
#' Both amphipods in the rightmost room move into the hallway, using 2003 energy in total:
#'
#'     #############
#'     #.....D.D.A.#
#'     ###.#B#C#.###
#'       #A#B#C#.#
#'       #########
#'
#' Both Desert amphipods move into the rightmost room using 7000 energy:
#'
#'     #############
#'     #.........A.#
#'     ###.#B#C#D###
#'       #A#B#C#D#
#'       #########
#'
#' Finally, the last Amber amphipod moves into its room, using 8 energy:
#'
#'     #############
#'     #...........#
#'     ###A#B#C#D###
#'       #A#B#C#D#
#'       #########
#'
#' What is the least energy required to organize the amphipods?
#'
#' ## Part Two:
#'
#' As you prepare to give the amphipods your solution, you notice that the diagram they handed you was actually folded up. As you unfold it, you discover an extra part of the diagram.
#'
#' Between the first and second lines of text that contain amphipod starting positions, insert the following lines:
#'
#'     #D#C#B#A#
#'     #D#B#A#C#
#'
#' So, the above example now becomes:
#'
#'     #############
#'     #...........#
#'     ###B#C#B#D###
#'       #D#C#B#A#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#' The amphipods still want to be organized into rooms similar to before:
#'
#'     #############
#'     #...........#
#'     ###A#B#C#D###
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#' In this updated example, the least energy required to organize these amphipods is 44169:
#'
#'     #############
#'     #...........#
#'     ###B#C#B#D###
#'       #D#C#B#A#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #..........D#
#'     ###B#C#B#.###
#'       #D#C#B#A#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #A.........D#
#'     ###B#C#B#.###
#'       #D#C#B#.#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #A........BD#
#'     ###B#C#.#.###
#'       #D#C#B#.#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #A......B.BD#
#'     ###B#C#.#.###
#'       #D#C#.#.#
#'       #D#B#A#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #AA.....B.BD#
#'     ###B#C#.#.###
#'       #D#C#.#.#
#'       #D#B#.#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #AA.....B.BD#
#'     ###B#.#.#.###
#'       #D#C#.#.#
#'       #D#B#C#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #AA.....B.BD#
#'     ###B#.#.#.###
#'       #D#.#C#.#
#'       #D#B#C#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #AA...B.B.BD#
#'     ###B#.#.#.###
#'       #D#.#C#.#
#'       #D#.#C#C#
#'       #A#D#C#A#
#'       #########
#'
#'     #############
#'     #AA.D.B.B.BD#
#'     ###B#.#.#.###
#'       #D#.#C#.#
#'       #D#.#C#C#
#'       #A#.#C#A#
#'       #########
#'
#'     #############
#'     #AA.D...B.BD#
#'     ###B#.#.#.###
#'       #D#.#C#.#
#'       #D#.#C#C#
#'       #A#B#C#A#
#'       #########
#'
#'     #############
#'     #AA.D.....BD#
#'     ###B#.#.#.###
#'       #D#.#C#.#
#'       #D#B#C#C#
#'       #A#B#C#A#
#'       #########
#'
#'     #############
#'     #AA.D......D#
#'     ###B#.#.#.###
#'       #D#B#C#.#
#'       #D#B#C#C#
#'       #A#B#C#A#
#'       #########
#'
#'     #############
#'     #AA.D......D#
#'     ###B#.#C#.###
#'       #D#B#C#.#
#'       #D#B#C#.#
#'       #A#B#C#A#
#'       #########
#'
#'     #############
#'     #AA.D.....AD#
#'     ###B#.#C#.###
#'       #D#B#C#.#
#'       #D#B#C#.#
#'       #A#B#C#.#
#'       #########
#'
#'     #############
#'     #AA.......AD#
#'     ###B#.#C#.###
#'       #D#B#C#.#
#'       #D#B#C#.#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #AA.......AD#
#'     ###.#B#C#.###
#'       #D#B#C#.#
#'       #D#B#C#.#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #AA.......AD#
#'     ###.#B#C#.###
#'       #.#B#C#.#
#'       #D#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #AA.D.....AD#
#'     ###.#B#C#.###
#'       #.#B#C#.#
#'       #.#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #A..D.....AD#
#'     ###.#B#C#.###
#'       #.#B#C#.#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #...D.....AD#
#'     ###.#B#C#.###
#'       #A#B#C#.#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #.........AD#
#'     ###.#B#C#.###
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #..........D#
#'     ###A#B#C#.###
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#'     #############
#'     #...........#
#'     ###A#B#C#D###
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #A#B#C#D#
#'       #########
#'
#' Using the initial configuration from the full diagram, what is the least energy required to organize the amphipods?
#' @source <https://adventofcode.com/2021/day/23>
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
