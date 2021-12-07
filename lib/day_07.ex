require IEx
defmodule Aoc.Day07 do

  def run() do
    [input | _] = Aoc.Utils.read_input_to_strings(7)
    initial_positions = Enum.map(String.split(input, ","), fn x -> String.to_integer(x) end)

    min = Enum.min(initial_positions)
    max = Enum.max(initial_positions)

    fuel_options = Enum.map(min..max,fn pos ->
      Enum.map(initial_positions, fn init ->
        abs(init-pos)
      end) |> Enum.sum()
    end)

    part1 = Enum.min(fuel_options)

    fuel_options_2 = Enum.map(min..max,fn pos ->
      Enum.map(initial_positions, fn init ->
        dist = abs(init-pos)
        cost_to_dist(dist)
      end) |> Enum.sum()
    end)

    part2 = Enum.min(fuel_options_2)

    IEx.pry()
    IO.puts("Part 1: #{part1}")
    IO.puts("Part 2: #{part2}")
  end

  def cost_to_dist(dist) do
    if dist == 0 do
      0
      else
    Enum.reduce(
      1..dist,
      0,
      fn step, acc ->
        acc + step
      end)
    end
  end
end


