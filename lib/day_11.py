
def run():
  input = Aoc.Utils.read_input_to_strings(11)
  grid = parse_input(input)

  part1 = Enum.reduce(
            0..99,
            {0, grid},
            fn _step, {changed, new_grid} ->
              {new_changed, new_grid} = step(grid)
              {changed + new_changed, new_grid}
            end
          )
          |> Enum.map(fn {changed, _} -> changed end)
          |> Enum.sum()
  IO.puts("Part 1: #{part1}")



#    part1 = part1(input)
#    part2 = part2(input)
#    IO.puts("Part 2: #{part2}")

def parse_input(input):
  x_count = len(input[0])
  y_count = len(input)


points = Enum.flat_map(0..y_count - 1, fn
y ->
Enum.map(0..x_count - 1, fn
x ->
{{x, y}, String.to_integer(String.at(Enum.at(input, y), x))}
end)
end)
Map.new(points)
end

if __name__ == '__main__':
  run()

  def part1 do

  end



  def step(grid) do
#    IEx.pry()
    new_grid = Enum.map(grid, fn {k,v} -> {k, v+1} end) |> Map.new()
    flashers = Enum.filter(new_grid, fn {_k, v} -> v >= 9 end)
    new_grid = Enum.map(new_grid, fn {k, v} ->
      if v >= 9 do
        {k,-1}
      else
        {k,v}
      end
    end) |> Map.new()
    new_grid = Enum.map(flashers, fn f -> process_flashers(new_grid, f) end)
    changed = Enum.filter(new_grid, fn {_k, v} -> v == -1 end) |> Enum.count()
    new_grid = Enum.map(new_grid, fn {k, v} ->
      new_v = if v == -1 do
        0
        else
        v
      end
      {k, new_v}
    end) |> Map.new()
    {changed, new_grid}
  end

  def process_flashers(grid, flashers) do
    neighbors = neighbors()
    IEx.pry()



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


