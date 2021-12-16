require IEx
defmodule Aoc.Day15 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(15)
    grid = parse_input(input)

    part1 = part1(grid)
    IO.puts("Part 1: #{part1}")

    expanded_grid = expand_grid(grid)
    part2 = part1(expanded_grid)



    #    [input, rules] = Aoc.Utils.read_input_to_strings_with_delim("input/day14.txt", "\n\n")
    #
    #    chars = parse_chars(input)
    #    rules = parse_rules(rules)
    #
    #    part1 = part1(chars, rules)
    #
    #    part2 = part2(chars, rules, 40)
        IO.puts("Part 2: #{part2}")
  end

  def part1(grid) do
    #    start = {0, 0}
    #
    {max, _} = Enum.max_by(Map.keys(grid), fn x -> elem(x, 0) end)
    dest = {max, max}
    #    risk = find_lowest_risk_path(grid, [], start, finish)
    #    risk

    dijkstra_lowest_risk(grid, dest)
  end

  def expand_grid(grid) do
    steps = Enum.map(0..4, fn x -> x * 5 end)
    step_size  = round(:math.sqrt(Enum.count(grid)))

    updated_points = Enum.flat_map(
      grid,
      fn {{x,y}, val} ->
        Enum.flat_map(
          0..4,
          fn yd ->
            Enum.map(
              0..4,
              fn xd ->
                new_x = x + xd * step_size
                new_y = y + yd * step_size
                new_v = if val + xd + yd == 9 do
                  9
                else
                  rem(val + xd + yd, 9)
                end
#                IO.inspect {{new_x, new_y}, new_v}
                {{new_x, new_y}, new_v}
              end
            )
          end
        )
      end
    )

    Map.new(updated_points)
  end

  def dijkstra_lowest_risk(grid, dest) do
    adjacency_lookup = compute_adjacency_map(grid)

    shortest_path_map = Map.new()
    unvisited_map = Enum.reduce(Map.keys(grid), Map.new(), fn k, acc -> Map.put(acc, k, :infinity) end)
    unvisited_map = Map.put(unvisited_map, {0, 0}, 0)

    stream = Stream.unfold(
      {shortest_path_map, unvisited_map},
      fn acc ->
        {shortest_path_map, unvisited_map} = acc

        cond do
          unvisited_map == :done -> nil
          Enum.count(unvisited_map) == 0 -> {acc, {shortest_path_map, :done}}
          true ->
#            IO.puts "Remaining points: #{Enum.count(unvisited_map)}"
            {next_point, distance} = find_next_shortest(unvisited_map)
            shortest_path_map2 = Map.put(shortest_path_map, next_point, distance)
            #IEx.pry()
            unvisited_map1 = Map.delete(unvisited_map, next_point)
            unvisited_map2 = Enum.reduce(
              adjacency_lookup[next_point],
              unvisited_map1,
              fn key, acc ->
                r = if Map.has_key?(acc, key) && acc[key] == :infinity do
                  Map.put(acc, key, grid[key] + distance)
                else
                  acc
                end
                #             IEx.pry()
                r
              end
            )
            #           IEx.pry()
            {acc, {shortest_path_map2, unvisited_map2}}
        end
      end
    )

    {paths, _} = Enum.at(stream, -1)
    #    IEx.pry()
    paths[dest]
  end

  def add_distance(val, distance) do
    if val == :infinity do
      distance
    else
      val + distance
    end
  end

  def find_next_shortest(unvisited_map) do
    Enum.filter(unvisited_map, fn {_k, v} -> v != :infinity end)
    |> Enum.min_by(fn {_k, v} -> v end)
  end

  def compute_adjacency_map(grid) do
    Enum.reduce(
      grid,
      %{},
      fn kv, acc ->
        {key, _} = kv
        neighbors = Enum.filter(neighbors(key), fn n -> Map.has_key?(grid, n) end)
        Enum.reduce(
          neighbors,
          acc,
          fn n, acc ->
            current = Map.get(acc, key, MapSet.new())
            Map.put(acc, key, MapSet.put(current, n))
          end
        )
      end
    )
  end

  def find_lowest_risk_path(grid, path, pos, dest) do
    cond do
      pos == dest ->
        Enum.map(path, fn c -> grid[c] end)
        |> Enum.sum()
      true ->
        neighbors = Enum.filter(neighbors(pos), fn n -> !Enum.member?(path, n) && Map.has_key?(grid, n) end)
        cond do
          Enum.count(neighbors) == 0 -> 1_000_000_000
          true -> Enum.map(
                    neighbors,
                    fn n ->
                      risk = find_lowest_risk_path(grid, path ++ [n], n, dest)
                      #            IEx.pry()
                      risk
                    end
                  )
                  |> Enum.min()
        end
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

  def neighbors(coord) do
    {x, y} = coord
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
  end
  #
  #  def parse_chars(input) do
  #    String.split(input, "", trim: true)
  #  end
  #
  #  def parse_rules(rules) do
  #    Enum.map(
  #      String.split(rules, "\n", trim: true),
  #      fn line ->
  #        [k, v] = String.split(line, " -> ", trim: true)
  #        {k, v}
  #      end
  #    )
  #    |> Map.new()
  #  end
  #
  #  # Slow but calculates the actual string
  #  def part1(chars, rules) do
  #    final = Enum.reduce(
  #      0..9,
  #      chars,
  #      fn _, acc ->
  #        acc = Enum.chunk_every(acc, 2, 1, [])
  #              |> Enum.map(
  #                   fn ab ->
  #                     if Enum.count(ab) == 2 do
  #                       [a, b] = ab
  #                       [a, rules["#{a}#{b}"]]
  #                     else
  #                       ab
  #                     end
  #                   end
  #                 )
  #              |> List.flatten()
  #        acc
  #      end
  #    )
  #
  #    frequencies = Enum.frequencies(final)
  #    max = Enum.max_by(frequencies, fn x -> elem(x, 1) end)
  #    min = Enum.min_by(frequencies, fn x -> elem(x, 1) end)
  #
  #    #    IEx.pry()
  #    elem(max, 1) - elem(min, 1)
  #  end
  #
  #  # Much more efficient, only calculates the frequencies
  #  def part2(chars, rules, steps) do
  #    final = compute_frequencies_only(chars, rules, steps)
  #    max = Enum.max_by(final, fn x -> elem(x, 1) end)
  #    min = Enum.min_by(final, fn x -> elem(x, 1) end)
  #
  #    elem(max, 1) - elem(min, 1)
  #  end
  #
  #  def compute_frequencies_only(chars, rules, steps) do
  #    # Init with last char because it never changes and all subsequent
  #    # counting will omit the last char so there's no accidental overlapped counts
  #    frequency_map = %{Enum.at(chars, -1) => 1}
  #
  #    {:ok, memo_agent} = Agent.start_link fn -> Map.new() end
  #    final = Enum.chunk_every(chars, 2, 1, :discard)
  #            |> Enum.map(fn c -> compute(memo_agent, rules, steps, c) end)
  #            |> Enum.reduce(frequency_map, fn x, acc -> map_merge_sum(x, acc) end)
  #    Agent.stop(memo_agent)
  #
  #    final
  #  end
  #
  #  def compute(memo_agent, rules, steps, [a, b]) do
  #    #    IO.puts "#{steps} compute()"
  #    #    IO.puts "#{steps}   steps: #{steps}"
  #    #    IO.puts "#{steps}   input: [#{a}, #{b}]"
  #    key = make_key(steps, [a, b])
  #    key_exists = Agent.get(memo_agent, fn x -> Map.has_key?(x, key) end)
  #
  #    return = cond do
  #      key_exists -> Agent.get(memo_agent, fn x -> x[key] end)
  #      steps == 0 -> store_and_return(memo_agent, key, %{"#{a}" => 1})
  #      true ->
  #        [a, m, b] = [a, rules["#{a}#{b}"], b]
  #        r1 = compute(memo_agent, rules, steps - 1, [a, m])
  #        r2 = compute(memo_agent, rules, steps - 1, [m, b])
  #        store_and_return(memo_agent, key, map_merge_sum(r1, r2))
  #    end
  ##    IO.puts "#{steps}   returning"
  #    #    IO.inspect return
  #    return
  #  end
  #
  #  def store_and_return(memo_agent, key, val) do
  #    Agent.update(memo_agent, fn x -> Map.put(x, key, val) end)
  #    val
  #  end
  #
  #  def map_merge_sum(m1, m2) do
  #    Map.merge(m1, m2, fn _k, v1, v2 -> v1 + v2 end)
  #  end
  #
  #  def make_key(steps, [a, b]) do
  #    {steps, a, b}
  #  end
end


