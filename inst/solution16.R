library(adventofcode2021)
input <- to_bits(readLines(input_file(16)))
packet_versions(input)
eval(str2expression(packet_parse(packet_decode(input))))
