defmodule AOCTest.Day09 do
  use ExUnit.Case

  def input do
    [
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678",
    ]
  end

  @tag timeout: :infinity
  test "part 1" do
    assert Aoc.Day09.part1(input()) == 15
  end

  @tag timeout: :infinity
  test "part 2" do
    assert Aoc.Day09.part2(input()) == 1134
  end
end