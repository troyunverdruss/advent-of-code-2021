defmodule AOCTest.Day08 do
  use ExUnit.Case

  def input do
    """
    eb cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """
  end

  @tag timeout: :infinity
  test "part 1" do
    parsed_input = String.split(input(), "\n")
                   |> Enum.filter(fn x -> String.length(x) > 0 end)
    assert Aoc.Day08.part1(parsed_input) == 26
  end

  test "test part2 solve row" do
    row = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
    [left_group | [right_group | _]] = String.split(row, "|")
    [n0, n1, n2, n3, n4, n5, n6, n7, n8, n9] = Aoc.Day08.solve_row(left_group)

    assert n8 == MapSet.new(String.split("acedgfb", "", trim: true))
    assert n5 == MapSet.new(String.split("cdfbe", "", trim: true))
    assert n2 == MapSet.new(String.split("gcdfa", "", trim: true))
    assert n3 == MapSet.new(String.split("fbcad", "", trim: true))
    assert n7 == MapSet.new(String.split("dab", "", trim: true))
    assert n9 == MapSet.new(String.split("cefabd", "", trim: true))
    assert n6 == MapSet.new(String.split("cdfgeb", "", trim: true))
    assert n4 == MapSet.new(String.split("eafb", "", trim: true))
    assert n0 == MapSet.new(String.split("cagedb", "", trim: true))
    assert n1 == MapSet.new(String.split("ab", "", trim: true))
  end

  test "test part2 solve row with solution" do
    row = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
    [left_group | [right_group | _]] = String.split(row, "|")
    numbers = Aoc.Day08.solve_row(left_group)

    assert Aoc.Day08.compute_result_number(numbers, right_group) == 5353
  end

  test "test part2" do
    parsed_input = String.split(input(), "\n")
                   |> Enum.filter(fn x -> String.length(x) > 0 end)
    assert Aoc.Day08.part2(parsed_input) == 61229
  end
end