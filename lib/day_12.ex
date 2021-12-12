require IEx
defmodule Aoc.Day12 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(12)
    caves = parse_input(input)

    part1 = part1(caves)
    IO.puts("Part 1: #{part1}")
    part2 = part2(caves)
    IO.puts("Part 2: #{part2}")
  end

  def is_large_cave(cave) do
    cave == String.upcase(cave)
  end

  def can_visit(cave, path) do
    !Enum.member?(path, cave) || (Enum.member?(path, cave) && is_large_cave(cave))
  end

  def can_visit_2(cave, path) do
    cond do
      is_large_cave(cave) -> true
      cave == "start" -> false
      cave == "end" -> true
      !has_small_cave_repeat(path) -> true
      has_small_cave_repeat(path) && !Enum.member?(path, cave) -> true
      true -> false
    end
  end

  def has_small_cave_repeat(path) do
    freq = path
           |> Enum.filter(fn x -> !is_large_cave(x) end)
           |> Enum.frequencies()
    Enum.any?(freq, fn {x, y} -> y > 1 end)
  end

  def part1(caves) do
    paths = Enum.flat_map(["start"], fn x -> follow_path(caves, x, ["start"]) end)
    List.flatten(paths)
    |> Enum.sum()
  end

  def part2(caves) do
    paths = Enum.flat_map(["start"], fn x -> follow_path_2(caves, x, ["start"]) end)
    List.flatten(paths)
    |> Enum.sum()
  end

  def follow_path(caves, last_cave, path) do
    next_caves = caves[last_cave]

    Enum.map(
      next_caves,
      fn c ->
        case c do
          "end" -> 1
          _ -> if can_visit(c, path) do
                 follow_path(caves, c, path ++ [c])
               else
                 0
               end
        end
      end
    )
  end

  def follow_path_2(caves, last_cave, path) do
    next_caves = caves[last_cave]

    Enum.map(
      next_caves,
      fn c ->
        case c do
          "end" -> 1
          _ -> if can_visit_2(c, path) do
                 follow_path_2(caves, c, path ++ [c])
               else
                 0
               end
        end
      end
    )
  end

  def parse_input(input) do
    Enum.reduce(
      input,
      %{},
      fn l, acc ->
        [a, b] = String.split(l, "-")
        updated_a = Map.put(acc, a, Map.get(acc, a, []) ++ [b])
        updated_b = Map.put(updated_a, b, Map.get(acc, b, []) ++ [a])
        updated_b
      end
    )
  end
end


