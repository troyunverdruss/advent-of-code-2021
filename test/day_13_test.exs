require IEx
defmodule AOCTest.Day13 do
  use ExUnit.Case

  def dots do
      "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0"
  end

  def folds do
      "fold along y=7
fold along x=5"
  end

  @tag timeout: :infinity
  test "part 1 one fold" do
    dots = Aoc.Day13.parse_dots(dots())
    folds = Aoc.Day13.parse_folds(folds())
    grid = Aoc.Day13.build_grid(dots)

    after_y = Aoc.Day13.fold_along_y(grid, elem(Enum.at(folds, 0), 1))
    assert after_y |> Enum.count() == 17

    after_x = Aoc.Day13.fold_along_x(after_y, elem(Enum.at(folds, 1), 1))
    assert after_x |> Enum.count() == 16
  end

  #
  #  @tag timeout: :infinity
  #  test "part 1 medium" do
  #    caves = Aoc.Day12.parse_input(medium())
  #
  #    assert Aoc.Day12.part1(caves) == 19
  #  end
  #  @tag timeout: :infinity
  #
  #  test "part 1 large" do
  #    caves = Aoc.Day12.parse_input(large())
  #
  #    assert Aoc.Day12.part1(caves) == 226
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2 small" do
  #    caves = Aoc.Day12.parse_input(small())
  #
  #    assert Aoc.Day12.part2(caves) == 36
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2 medium" do
  #    caves = Aoc.Day12.parse_input(medium())
  #
  #    assert Aoc.Day12.part2(caves) == 103
  #  end
  #
  #  @tag timeout: :infinity
  #  test "part 2 large" do
  #    caves = Aoc.Day12.parse_input(large())
  #
  #    assert Aoc.Day12.part2(caves) == 3509
  #  end
end