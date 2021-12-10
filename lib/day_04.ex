require IEx

defmodule Aoc.Day04 do
  @called "called"

  def run() do
    [raw_called_numbers | raw_boards] = Aoc.Utils.read_input_to_strings_with_delim("input/day04.txt", "\n\n")

    called_numbers = String.split(raw_called_numbers, ",")
    boards = process_raw_boards(raw_boards)

    part1 = part1(called_numbers, boards)
    IO.puts("Part 1: #{part1}")

    part2 = part2(called_numbers, boards)
    IO.puts("Part 2: #{part2}")
  end

  def update_boards(current_boards, called_number) do
    Enum.map(
      current_boards,
      fn board ->
        Enum.map(
          board,
          fn element ->
            if element == called_number do
              @called
            else
              element
            end
          end
        )
      end
    )
  end

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

  def process_raw_boards(raw_boards) do
    Enum.map(raw_boards, fn raw_board -> String.split(raw_board, [" ", "\n"], trim: true) end)
  end

  def part1(called_numbers, boards) do
    Enum.reduce(
      called_numbers,
      boards,
      fn number, current_boards ->
        if is_number(current_boards) do
          current_boards
        else
          new_boards = update_boards(current_boards, number)

          winners = Enum.filter(new_boards, fn b -> winning_board(b) end)
          if Enum.count(winners) > 0 do
            [winner | _] = winners
            sum = winner
                  |> Enum.filter(fn elem -> elem != @called end)
                  |> Enum.map(fn elem -> String.to_integer(elem) end)
                  |> Enum.sum()
            String.to_integer(number) * sum
          else
            new_boards
          end
        end
      end
    )
  end

  def part2(called_numbers, boards) do
    Enum.reduce(
      called_numbers,
      boards,
      fn number, current_boards ->
        if is_number(current_boards) do
          current_boards
        else
          new_boards = update_boards(current_boards, number)

          remaining_boards = if Enum.count(new_boards) == 1 do
            new_boards
          else
            Enum.filter(new_boards, fn b -> !winning_board(b) end)
          end

          if Enum.count(remaining_boards) == 1 && winning_board(Enum.at(remaining_boards, 0)) do
            [winner | _] = remaining_boards
            sum = winner
                  |> Enum.filter(fn elem -> elem != "called" end)
                  |> Enum.map(fn elem -> String.to_integer(elem) end)
                  |> Enum.sum()
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
