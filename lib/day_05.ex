require IEx

defmodule Point do
  @enforce_keys [:x, :y]
  defstruct [:x, :y]
end

defmodule Aoc.Day05 do

  def run() do

    input = Utils.read_input_to_strings(5)


    input = """
    ...###x...
    """

    z = Enum.with_index(
      String.split(String.trim(input), "", trim: true),
      fn map_val, index ->
      {%Point{x: index, y: 0}, map_val}
      end
    )

    IEx.pry()

    part1 = part1()
    IO.puts("Part 1: #{part1}")

    part2 = part2()
    IO.puts("Part 2: #{part2}")
  end


  def part1() do
  end

  def part2() do
  end
end


