if (FALSE) {
read_scanners <- function(file) {
  input <- read.csv(file, header = FALSE, col.names = c('x', 'y', 'z'))
  split(input, cumsum(is.na(input$z))) |>
    lapply('[', -1, ) |>
    lapply(type.convert, as.is = TRUE)
}

# Example inputs
input <- "--- scanner 0 ---\n404,-588,-901\n528,-643,409\n-838,591,734\n390,-675,-793\n-537,-823,-458\n-485,-357,347\n-345,-311,381\n-661,-816,-575\n-876,649,763\n-618,-824,-621\n553,345,-567\n474,580,667\n-447,-329,318\n-584,868,-557\n544,-627,-890\n564,392,-477\n455,729,728\n-892,524,684\n-689,845,-530\n423,-701,434\n7,-33,-71\n630,319,-379\n443,580,662\n-789,900,-551\n459,-707,401\n\n--- scanner 1 ---\n686,422,578\n605,423,415\n515,917,-361\n-336,658,858\n95,138,22\n-476,619,847\n-340,-569,-846\n567,-361,727\n-460,603,-452\n669,-402,600\n729,430,532\n-500,-761,534\n-322,571,750\n-466,-666,-811\n-429,-592,574\n-355,545,-477\n703,-491,-529\n-328,-685,520\n413,935,-424\n-391,539,-444\n586,-435,557\n-364,-763,-893\n807,-499,-711\n755,-354,-619\n553,889,-390\n\n--- scanner 2 ---\n649,640,665\n682,-795,504\n-784,533,-524\n-644,584,-595\n-588,-843,648\n-30,6,44\n-674,560,763\n500,723,-460\n609,671,-379\n-555,-800,653\n-675,-892,-343\n697,-426,-610\n578,704,681\n493,664,-388\n-671,-858,530\n-667,343,800\n571,-461,-707\n-138,-166,112\n-889,563,-600\n646,-828,498\n640,759,510\n-630,509,768\n-681,-892,-333\n673,-379,-804\n-742,-814,-386\n577,-820,562\n\n--- scanner 3 ---\n-589,542,597\n605,-692,669\n-500,565,-823\n-660,373,557\n-458,-679,-417\n-488,449,543\n-626,468,-788\n338,-750,-386\n528,-832,-391\n562,-778,733\n-938,-730,414\n543,643,-506\n-524,371,-870\n407,773,750\n-104,29,83\n378,-903,-323\n-778,-728,485\n426,699,580\n-438,-605,-362\n-469,-447,-387\n509,732,623\n647,635,-688\n-868,-804,481\n614,-800,639\n595,780,-596\n\n--- scanner 4 ---\n727,592,562\n-293,-554,779\n441,611,-461\n-714,465,-776\n-743,427,-804\n-660,-479,-426\n832,-632,460\n927,-485,-438\n408,393,-506\n466,436,-512\n110,16,151\n-258,-428,682\n-393,719,612\n-211,-452,876\n808,-476,-593\n-575,615,604\n-485,667,467\n-680,325,-822\n-627,-443,-432\n872,-547,-609\n833,512,582\n807,604,487\n839,-516,451\n891,-625,532\n-652,-548,-490\n30,-46,-14"

# Import the data as a list of matrices.
scanners <- read_scanners(textConnection(input))
# scanners <- read_scanners(adventofcode2021::input_file(19))

# Compute pairwise distances among beacons *within* each scanner.
distances <- lapply(scanners, dist)

# How many such distances does each pair of scanners have in common?
similarity <- combn(distances, 2, \(x) Reduce(intersect, x), simplify = F)

# Using this information, which scanners appear to overlap?
overlaps <- lengths(similarity) >= 12 * (12 - 1) / 2

# Just keep those pairs.
similarity <- similarity[overlaps > 0]

# But it helps if we can remember which they are.
pairs <- t(combn(length(scanners), 2)[, overlaps > 0])

# Match up those beacons that two scanners have in common.
match_beacons <- function(s1, s2) {
  m1 <- as.matrix(distances[[s1]])
  m2 <- as.matrix(distances[[s2]])
  matching <- c()
  for (j1 in 1:ncol(m1)) {
    done <- FALSE
    for (j2 in 1:ncol(m2)) {
      if (length(intersect(m1[, j1], m2[, j2])) >= 12) {
        matching <- rbind(matching, cbind(s1 = j1, s2 = j2))
        done <- TRUE
        break
      }
    }
    if (done) next
  }
  matching
}

# For two scanners, how can we orientate the 2nd to match the 1st?
align_scanners <- function(s1, s2) {
  match <- match_beacons(s1, s2)

  # Assert dominance with this ultimate 1000-IQ power move.
  LHS <- scanners[[s1]][match[, 's1'], , drop = F]
  RHS <- scanners[[s2]][match[, 's2'], , drop = F]
  lm_x <- lm(LHS$x ~ x + y + z, RHS)
  lm_y <- lm(LHS$y ~ x + y + z, RHS)
  lm_z <- lm(LHS$z ~ x + y + z, RHS)

  # The predictions gives the beacon coordinates.
  beacon_coords <- as.data.frame(apply(cbind(
    x = predict(lm_x, scanners[[s2]]),
    y = predict(lm_y, scanners[[s2]]),
    z = predict(lm_z, scanners[[s2]])), 2, round))

  # The model intercept is the translation / the scanner position!
  scanner_coords <- apply(cbind(x = coef(lm_x)[1],
                                y = coef(lm_y)[1],
                                z = coef(lm_z)[1]), 2, round)

  # Globally update
  scanners[[s2]] <<- beacon_coords
  beacons <<- unique(rbind(beacons, beacon_coords))
  scanner_locations <<- rbind(scanner_locations, scanner_coords)
}

# Do the search.
found <- 1
to_find <- 2:length(scanners)
scanner_locations <- c(0, 0, 0)
beacons <- scanners[[1]]
while (length(to_find)) {
  overlaps_with_found <- pairs[xor(pairs[, 1] %in% found,
                                   pairs[, 2] %in% found),
                               , drop = F]
  for (i in 1:nrow(overlaps_with_found)) {
    # Let s1 be the already-aligned scanner.
    s1 <- intersect(overlaps_with_found[i, ], found)
    if (length(s1) > 1) next
    s2 <- setdiff(overlaps_with_found[i, ], s1)
    message('Joining ', s1, ' and ', s2)
    align_scanners(s1, s2)
    found <- c(found, s2)
    to_find <- setdiff(to_find, found)
  }
}

# nrow(beacons)
# testthat::expect_equal(nrow(beacons), 79)
# max(dist(scanner_locations, 'manhattan'))
}

