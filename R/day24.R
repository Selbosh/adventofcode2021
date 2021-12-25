#' @name day24
NULL

#' @rdname day24
#' @param file A filename or text connection.
#' @export
read_alu <- function(file) {
    instr <- read.table(file, fill = NA,
                        col.names = c('op', 'lhs', 'val'), row.names = NULL)
    instr$op <- sub('mul', '*', instr$op)
    instr$op <- sub('add', '+', instr$op)
    instr$op <- sub('eql', '==', instr$op)
    instr$op <- sub('div', '%//%', instr$op)
    instr$op <- sub('mod', '%%', instr$op)
    instr$rhs <- ifelse(instr$op == 'inp', '', instr$lhs)
    instr$op <- sub('inp', 'input[1]; input <- input[-1]', instr$op)
    apply(instr, 1, \(y) paste(y['lhs'], '<-', y['rhs'], y['op'], y['val']))
}

model_number <- function(instructions) {
    `%//%` <- \(x, y) trunc(x / y) # truncated integer division
    text <- paste(instructions, collapse = '\n')
    expr <- str2expression(text)
    i <- 99999999999999
    repeat {
        w <- x <- y <- z <- 0
        input <- as.numeric(strsplit(as.character(i), '')[[1]])
        if (0 %in% input) {
            i <- i - 1
            next
        }
        eval(expr)
        message('i = ', i, '\tz = ', z)
        if (!is.na(z) && z == 0)
          return(i)
        i <- i - 1
    }
    stop('No valid numbers found')
}

instructions <- read_alu(input_file(24))
model_number(instructions)
