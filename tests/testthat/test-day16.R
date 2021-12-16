test_that("Day 16", {
  input1 <- to_bits('D2FE28')
  input2 <- to_bits('38006F45291200')
  input3 <- to_bits('EE00D40C823060')
  input4 <- to_bits('8A004A801A8002F478')
  input5 <- to_bits('620080001611562C8802118E34')
  input6 <- to_bits('C0015000016115A2E0802F182340')
  input7 <- to_bits('A0016C880162017C3686B18A3D4780')

  expect_equal(paste(input1, collapse = ''), '110100101111111000101000')
  expect_equal(paste(input2, collapse = ''),
               '00111000000000000110111101000101001010010001001000000000')
  expect_equal(paste(input3, collapse = ''),
               '11101110000000001101010000001100100000100011000001100000')

  expect_equal(packet_versions(input1), 6)
  expect_equal(packet_versions(input4), 16)
  expect_equal(packet_versions(input5), 12)
  expect_equal(packet_versions(input6), 23)
  expect_equal(packet_versions(input7), 31)

  input8 <- to_bits('C200B40A82')
  input9 <- to_bits('04005AC33890')
  input10 <- to_bits('880086C3E88112')
  input11 <- to_bits('CE00C43D881120')
  input12 <- to_bits('D8005AC2A8F0')
  input13 <- to_bits('F600BC2D8F')
  input14 <- to_bits('9C005AC2F8F0')
  input15 <- to_bits('9C0141080250320F1802104A08')

  expect_equal(packet_decode(input8)  |> packet_parse(T), 1 + 2)
  expect_equal(packet_decode(input9)  |> packet_parse(T), 6 * 9)
  expect_equal(packet_decode(input10) |> packet_parse(T), min(c(7, 8, 9)))
  expect_equal(packet_decode(input11) |> packet_parse(T), max(c(7, 8, 9)))
  expect_equal(packet_decode(input12) |> packet_parse(T), 5 < 15)
  expect_equal(packet_decode(input13) |> packet_parse(T), 5 > 15)
  expect_equal(packet_decode(input14) |> packet_parse(T), 5 == 15)
  expect_equal(packet_decode(input15) |> packet_parse() |>
                 str2expression() |> eval(), 1 + 3 == 2 * 2)
})
