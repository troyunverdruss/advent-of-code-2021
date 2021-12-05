defmodule AOCTest.Day04 do
  use ExUnit.Case

  def input do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end


#  test "verify part 1" do
#    segments = Aoc.Day05.parse_segments(String.split(input(), "\n", trim: true))
#    map = Aoc.Day05.populate_map(segments)
#
#    require IEx
##    IEx.pry()
#
##    assert Aoc.Day04.part1(called_numbers, boards) == 4512
#  end

  @tag timeout: :infinity
  test "verify part 2" do
        segments = Aoc.Day05.parse_segments(String.split(input(), "\n", trim: true))
        diag = Aoc.Day05.populate_diag_map(segments)

        require IEx
    #    IEx.pry()

    #    assert Aoc.Day04.part1(called_numbers, boards) == 4512

  end
end