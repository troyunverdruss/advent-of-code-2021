require IEx
defmodule Aoc.Day06 do

  def run() do
    [input | _] = Aoc.Utils.read_input_to_strings(6)

    part1 = model_fish_growth(input, 80)
    IO.puts("Part 1: #{part1}")

    part2 = model_fish_growth(input, 256)
    IO.puts("Part 2: #{part2}")
  end

  def model_fish_growth(input, days) do
    fish = Enum.map(String.split(input, ","), fn x -> String.to_integer(x) end)
    fish_by_freq_raw = Enum.frequencies(fish)

    starting_fish = Enum.reduce(
      0..8,
      fish_by_freq_raw,
      fn x, acc ->
        if Map.has_key?(acc, x) do
          acc
        else
          Map.put(acc, x, 0)
        end
      end
    )

    final_fish = Enum.reduce(
      0..days - 1,
      starting_fish,
      fn _day, current_fish ->
        next_fish = %{}
        next_fish = Map.put(next_fish, 0, current_fish[1])
        next_fish = Map.put(next_fish, 1, current_fish[2])
        next_fish = Map.put(next_fish, 2, current_fish[3])
        next_fish = Map.put(next_fish, 3, current_fish[4])
        next_fish = Map.put(next_fish, 4, current_fish[5])
        next_fish = Map.put(next_fish, 5, current_fish[6])
        next_fish = Map.put(next_fish, 6, current_fish[7] + current_fish[0])
        next_fish = Map.put(next_fish, 7, current_fish[8])
        next_fish = Map.put(next_fish, 8, current_fish[0])
        next_fish
      end
    )

    Map.values(final_fish)
    |> Enum.sum()
  end
end


