library(adventofcode2021)
reactor <- read_cubes(input_file(22))
reboot_reactor(reactor, init = TRUE)
reboot_reactor(reactor) |> format(scientific = F)
