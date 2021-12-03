defmodule AOCTest.Day03 do
  use ExUnit.Case

  def input do
    [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010",
    ]
  end


    test "verify part 1" do
      assert AOC.Day03.part1(input()) == 198
    end

  test "verify part 2" do
    assert AOC.Day03.part2(input()) == 230
  end
end