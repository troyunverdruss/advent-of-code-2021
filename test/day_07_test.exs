defmodule AOCTest.Day07 do
  use ExUnit.Case

  def input do
    "16,1,2,0,4,2,7,1,2,14"
  end

  test "compute distance cost" do
    assert Aoc.Day07.cost_to_dist(abs(16-5)) == 66
    assert Aoc.Day07.cost_to_dist(abs(1-5)) == 10
  end

  test "compute distance cost when 0" do
    assert Aoc.Day07.cost_to_dist(abs(2-2)) == 0
  end

  test "part 1" do
    assert Aoc.Day07.part1(input()) == 37
  end

  test "part 2" do
    assert Aoc.Day07.part2(input()) == 168
  end

  test "part  2 fuel compute" do
    initial_positions = Enum.map(String.split(input(), ","), fn x -> String.to_integer(x) end)

    fuel_options_2 = Enum.map([2],fn pos ->
      Enum.map(initial_positions, fn init ->
#        IO.puts "from #{init} to #{pos}"
        dist = abs(init-pos)
        ans = Aoc.Day07.cost_to_dist(dist)
#        IO.puts "cost: #{ans}"
        ans
      end) |> Enum.sum()
    end)

#    IO.inspect fuel_options_2

    assert Enum.min(fuel_options_2) == 206
  end

end