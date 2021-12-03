defmodule AOCTest.Day03 do
  use ExUnit.Case

  def input do
    [
    ]
  end


  test "verify part 1" do
    steps = AOC.Day03.compute_steps(input())
    assert AOC.Day03.part1(steps) == 150
  end

  test "verify part 2" do
    steps = AOC.Day03.compute_steps(input())
    assert AOC.Day03.part2(steps) == 900
  end
end