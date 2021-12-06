require IEx

defmodule Point do
  @enforce_keys [:x, :y]
  defstruct [:x, :y]
end

defmodule Segment do
  @enforce_keys [:p1, :p2]
  defstruct [:p1, :p2]
end

defmodule Aoc.Day05 do

  def run() do
    input = Aoc.Utils.read_input_to_strings(5)
    segments = parse_segments(input)
    straight_map = populate_straight_map(segments)
    diag_map = populate_diag_map(segments)

    freq = Enum.frequencies(straight_map)
    part1 = Enum.count(freq, fn x -> elem(x, 1) > 1 end)
    IO.puts("Part 1: #{part1}")

    freq2 = Enum.frequencies(straight_map ++ diag_map)
    part2 = Enum.count(freq2, fn x -> elem(x, 1) > 1 end)
    IO.puts("Part 2: #{part2}")
  end

  def populate_straight_map(segments) do
    straight_segments = Enum.filter(
      segments,
      fn segment -> segment.p1.x == segment.p2.x || segment.p1.y == segment.p2.y end
    )

    Enum.flat_map(
      straight_segments,
      fn segment ->
        Enum.flat_map(
          segment.p1.x..segment.p2.x,
          fn x ->
            Enum.flat_map(
              segment.p1.y..segment.p2.y,
              fn y ->
                [%Point{x: x, y: y}]
              end
            )
          end
        )
      end
    )
  end

  def populate_diag_map(segments) do
    diag_segments = Enum.filter(
      segments,
      fn segment ->
        segment.p1.x != segment.p2.x && segment.p1.y != segment.p2.y
      end
    )

    Enum.flat_map(
      diag_segments,
      fn segment ->
        xs = segment.p1.x..segment.p2.x
        ys = segment.p1.y..segment.p2.y

        point_tuples = Enum.zip(xs, ys)
        Enum.map(point_tuples, fn {x, y} -> %Point{x: x, y: y} end)
      end
    )
  end

  def parse_segments(input) do
    Enum.map(
      input,
      fn line ->
        [left, right] = String.split(line, " -> ")
        [x1_s, y1_s] = String.split(left, ",")
        [x2_s, y2_s] = String.split(right, ",")
        %Segment{
          p1: %Point{
            x: String.to_integer(x1_s),
            y: String.to_integer(y1_s)
          },
          p2: %Point{
            x: String.to_integer(x2_s),
            y: String.to_integer(y2_s)
          }
        }
      end
    )
  end
end


