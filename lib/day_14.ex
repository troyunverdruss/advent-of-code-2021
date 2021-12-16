require IEx
defmodule Aoc.Day14 do

  def run() do
    [input, rules] = Aoc.Utils.read_input_to_strings_with_delim("input/day14.txt", "\n\n")

    chars = parse_chars(input)
    rules = parse_rules(rules)

    part1 = part1(chars, rules)
    IO.puts("Part 1: #{part1}")

    part2 = part2(chars, rules, 40)
    IO.puts("Part 2: #{part2}")
  end

  def parse_chars(input) do
    String.split(input, "", trim: true)
  end

  def parse_rules(rules) do
    Enum.map(
      String.split(rules, "\n", trim: true),
      fn line ->
        [k, v] = String.split(line, " -> ", trim: true)
        {k, v}
      end
    )
    |> Map.new()
  end

  # Slow but calculates the actual string
  def part1(chars, rules) do
    final = Enum.reduce(
      0..9,
      chars,
      fn _, acc ->
        acc = Enum.chunk_every(acc, 2, 1, [])
              |> Enum.map(
                   fn ab ->
                     if Enum.count(ab) == 2 do
                       [a, b] = ab
                       [a, rules["#{a}#{b}"]]
                     else
                       ab
                     end
                   end
                 )
              |> List.flatten()
        acc
      end
    )

    frequencies = Enum.frequencies(final)
    max = Enum.max_by(frequencies, fn x -> elem(x, 1) end)
    min = Enum.min_by(frequencies, fn x -> elem(x, 1) end)

    #    IEx.pry()
    elem(max, 1) - elem(min, 1)
  end

  # Much more efficient, only calculates the frequencies
  def part2(chars, rules, steps) do
    final = compute_frequencies_only(chars, rules, steps)
    max = Enum.max_by(final, fn x -> elem(x, 1) end)
    min = Enum.min_by(final, fn x -> elem(x, 1) end)

    elem(max, 1) - elem(min, 1)
  end

  def compute_frequencies_only(chars, rules, steps) do
    # Init with last char because it never changes and all subsequent
    # counting will omit the last char so there's no accidental overlapped counts
    frequency_map = %{Enum.at(chars, -1) => 1}

    {:ok, memo_agent} = Agent.start_link fn -> Map.new() end
    final = Enum.chunk_every(chars, 2, 1, :discard)
            |> Enum.map(fn c -> compute(memo_agent, rules, steps, c) end)
            |> Enum.reduce(frequency_map, fn x, acc -> map_merge_sum(x, acc) end)
    Agent.stop(memo_agent)

    final
  end

  def compute(memo_agent, rules, steps, [a, b]) do
    #    IO.puts "#{steps} compute()"
    #    IO.puts "#{steps}   steps: #{steps}"
    #    IO.puts "#{steps}   input: [#{a}, #{b}]"
    key = make_key(steps, [a, b])
    key_exists = Agent.get(memo_agent, fn x -> Map.has_key?(x, key) end)

    return = cond do
      key_exists -> Agent.get(memo_agent, fn x -> x[key] end)
      steps == 0 -> store_and_return(memo_agent, key, %{"#{a}" => 1})
      true ->
        [a, m, b] = [a, rules["#{a}#{b}"], b]
        r1 = compute(memo_agent, rules, steps - 1, [a, m])
        r2 = compute(memo_agent, rules, steps - 1, [m, b])
        store_and_return(memo_agent, key, map_merge_sum(r1, r2))
    end
#    IO.puts "#{steps}   returning"
    #    IO.inspect return
    return
  end

  def store_and_return(memo_agent, key, val) do
    Agent.update(memo_agent, fn x -> Map.put(x, key, val) end)
    val
  end

  def map_merge_sum(m1, m2) do
    Map.merge(m1, m2, fn _k, v1, v2 -> v1 + v2 end)
  end

  def make_key(steps, [a, b]) do
    {steps, a, b}
  end
end


