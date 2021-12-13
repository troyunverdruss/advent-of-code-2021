defmodule Mix.Tasks.Day do
  use Mix.Task

  def run([day]) do
    case day do
      "1" -> Aoc.Day01.run()
      "2" -> Aoc.Day02.run()
      "3" -> Aoc.Day03.run()
      "4" -> Aoc.Day04.run()
      "5" -> Aoc.Day05.run()
      "6" -> Aoc.Day06.run()
      "7" -> Aoc.Day07.run()
      "8" -> Aoc.Day08.run()
      "9" -> Aoc.Day09.run()
      "10" -> Aoc.Day10.run()
      "11" -> Aoc.Day11.run()
      "12" -> Aoc.Day12.run()
      "13" -> Aoc.Day13.run()
    end
  end
end