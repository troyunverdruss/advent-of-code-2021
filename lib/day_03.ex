defmodule AOC.Day03 do
  def run() do
    string_data = AOC.Utils.read_input_to_strings(2)

    steps = string_data
            |> Enum.map(
                 fn line ->
                   case line do
                     "forward " <> forward -> {String.to_integer(forward), 0}
                     "down " <> down -> {0, String.to_integer(down)}
                     "up " <> up -> {0, -String.to_integer(up)}
                   end
                 end
               )

    distance = steps
               |> Enum.map(fn x -> elem(x, 0) end)
               |> Enum.sum()
    depth = steps
            |> Enum.map(fn x -> elem(x, 1) end)
            |> Enum.sum()

    IO.puts("Part 1: #{distance * depth}")

    part2_values = steps
                   |> Enum.reduce(
                        %{aim: 0, distance: 0, depth: 0},
                        fn (x, acc) -> part2_reducer(x, acc) end
                      )


    IO.puts("Part 2: #{part2_values[:depth] * part2_values[:distance]}")
  end

  def part1() do

  end

  def part2() do

  end

  defp part2_reducer(x, acc) do
    {distance, aim} = x
    if distance > 0 do
      %{acc | distance: acc[:distance] + distance, depth: acc[:depth] + (distance * acc[:aim])}
    else
      %{acc | aim: acc[:aim] + aim}
    end
  end
end
