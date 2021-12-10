require IEx
defmodule Aoc.Day10 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(10)
    part1 = part1(input)
    IO.puts("Part 1: #{part1}")
    part2 = part2(input)
    IO.puts("Part 2: #{part2}")
  end

  def part1(input) do
    scores = %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
    results = Enum.map(input, fn l -> check_line(l) end)
    results |> Enum.filter(fn r -> r[:error] != nil end) |> Enum.map(fn r -> scores[r[:error]] end) |> Enum.sum()
  end

  def part2(input) do
    incomplete_line_results = Enum.map(input, fn l -> check_line(l) end) |> Enum.filter(fn r -> r[:error] == nil end)
    scores = Enum.map(incomplete_line_results, fn r -> compute_score(r[:opened]) end)
    scores |> Enum.sort |> Enum.at(div(Enum.count(scores), 2))
  end

  def compute_score(opened) do
    scores = %{"(" => 1, "[" => 2, "{" => 3, "<" => 4}
    Enum.reduce(opened, 0, fn c, acc ->
      (acc * 5) + scores[c]
    end)
  end

  def check_line(line) do
    openers = MapSet.new(["(", "[", "{", "<"])
    pairs = %{"(" => ")", "[" => "]", "{" => "}", "<" => ">"}

    characters = String.split(line, "", trim: true)

    Enum.reduce(
      characters,
      %{opened: [], error: nil},
      fn c, acc ->
        if acc[:error] == nil do
          if MapSet.member?(openers, c) do
            %{acc | opened: List.insert_at(acc[:opened], 0, c)}
          else
            head = List.first(acc[:opened])
            if pairs[head] == c do
              %{acc | opened: List.delete_at(acc[:opened], 0)}
            else
              %{acc | error: c}
            end
          end
        else
          acc
        end
      end
    )
  end
end


