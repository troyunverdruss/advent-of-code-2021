require IEx
defmodule Aoc.Day09 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(9)

    part1 =part1(input)
    IO.puts("Part 1: #{part1}")
    part2 = part2(input)
    IO.puts("Part 2: #{part2}")
  end

  def part1(input) do
    grid = parse_input(input)
    low_point_vals = filter_for_low_point_vals(grid) |> Enum.filter(fn x -> x != nil end)
    low_point_vals  |> Enum.map(fn x -> x+1 end) |> Enum.sum()
  end

  def part2(input) do
    grid = parse_input(input)
    low_points = filter_for_low_points(grid) |> Enum.filter(fn x -> x != nil end)

    {:ok, visited_agent} = Agent.start_link fn -> MapSet.new() end
    basins = Enum.map(low_points, fn p -> find_basin(grid, p, visited_agent, 0) end)
    Agent.stop(visited_agent)

    basins |> Enum.sort() |> Enum.reverse() |> Enum.take(3) |> Enum.product()
  end

  def parse_input(input) do
    x_count = String.length(Enum.at(input, 0))
    y_count = Enum.count(input)
    points = Enum.flat_map(0..y_count-1, fn y ->
      Enum.map(0..x_count-1, fn x ->
        {{x,y}, String.to_integer(String.at(Enum.at(input, y), x))}
      end)
    end)
    Map.new(points)
  end

  def neighbors(coord) do
    {x,y} = coord
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
  end

  def filter_for_low_point_vals(grid) do
    Enum.map(grid, fn {{x,y}, val} ->
      neighbor_vals = Enum.map(neighbors({x,y}), fn n -> grid[n] end) |> Enum.filter(fn v -> v != nil end)
      if Enum.all?(neighbor_vals, fn v -> v>val end) do
        val
      else
        nil
      end
    end)
  end

  def filter_for_low_points(grid) do
    Enum.map(grid, fn {{x,y}, val} ->
      neighbor_vals = Enum.map(neighbors({x,y}), fn n -> grid[n] end) |> Enum.filter(fn v -> v != nil end)
      if Enum.all?(neighbor_vals, fn v -> v>val end) do
        {x,y}
      else
        nil
      end
    end)
  end

  def find_basin(grid, coord, visited_agent, depth) do
    visited = Agent.get(visited_agent, fn x -> x end)
    neighbors = neighbors(coord) |> Enum.filter(fn n -> !MapSet.member?(visited, n) end)

    neighbors = if MapSet.member?(visited, coord) do
      neighbors
    else
      neighbors ++ [coord]
    end

    Agent.update(visited_agent, fn v -> MapSet.union(v, MapSet.new(neighbors)) end)
    neighbors = Enum.filter(neighbors, fn n -> grid[n] != nil && grid[n] != 9 end)

    if Enum.count(neighbors) == 0 do
      0
    else
      curr_count = Enum.count(neighbors)
      next_count = Enum.map(neighbors, fn n -> find_basin(grid, n, visited_agent, depth + 1) end) |> Enum.sum()
      curr_count + next_count
    end
  end
end


