defmodule AOC.Utils do
  def read_input_to_strings(day) when is_number(day) do
    padded_day = String.pad_leading(Integer.to_string(day), 2, "0")
    read_input_to_strings("input/day#{padded_day}.txt")
  end

  def read_input_to_strings(path) do
    File.read!(path) |> String.split("\n", trim: true)
  end

  def read_input_to_strings_with_delim(path, delim) do
    File.read!(path) |> String.split(delim, trim: true)
  end
end