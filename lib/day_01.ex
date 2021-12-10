defmodule Aoc.Day01 do
  def run() do
    string_data = Aoc.Utils.read_input_to_strings(1)
    data_numbers = Enum.map(string_data, fn x -> String.to_integer(x) end)

    part1 = part1(data_numbers)
    IO.puts("Part 1: #{part1}")
    part2 = part2(data_numbers)
    IO.puts("Part 2: #{part2}")

  end

  def part1(data_numbers) do
    data_numbers
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(
         fn ([a, b | _rest]) ->
           b > a
         end
       )
  end

  def part2(data_numbers) do
    data_numbers
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.count(
         fn ([a, _b, _c, d | _rest]) ->
           d > a
         end
       )
  end
end
