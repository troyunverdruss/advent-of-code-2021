defmodule AOCTest.Day06 do
  use ExUnit.Case

  def input do
    "3,4,3,1,2"
  end

  test "verify model" do
    assert Aoc.Day06.model_fish_growth(input(), 18) == 26
    assert Aoc.Day06.model_fish_growth(input(), 80) == 5934
    assert Aoc.Day06.model_fish_growth(input(), 256) == 26984457539
  end
end