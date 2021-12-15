require IEx
import Mogrify
defmodule Aoc.Day13 do

  def run() do
    [dots, folds] = Aoc.Utils.read_input_to_strings_with_delim("input/day13.txt", "\n\n")
    dots = parse_dots(dots)
    folds = parse_folds(folds)
    grid = build_grid(dots)

    part1 = part1(grid, folds)
    IO.puts("Part 1: #{part1}")
    IO.puts("Part 2:")
    part2_ascii(grid, folds)
    IO.puts part2_image(grid, folds)
  end

  def part1(grid, folds) do
    {dir, pos} = List.first(folds)

    case dir do
      "x" ->
        fold_along_x(grid, pos)
        |> Enum.count()
      "y" ->
        fold_along_y(grid, pos)
        |> Enum.count()
    end
  end

  def part2_ascii(grid, folds) do
    final = Enum.reduce(
      folds,
      grid,
      fn f, grid ->
        {dir, pos} = f

        case dir do
          "x" -> fold_along_x(grid, pos)
          "y" -> fold_along_y(grid, pos)
        end
      end
    )

    max_x = Enum.map(final, fn {{x, _y}, _v} -> x end)
            |> Enum.max()
    max_y = Enum.map(final, fn {{_x, y}, _v} -> y end)
            |> Enum.max()

    Enum.each(
      0..max_y,
      fn y ->
        Enum.each(
          0..max_x,
          fn x ->
            IO.write Map.get(final, {x, y}, " ")
          end
        )
        IO.puts ""
      end
    )
  end

  def part2_image(grid, folds) do
    final = Enum.reduce(
      folds,
      grid,
      fn f, grid ->
        {dir, pos} = f

        case dir do
          "x" -> fold_along_x(grid, pos)
          "y" -> fold_along_y(grid, pos)
        end
      end
    )

    max_x = Enum.map(final, fn {{x, _y}, _v} -> x end)
            |> Enum.max()
    max_y = Enum.map(final, fn {{_x, y}, _v} -> y end)
            |> Enum.max()

    width = 5
    offset = 10

    IO.puts "size: #{max_x * width * 2}x#{max_y * width * 2}"
    img = %Mogrify.Image{path: "day_13.png", ext: "png"}
          |> custom("size", "#{max_x * width * 2}x#{max_y * width * 2}")
          |> canvas("white")

    # Draw block letters to file
    Enum.reduce(
      final,
      img,
      fn {{x, y}, _v}, img ->
        Mogrify.Draw.rectangle(
          img,
          x * width + offset,
          y * width + offset,
          (x + 1) * width + offset,
          (y + 1) * width + offset
        )
        |> custom("fill", "black")
      end
    )
    |> create(path: ".")

    # And then read it back with OCR to get characters
    TesseractOcr.read("day_13.png")
  end

  def parse_dots(dots) do
    String.split(dots, "\n", trim: true)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)
  end

  def parse_folds(folds) do
    String.split(folds, "\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x -> Enum.at(x, 2) end)
    |> Enum.map(fn x -> String.split(x, "=") end)
    |> Enum.map(fn [x, val] -> {x, String.to_integer(val)} end)
  end

  def build_grid(dots) do
    dots
    |> Enum.map(fn x -> {x, "#"} end)
    |> Map.new()
  end

  def fold_along_x(grid, fold_x) do
    to_move = Enum.filter(
      grid,
      fn {k, _v} ->
        {x, _y} = k
        x > fold_x
      end
    )

    Enum.reduce(
      to_move,
      grid,
      fn m, grid ->
        {{x, y}, v} = m
        dist_to_fold = x - fold_x
        new_x = fold_x - dist_to_fold
        new_grid = Map.delete(grid, {x, y})
        Map.put(new_grid, {new_x, y}, v)
      end
    )
  end

  def fold_along_y(grid, fold_y) do
    to_move = Enum.filter(
      grid,
      fn {k, _v} ->
        {_x, y} = k
        y > fold_y
      end
    )

    Enum.reduce(
      to_move,
      grid,
      fn m, grid ->
        {{x, y}, v} = m
        dist_to_fold = y - fold_y
        new_y = fold_y - dist_to_fold
        new_grid = Map.delete(grid, {x, y})
        Map.put(new_grid, {x, new_y}, v)
      end
    )
  end
end


