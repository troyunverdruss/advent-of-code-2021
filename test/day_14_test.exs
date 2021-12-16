require IEx
defmodule AOCTest.Day14 do
  use ExUnit.Case

  def input do
      "NNCB"
  end

  def rules do
    "CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"
  end

  def folds do
      "fold along y=7
fold along x=5"
  end

  @tag timeout: :infinity
  test "part 1 original algorithm" do
    chars = Aoc.Day14.parse_chars(input())
    rules = Aoc.Day14.parse_rules(rules())

    assert Aoc.Day14.part1(chars, rules) == 1588
  end

  @tag timeout: :infinity
  test "part 1 new algorithm" do
    chars = Aoc.Day14.parse_chars(input())
    rules = Aoc.Day14.parse_rules(rules())

    res = assert Aoc.Day14.part2(chars, rules, 10)

    assert res == 1588
  end

  @tag timeout: :infinity
  test "part 2 new part2 algo 1 step" do
    rules = Aoc.Day14.parse_rules(rules())

    %{"N" => n, "C" => c, "B" => b, "H" => h} = Aoc.Day14.compute_frequencies_only(["N", "N", "C", "B"], rules, 1)

    # N C N B C H B
    assert n == 2
    assert c == 2
    assert b == 2
    assert h == 1
  end

  @tag timeout: :infinity
  test "part 2 new part2 algo 2 steps" do
    rules = Aoc.Day14.parse_rules(rules())

    %{"N" => n, "C" => c, "B" => b, "H" => h } = Aoc.Day14.compute_frequencies_only(["N","N","C","B"], rules, 2)

    # N B C C N B B B C B H C B
    assert n == 2
    assert c == 4
    assert b == 6
    assert h == 1
  end

  @tag timeout: :infinity
  test "part 2 new algo compute 1 step" do
    rules = Aoc.Day14.parse_rules(rules())
    {:ok, memo_agent} = Agent.start_link fn -> Map.new() end
    res = Aoc.Day14.compute(memo_agent, rules, 1, ["N","N"])
    %{"N" => n, "C" => c} = res
    Agent.stop(memo_agent)

    # NN => N C N => N B C C N
    assert n == 1 # plus original tail
    assert c == 1
  end

  @tag timeout: :infinity
  test "part 2 new algo compute 2 steps" do
    rules = Aoc.Day14.parse_rules(rules())
    {:ok, memo_agent} = Agent.start_link fn -> Map.new() end
    res = Aoc.Day14.compute(memo_agent, rules, 2, ["N","N"])
    %{"N" => n, "C" => c, "B" => b } = res
    Agent.stop(memo_agent)

    # NN => N C N => N B C C N
    assert n == 1 # plus original tail
    assert c == 2
    assert b == 1
  end

  @tag timeout: :infinity
  test "part 2 new algo compute 3 steps" do
    rules = Aoc.Day14.parse_rules(rules())
    {:ok, memo_agent} = Agent.start_link fn -> Map.new() end
    res = Aoc.Day14.compute(memo_agent, rules, 3, ["N","N"])
    %{"N" => n, "C" => c, "B" => b } = res
    Agent.stop(memo_agent)

    # NN => N C N => N B C C N => N B B B C N C C N
    assert n == 2 # plus original tail
    assert c == 3
    assert b == 3
  end
end