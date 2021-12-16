library(adventofcode2021)
input <- to_bits(readLines(input_file(16)))
packet_versions(input)
packet_parse(packet_decode(input), T)
