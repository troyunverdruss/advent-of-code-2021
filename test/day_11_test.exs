defmodule AOCTest.Day11 do
  use ExUnit.Case

  def input do
    [
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526",
    ]
  end

  def sample_flashing() do
    [
    "11111",
    "19991",
    "19191",
    "19991",
    "11111",
    ]
  end

  def mini_flashing() do
    [
    "11",
    "19",
    ]
  end

  @tag timeout: :infinity
  test "part 1 sample flashing" do
    grid = Aoc.Day11.parse_input(sample_flashing())

    {_, flashed} = Aoc.Day11.step(grid)

    assert flashed == 9
  end

  @tag timeout: :infinity
  test "part 1 mini flashing" do
    grid = Aoc.Day11.parse_input(mini_flashing())

    flashed = Aoc.Day11.part1(grid, 2)

    assert flashed == 1
  end

  @tag timeout: :infinity
  test "part 1" do
    grid = Aoc.Day11.parse_input(input())

    flashed = Aoc.Day11.part1(grid, 10)

    assert flashed == 204
  end

  @tag timeout: :infinity
  test "part 2" do
    grid = Aoc.Day11.parse_input(input())

    step = Aoc.Day11.part2(grid)

    assert step == 195
  end
end