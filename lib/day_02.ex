defmodule Aoc.Day02 do
  def run() do
    string_data = Aoc.Utils.read_input_to_strings(2)

    steps = compute_steps(string_data)

    part1(steps)
    part2(steps)
  end

  def compute_steps(string_data) do
    string_data
    |> Enum.map(
         fn line ->
           case line do
             "forward " <> forward -> {String.to_integer(forward), 0}
             "down " <> down -> {0, String.to_integer(down)}
             "up " <> up -> {0, -String.to_integer(up)}
           end
         end
       )
  end

  def part1(steps) do
    distance = steps
               |> Enum.map(fn x -> elem(x, 0) end)
               |> Enum.sum()
    depth = steps
            |> Enum.map(fn x -> elem(x, 1) end)
            |> Enum.sum()

    part1_result = distance * depth
    IO.puts("Part 1: #{part1_result}")
    part1_result
  end

  def part2(steps) do
    part2_values = steps
                   |> Enum.reduce(
                        %{aim: 0, distance: 0, depth: 0},
                        fn (x, acc) -> part2_reducer(x, acc) end
                      )

    part2_result = part2_values[:depth] * part2_values[:distance]
    IO.puts("Part 2: #{part2_result}")
    part2_result
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
