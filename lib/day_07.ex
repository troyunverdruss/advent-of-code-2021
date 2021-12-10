require IEx
defmodule Aoc.Day07 do

  def run() do
    [input | _] = Aoc.Utils.read_input_to_strings(7)

    part1 = part1(input)
    IO.puts("Part 1: #{part1}")

    part2 = part2(input)
    IO.puts("Part 2: #{part2}")
  end

  def part1(input) do
    initial_positions = Enum.map(String.split(input, ","), fn x -> String.to_integer(x) end)
    min = Enum.min(initial_positions)
    max = Enum.max(initial_positions)

    fuel_options = Enum.map(min..max,fn pos ->
      Enum.map(initial_positions, fn init ->
        abs(init-pos)
      end) |> Enum.sum()
    end)

    Enum.min(fuel_options)
  end

  def part2(input) do
    initial_positions = Enum.map(String.split(input, ","), fn x -> String.to_integer(x) end)
    min = Enum.min(initial_positions)
    max = Enum.max(initial_positions)
    fuel_options = Enum.map(min..max,fn pos ->
      Enum.map(initial_positions, fn init ->
        cost_to_dist(abs(init-pos))
      end) |> Enum.sum()
    end)

    Enum.min(fuel_options)
  end

  def cost_to_dist(dist) do
    div(dist * (dist + 1), 2)
  end
end


