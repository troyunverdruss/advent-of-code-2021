defmodule AOCTest.Day10 do
  use ExUnit.Case

  def input do
    [
      "[({(<(())[]>[[{[]{<()<>>",
      "[(()[<>])]({[<{<<[]>>(",
      "{([(<{}[<>[]}>{[]{[(<()>",
      "(((({<>}<{<{<>}{[]{[]{}",
      "[[<[([]))<([[{}[[()]]]",
      "[{[{({}]{}}([{[{{{}}([]",
      "{<[[]]>}<{[{[{[]{()[[[]",
      "[<(<(<(<{}))><([]([]()",
      "<{([([[(<>()){}]>(<<{{",
      "<{([{{}}[<[[[<>{}]]]>[]]",
    ]
  end

  @tag timeout: :infinity
  test "part 1 line 1 incomplete" do
    line = List.first(input())
    result = Aoc.Day10.check_line(line)
    assert result[:error] == nil
  end

  @tag timeout: :infinity
  test "part 1 line 3 invalid" do
    {line, _} = List.pop_at(input(), 2)
    result = Aoc.Day10.check_line(line)
    assert result[:error] == "}"
  end

  @tag timeout: :infinity
  test "part 1" do
    result = Aoc.Day10.part1(input())
    assert result == 26397
  end

  @tag timeout: :infinity
  test "part 2" do
    result = Aoc.Day10.part2(input())
    assert result == 288957
  end

  @tag timeout: :infinity
  test "part 2 compute score" do
    %{opened: opened} = Aoc.Day10.check_line("<{([{{}}[<[[[<>{}]]]>[]]")
    result = Aoc.Day10.compute_score(opened)
    assert result == 294
  end
end