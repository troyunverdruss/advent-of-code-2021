require IEx
defmodule AOCTest.Day15 do
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

  @tag timeout: :infinity
  test "part 1 tiny input" do
    grid = Aoc.Day15.parse_input(tiny_input())
    assert Aoc.Day15.part1(grid) == 6
  end

  @tag timeout: :infinity
  test "part 1 real input" do
    grid = Aoc.Day15.parse_input(input())
    assert Aoc.Day15.part1(grid) == 40
  end

  @tag timeout: :infinity
  test "part 2 expand_grid" do
    grid = Aoc.Day15.parse_input(tiniest_input())
    new_grid = Aoc.Day15.expand_grid(grid)
  end

  @tag timeout: :infinity
  test "part 2 with expanded input" do
    grid = Aoc.Day15.parse_input(input())
    expanded_grid = Aoc.Day15.expand_grid(grid)
    assert Aoc.Day15.part1(expanded_grid) == 315
  end



end