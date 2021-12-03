defmodule AOC.Day03 do
  def run() do
    string_data = AOC.Utils.read_input_to_strings(3)

    part1 = part1(string_data)
    IO.puts "Part 1: #{part1}"
    part2 = part2(string_data)
    IO.puts "Part 2: #{part2}"
  end

  def most_common_at_pos(input, position) do
    input
    |> Enum.map(fn x -> String.at(x, position) end)
    |> Enum.frequencies()
    |> Enum.max_by(fn x -> elem(x, 1) end)
    |> elem(0)
  end

  def min_common_at_pos(input, position) do
    input
    |> Enum.map(fn x -> String.at(x, position) end)
    |> Enum.frequencies()
    |> Enum.min_by(fn x -> elem(x, 1) end)
    |> elem(0)
  end

  def freq_at_pos(input, position) do
    input
    |> Enum.map(fn x -> String.at(x, position) end)
    |> Enum.frequencies()
  end

  def filter_input_for_most_common_at_pos(input, position) do
    freq = freq_at_pos(input, position)

    target = if freq["0"] == freq["1"] do
      "1"
    else
      Enum.max_by(freq, fn x -> elem(x, 1) end)
      |> elem(0)
    end

    input
    |> Enum.filter(fn x -> String.at(x, position) == target end)
  end

  def filter_input_for_least_common_at_pos(input, position) do
    freq = freq_at_pos(input, position)

    target = if freq["0"] == freq["1"] do
      "0"
    else
      Enum.min_by(freq, fn x -> elem(x, 1) end)
      |> elem(0)
    end

    input
    |> Enum.filter(fn x -> String.at(x, position) == target end)
  end

  def part1(string_data) do
    input_length = String.length(Enum.at(string_data, 0))
    binary_gamma = Enum.map(
                     0..(input_length-1),
                     fn (pos) ->
                       most_common_at_pos(string_data, pos)
                     end
                   )
                   |> Enum.join()

    {gamma, _} = Integer.parse(binary_gamma, 2)

    binary_epsilon = Enum.map(
                       0..(input_length-1),
                       fn (pos) ->
                         min_common_at_pos(string_data, pos)
                       end
                     )
                     |> Enum.join()

    {epsilon, _} = Integer.parse(binary_epsilon, 2)

    gamma * epsilon
  end

  def part2(string_data) do
    input_length = String.length(Enum.at(string_data, 0))

    [binary_o2_rating| _] = Enum.reduce(
      0..(input_length-1),
      string_data,
      fn (pos, acc) ->
        filter_input_for_most_common_at_pos(acc, pos)
      end
    )

    {o2_rating, _} = Integer.parse(binary_o2_rating, 2)

    [binary_co2_rating| _] = Enum.reduce(
      0..(input_length-1),
      string_data,
      fn (pos, acc) ->
        filter_input_for_least_common_at_pos(acc, pos)
      end
    )

    {co2_rating, _} = Integer.parse(binary_co2_rating, 2)

    o2_rating * co2_rating
  end
end
