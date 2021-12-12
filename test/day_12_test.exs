defmodule AOCTest.Day12 do
  use ExUnit.Case

  def small do
    [
      "start-A",
      "start-b",
      "A-c",
      "A-b",
      "b-d",
      "A-end",
      "b-end",
    ]
  end

  def medium do
    [
      "dc-end",
      "HN-start",
      "start-kj",
      "dc-start",
      "dc-HN",
      "LN-dc",
      "HN-end",
      "kj-sa",
      "kj-HN",
      "kj-dc",
    ]
  end

  def large do
    [
      "fs-end",
      "he-DX",
      "fs-he",
      "start-DX",
      "pj-DX",
      "end-zg",
      "zg-sl",
      "zg-pj",
      "pj-he",
      "RW-he",
      "fs-DX",
      "pj-RW",
      "zg-RW",
      "start-pj",
      "he-WI",
      "zg-he",
      "pj-fs",
      "start-RW",
    ]
  end

  @tag timeout: :infinity
  test "part 1 small" do
    caves = Aoc.Day12.parse_input(small())

    assert Aoc.Day12.part1(caves) == 10
  end

  @tag timeout: :infinity
  test "part 1 medium" do
    caves = Aoc.Day12.parse_input(medium())

    assert Aoc.Day12.part1(caves) == 19
  end
  @tag timeout: :infinity

  test "part 1 large" do
    caves = Aoc.Day12.parse_input(large())

    assert Aoc.Day12.part1(caves) == 226
  end

  @tag timeout: :infinity
  test "part 2 small" do
    caves = Aoc.Day12.parse_input(small())

    assert Aoc.Day12.part2(caves) == 36
  end

  @tag timeout: :infinity
  test "part 2 medium" do
    caves = Aoc.Day12.parse_input(medium())

    assert Aoc.Day12.part2(caves) == 103
  end

  @tag timeout: :infinity
  test "part 2 large" do
    caves = Aoc.Day12.parse_input(large())

    assert Aoc.Day12.part2(caves) == 3509
  end



  #  @tag timeout: :infinity
  #  test "part 1 mini flashing" do
  #    grid = Aoc.Day11.parse_input(mini_flashing())
  #
  #    flashed = Aoc.Day11.part1(grid, 2)
  #
  #    assert flashed == 1
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 1" do
  #    grid = Aoc.Day11.parse_input(input())
  #
  #    flashed = Aoc.Day11.part1(grid, 10)
  #
  #    assert flashed == 204
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2" do
  #    grid = Aoc.Day11.parse_input(input())
  #
  #    step = Aoc.Day11.part2(grid)
  #
  #    assert step == 195
  #  end
end