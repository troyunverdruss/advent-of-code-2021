defmodule AOCTest.Day08 do
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

  #  @tag timeout: :infinity
  #  test "part 1" do
  #    parsed_input = String.split(input(), "\n")
  #                   |> Enum.filter(fn x -> String.length(x) > 0 end)
  #    assert Aoc.Day08.part1(parsed_input) == 26
  #  end

  @tag timeout: :infinity
  test "part 2" do

    grid = Aoc.Day09.parse_input(input())
    low_points = Aoc.Day09.filter_for_low_points(grid)
                 |> Enum.filter(fn x -> x != nil end)
    require IEx
#    basin  = Aoc.Day09.find_basin(grid, {1,0}, visited_agent, 0)
#    assert basin == 3

    {:ok, visited_agent} = Agent.start_link fn -> MapSet.new() end
    basins = Enum.map(low_points, fn p -> Aoc.Day09.find_basin(grid, p, visited_agent, 0) end)
    Agent.stop(visited_agent)
    require IEx
    IEx.pry()
    sizes = basins |> Enum.sort() |> Enum.reverse() |> Enum.take(3) |> Enum.product()
    assert sizes == 1134
  end
end