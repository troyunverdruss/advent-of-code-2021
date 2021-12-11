require IEx
defmodule Aoc.Day11 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(11)
    grid = parse_input(input)

    part1 = part1(grid, 100)
    IO.puts("Part 1: #{part1}")

    part2 = part2(grid)
    IO.puts("Part 2: #{part2}")
  end

  def part1(grid, steps) do
    result = Enum.reduce(
      0..steps - 1,
      {grid, 0},
      fn _step, {new_grid, flashed} ->
        {new_grid, new_flashed} = step(new_grid)
        {new_grid, flashed + new_flashed}
      end
    )
    elem(result, 1)
  end

  def part2(grid) do
    total = Enum.count(grid)
    try do
      Enum.reduce(
        1..1000,
        grid,
        fn step, new_grid ->
          {new_grid, new_flashed} = step(new_grid)
          if new_flashed == total do
            throw step
          end
          new_grid
        end
      )
      raise "no sync step"
    catch
      x -> x
    end
  end

  def parse_input(input) do
    x_count = String.length(Enum.at(input, 0))
    y_count = Enum.count(input)
    points = Enum.flat_map(
      0..y_count - 1,
      fn y ->
        Enum.map(
          0..x_count - 1,
          fn x ->
            {{x, y}, String.to_integer(String.at(Enum.at(input, y), x))}
          end
        )
      end
    )
    Map.new(points)
  end

  def step(grid) do
    grid_after_all_updated = Enum.map(grid, fn {k, v} -> {k, v + 1} end)
                             |> Map.new()

    grid_after_processing_flashing = process_flashing(grid_after_all_updated)
    flashed = Enum.count(grid_after_processing_flashing, fn {_, v} -> v == 0 end)
    {grid_after_processing_flashing, flashed}
  end

  def process_flashing(grid) do
    flasher_coords = Enum.filter(grid, fn {_, v} -> v > 9 end)
                     |> Enum.map(fn x -> elem(x, 0) end)
    grid_with_flashers_reset = Enum.reduce(
      flasher_coords,
      grid,
      fn n, acc ->
        Map.replace!(acc, n, 0)
      end
    )

    coords_to_update = Enum.flat_map(flasher_coords, fn c -> neighbors(c) end)
                       |> Enum.filter(
                            fn n -> grid_with_flashers_reset[n] != nil && grid_with_flashers_reset[n] != 0 end
                          )
    updated_grid = Enum.reduce(
      coords_to_update,
      grid_with_flashers_reset,
      fn n, acc ->
        Map.replace!(acc, n, acc[n] + 1)
      end
    )

    if Enum.any?(updated_grid, fn {_, v} -> v > 9 end) do
      process_flashing(updated_grid)
    else
      updated_grid
    end
  end

  def neighbors(coord) do
    {x,y} = coord
    [
      {x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1},
      {x - 1, y    },             {x + 1, y    },
      {x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}
    ]
  end
end


