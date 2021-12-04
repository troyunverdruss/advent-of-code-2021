defmodule AOC.Day04 do
  def run() do
    require IEx
    [called_numbers_str | boards_raw] = AOC.Utils.read_input_to_strings_with_delim("input/day04.txt", "\n\n")

    called_numbers = String.split(called_numbers_str, ",")
    count_of_called_numbers = Enum.count(called_numbers)

    boards = Enum.map(boards_raw, fn board_raw -> String.split(board_raw, [" ", "\n"], trim: true) end)

    #    IEx.pry()

    part1 = Enum.reduce(
      called_numbers,
      boards,
      fn number, acc ->
        if is_number(acc) do
          acc
        else
          new_boards = Enum.map(
            acc,
            fn b ->
              Enum.map(
                b,
                fn elem ->
                  if elem == number do
                    "called"
                  else
                    elem
                  end
                end
              )
            end
          )

          winners = Enum.filter(new_boards, fn b -> winning_board(b) end)
          if Enum.count(winners) > 0 do
            [winner | _] = winners
#            IEx.pry()
            sum = winner
                  |> Enum.filter(fn elem -> elem != "called" end)
                  |> Enum.map(fn elem -> String.to_integer(elem) end)
                  |> Enum.sum()
            String.to_integer(number) * sum
          else
            new_boards
          end
        end
      end
    )

    IO.puts("Part 1: #{part1}")

    part2 = part2(called_numbers, boards_raw)

    IO.puts("Part 2: #{part2}")


    #
    #
    #    Enum.reduce(
    #      boards_raw,
    #      %{winning_index: count_of_called_numbers, winning_score: 0},
    #      fn (board_raw, acc) ->
    #        all_values = String.split(board_raw, ["  ", " ", "\n"])
    #        board =
    #          Enum.with_index(all_values)
    #          |> Enum.reduce(
    #               %{},
    #               fn t, acc ->
    #                 Map.put(acc, elem(t, 1), elem(t, 0))
    #               end
    #             )
    #
    #        board_and_all_vals = Map.put(board, :all_values, MapSet.new(all_values))
    #
    #        Enum.reduce(
    #          Enum.with_index(called_numbers),
    #          board_and_all_vals,
    #          fn {number, index}, acc ->
    #            next_board = if MapSet.member?(acc[:all_values], number) do
    #              [{target, _}] = Enum.filter(acc, fn {key, val} -> val == number end)
    #              %{acc | target: true, all_value: MapSet.delete(acc[:all_values], number)}
    #            else
    #              acc
    #            end
    #
    #            if winning_board(next_board) do
    #
    #            end
    #
    #            next_board
    #          end
    #        )
    #
    #
    #
    #        IEx.pry()
    #      end
    #    )



    #    part1 = part1(string_data)
    #    IO.puts "Part 1: #{part1}"
    #    part2 = part2(string_data)
    #    IO.puts "Part 2: #{part2}"
  end

  #  def create_board(board_raw) do
  #    board = %{}
  #    rows = String.split(board_raw, "\n")
  #
  #    Enum.each(
  #      0..4,
  #      fn y ->
  #        row = Enum.at(rows, y)
  #        row_vals = String.split(row, ",")
  #        Enum.each(
  #          0..4,
  #          fn x ->
  #            val = Enum.at(row_vals, x)
  #            Map.put(board, {x, y}, val)
  #          end
  #        )
  #      end
  #    )
  #
  #
  #    #    Enum.each(rows, fn row ->
  #    #      Enum.each(String.split(row, ","), fn  end)
  #    #    end)
  #  end

  def winning_board(board) do
    winning_combos = [
      [0, 1, 2, 3, 4],
      [5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],

      [0, 5, 10, 15, 20],
      [1, 6, 11, 16, 21],
      [2, 7, 12, 17, 22],
      [3, 8, 13, 18, 23],
      [4, 9, 13, 19, 24]
    ]

    Enum.any?(
      winning_combos,
      fn combo ->
        Enum.all?(
          combo,
          fn pos ->
            Enum.at(board, pos) == "called"
          end
        )
      end
    )
  end

  #  def most_common_at_pos(input, position) do
  #    input
  #    |> Enum.map(fn x -> String.at(x, position) end)
  #    |> Enum.frequencies()
  #    |> Enum.max_by(fn x -> elem(x, 1) end)
  #    |> elem(0)
  #  end
  #
  #  def min_common_at_pos(input, position) do
  #    input
  #    |> Enum.map(fn x -> String.at(x, position) end)
  #    |> Enum.frequencies()
  #    |> Enum.min_by(fn x -> elem(x, 1) end)
  #    |> elem(0)
  #  end
  #
  #  def freq_at_pos(input, position) do
  #    input
  #    |> Enum.map(fn x -> String.at(x, position) end)
  #    |> Enum.frequencies()
  #  end
  #
  #  def filter_input_for_most_common_at_pos(input, position) do
  #    freq = freq_at_pos(input, position)
  #
  #    target = if freq["0"] == freq["1"] do
  #      "1"
  #    else
  #      Enum.max_by(freq, fn x -> elem(x, 1) end)
  #      |> elem(0)
  #    end
  #
  #    input
  #    |> Enum.filter(fn x -> String.at(x, position) == target end)
  #  end
  #
  #  def filter_input_for_least_common_at_pos(input, position) do
  #    freq = freq_at_pos(input, position)
  #
  #    target = if freq["0"] == freq["1"] do
  #      "0"
  #    else
  #      Enum.min_by(freq, fn x -> elem(x, 1) end)
  #      |> elem(0)
  #    end
  #
  #    input
  #    |> Enum.filter(fn x -> String.at(x, position) == target end)
  #  end

  def part1(string_data) do

  end

  def part2(called_numbers, boards_raw) do
    boards = Enum.map(boards_raw, fn board_raw -> String.split(board_raw, [" ", "\n"], trim: true) end)
    Enum.reduce(
      called_numbers,
      boards,
      fn number, acc ->
        if is_number(acc) do
          acc
        else
          new_boards = Enum.map(
            acc,
            fn b ->
              Enum.map(
                b,
                fn elem ->
                  if elem == number do
                    "called"
                  else
                    elem
                  end
                end
              )
            end
          )

          remaining_boards = if Enum.count(new_boards) == 1 do
            new_boards
          else
            Enum.filter(new_boards, fn b -> !winning_board(b) end)
          end

          if Enum.count(remaining_boards) == 1 && winning_board(Enum.at(remaining_boards, 0)) do
            [winner | _ ] = remaining_boards
            sum = winner
                  |> Enum.filter(fn elem -> elem != "called" end)
                  |> Enum.map(fn elem -> String.to_integer(elem) end)
                  |> Enum.sum()
            require IEx
#            IEx.pry()
            String.to_integer(number) * sum
          else
            remaining_boards
          end
        end
      end
    )
  end
end
