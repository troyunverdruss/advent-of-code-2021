defmodule AOC.Main do
  use Application
  #  use AOC

  def start(_type, _args) do
    IO.puts "starting"

    Task.start(
      fn ->
        AOC.Day01.part1()
      end
    )
  end
end