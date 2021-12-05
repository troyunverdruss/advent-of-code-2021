defmodule AOCTest.Day02 do
  use ExUnit.Case

  def input do
    [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ]
  end


  test "verify part 1" do
    steps = Aoc.Day02.compute_steps(input())
    assert Aoc.Day02.part1(steps) == 150
  end

  test "verify part 2" do
    steps = Aoc.Day02.compute_steps(input())
    assert Aoc.Day02.part2(steps) == 900
  end
end