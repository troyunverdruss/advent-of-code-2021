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
    end
  end
end