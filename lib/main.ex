defmodule AOC.Main do
  use Application

  def start(_type, _args) do
    IO.puts "starting"

    AOC.Day01.run()

    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end