defmodule AOCTest.Day01 do
  use ExUnit.Case

  def input do
    [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ]
  end


  test "verify part 1" do
    assert AOC.Day01.part1(input()) == 7
  end

  test "verify part 2" do
    assert AOC.Day01.part2(input()) == 5
  end
end