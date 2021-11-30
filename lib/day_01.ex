defmodule AOC.Day01 do
  def part1() do
    string_data = File.read!("input/day01.txt") |> String.split("\n", trim: true)
    data_numbers = Enum.map(string_data, fn x -> String.to_integer(x) end)
    sum = Enum.at(data_numbers, 0) + Enum.at(data_numbers, 1)
    IO.puts sum
  end
end