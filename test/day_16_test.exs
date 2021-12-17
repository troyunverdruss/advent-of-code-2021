require IEx
defmodule AOCTest.Day16 do
  use ExUnit.Case

  def input do
    [
      "1163751742",
      "1381373672",
      "2136511328",
      "3694931569",
      "7463417111",
      "1319128137",
      "1359912421",
      "3125421639",
      "1293138521",
      "2311944581",
    ]
  end

  def tiny_input do
    [
      "12",
      "15"
    ]
  end

  def tiniest_input do
    ["8"]
  end

#  @tag timeout: :infinity
#  test "part 1 parse handle type 4 literal" do
#    {value, remaining_bits} = Aoc.Day16.handle_type_4_literal("110100101111111000101000")
#    assert value == 2021
#    assert remaining_bits == "000"
#  end
#
#  @tag timeout: :infinity
#  test "part 1 parse type 4 literal from the top" do
#    {packet, remaining_bits} = Aoc.Day16.parse_packet("110100101111111000101000", 0, 0)
#    assert packet.version == 6
#    assert packet.type_id == 4
#    assert packet.literal_value == 2021
#    assert packet.subpackets == []
#  end
#
#  @tag timeout: :infinity
#  test "part 1 parse handle operator" do
#    {packets, remaining_bits} = Aoc.Day16.handle_operator_payload(
#      "00111000000000000110111101000101001010010001001000000000"
#    )
#    [packet1, packet2] = packets
#
#    assert packet1.version == 6
#    assert packet1.type_id == 4
#    assert packet1.literal_value == 10
#
#    assert packet2.version == 2
#    assert packet2.type_id == 4
#    assert packet2.literal_value == 20
#  end
#
#  @tag timeout: :infinity
#  test "part 1 parse operator from the top" do
#    {packet, remaining_bits} = Aoc.Day16.parse_packet("00111000000000000110111101000101001010010001001000000000", 0, 0)
#    assert packet.version == 1
#    assert packet.type_id == 6
#    assert packet.literal_value == nil
#    assert Enum.count(packet.subpackets) == 2
#  end
#
#  @tag timeout: :infinity
#  test "part 1 parse operator from the top 2" do
#    {packet, remaining_bits} = Aoc.Day16.parse_packet("11101110000000001101010000001100100000100011000001100000", 0, 0)
#    assert packet.version == 7
#    assert packet.type_id == 3
#    assert packet.literal_value == nil
#    assert Enum.count(packet.subpackets) == 3
#
#    [packet1, packet2, packet3] = packet.subpackets
#    assert packet1.version == 2
#    assert packet1.type_id == 4
#    assert packet1.literal_value == 1
#
#    assert packet2.version == 4
#    assert packet2.type_id == 4
#    assert packet2.literal_value == 2
#
#
#    assert packet3.version == 1
#    assert packet3.type_id == 4
#    assert packet3.literal_value == 3
#  end
#
#  @tag timeout: :infinity
#  test "part 1 compute version sum 1" do
#    binary = Aoc.Day16.parse_input("8A004A801A8002F478")
#    {packet, remaining_bits} = Aoc.Day16.parse_packet(binary, 0, 0)
#    assert Aoc.Day16.compute_version_sum(packet) == 16
#  end

  @tag timeout: :infinity
  test "part 1 compute version sum 2" do
    binary = Aoc.Day16.parse_input("620080001611562C8802118E34")
    {packet, remaining_bits} = Aoc.Day16.parse_packet(binary, 0, 0)
    IEx.pry()
    assert Aoc.Day16.compute_version_sum(packet) == 12
  end

#  @tag timeout: :infinity
#  test "part 1 compute version sum 3" do
#    binary = Aoc.Day16.parse_input("C0015000016115A2E0802F182340")
#    {packet, remaining_bits} = Aoc.Day16.parse_packet(binary, 0, 0)
#    IEx.pry()
#    assert Aoc.Day16.compute_version_sum(packet) == 23
#  end

#  @tag timeout: :infinity
#  test "part 1 compute version sum 4" do
#    binary = Aoc.Day16.parse_input("A0016C880162017C3686B18A3D4780")
#    {packet, remaining_bits} = Aoc.Day16.parse_packet(binary, 0, 0)
#    assert Aoc.Day16.compute_version_sum(packet) == 31
#  end















  #  @tag timeout: :infinity
  #  test "part 1 real input" do
  #    grid = Aoc.Day16.parse_input(input())
  #    assert Aoc.Day16.part1(grid) == 40
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2 expand_grid" do
  #    grid = Aoc.Day16.parse_input(tiniest_input())
  #    new_grid = Aoc.Day16.expand_grid(grid)
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2 with expanded input" do
  #    grid = Aoc.Day16.parse_input(input())
  #    expanded_grid = Aoc.Day16.expand_grid(grid)
  #    assert Aoc.Day16.part1(expanded_grid) == 315
  #  end
  #


end