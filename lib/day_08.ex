require IEx
defmodule Aoc.Day08 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(8)
    part1 = part1(input)
    IO.puts("Part 1: #{part1}")
    part2 = part2(input)
    IO.puts("Part 2: #{part2}")
  end

  def part1(input) do
    target_lens = MapSet.new([2, 4, 3, 7])

    count = Enum.flat_map(
              input,
              fn x ->
                [left_group | [right_group | _]] = String.split(x, "|")
                String.split(right_group, " ", trim: true)
              end
            )
            |> Enum.filter(fn s -> MapSet.member?(target_lens, String.length(s)) end)
            |> Enum.count()
  end

  def part2(input) do
    Enum.map(
      input,
      fn row ->
        [left_group | [right_group | _]] = String.split(row, "|")
        nums = solve_row(left_group)
        compute_result_number(nums, right_group)
      end
    )
    |> Enum.sum()
  end

  def solve_row(left_group) do

    left = String.split(left_group, " ", trim: true)

    left_sets = Enum.map(left, fn s -> String.split(s, "", trim: true) end)
                |> Enum.map(fn x -> MapSet.new(x) end)
    left_sets = MapSet.new(left_sets)

    [n1 | _] = left_sets
               |> Enum.filter(fn x -> MapSet.size(x) == 2 end)
    left_sets = MapSet.delete(left_sets, n1)
    [n4 | _] = left_sets
               |> Enum.filter(fn x -> MapSet.size(x) == 4 end)
    left_sets = MapSet.delete(left_sets, n4)
    [n7 | _] = left_sets
               |> Enum.filter(fn x -> MapSet.size(x) == 3 end)
    left_sets = MapSet.delete(left_sets, n7)
    [n8 | _] = left_sets
               |> Enum.filter(fn x -> MapSet.size(x) == 7 end)
    left_sets = MapSet.delete(left_sets, n8)
    [n3 | _] = left_sets
               |> Enum.filter(fn x -> MapSet.size(x) == 5 && Enum.all?(n7, fn y -> MapSet.member?(x, y) end) end)
    left_sets = MapSet.delete(left_sets, n3)

    {n2, n5} = match_n2_and_n5(left_sets, n4)
    left_sets = MapSet.delete(left_sets, n2)
    left_sets = MapSet.delete(left_sets, n5)

    n9 = match_n9(left_sets, n4)
    left_sets = MapSet.delete(left_sets, n9)

    {n0, n6} = match_n0_and_n6(left_sets, n5)
    left_sets = MapSet.delete(left_sets, n0)
    left_sets = MapSet.delete(left_sets, n6)

    [n0, n1, n2, n3, n4, n5, n6, n7, n8, n9]
  end

  def compute_result_number(numbers, right_group) do

    lookup = Enum.with_index(numbers)
             |> Enum.map(fn {n_set, n} -> {n_set, n} end)
             |> Map.new()
    right = String.split(right_group, " ", trim: true)

    right_sets = Enum.map(right, fn s -> String.split(s, "", trim: true) end)
                 |> Enum.map(fn x -> MapSet.new(x) end)


    number_string = Enum.map(right_sets, fn rs -> lookup[rs] end)
                    |> Enum.map(fn d -> Integer.to_string(d) end)
                    |> Enum.join()
    String.to_integer(number_string)
  end

  def match_n2_and_n5(remaining_options, n4) do
    [a, b] = remaining_options
             |> Enum.filter(fn x -> MapSet.size(x) == 5 end)
    if MapSet.size(MapSet.difference(a, n4)) == 3 do
      {a, b}
    else
      {b, a}
    end
  end

  def match_n9(remaining_options, n4) do
    [n9 | _] = remaining_options
               |> Enum.filter(fn opt -> MapSet.size(MapSet.difference(opt, n4)) == 2 end)
    n9
  end

  def match_n0_and_n6(remaining_options, n5) do
    [a, b] = MapSet.to_list(remaining_options)

    if MapSet.size(MapSet.difference(a, n5)) == 2 do
      {a, b}
    else
      {b, a}
    end
  end

end


