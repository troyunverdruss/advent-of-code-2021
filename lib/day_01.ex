defmodule AOC.Day01 do
  def run() do
    string_data = AOC.Utils.read_input_to_strings(1)
    data_numbers = Enum.map(string_data, fn x -> String.to_integer(x) end)

    part1(data_numbers)
    part2(data_numbers)

  end

  def part1(data_numbers) do
    part1 = data_numbers
            |> Enum.chunk_every(2, 1, :discard)
            |> Enum.count(
                 fn ([a, b | _rest]) ->
                   b > a
                 end
               )
    IO.puts("Part 1: #{part1}")
    part1
  end

  def part2(data_numbers) do
    part2 = data_numbers
            |> Enum.chunk_every(4, 1, :discard)
            |> Enum.count(
                 fn ([a, _b, _c, d | _rest]) ->
                   d > a
                 end
               )
    IO.puts("Part 2: #{part2}")
    part2
  end
end
