defmodule ExTest do
  use ExUnit.Case

  doctest Aoc.Day1
  doctest Aoc.Day2
  doctest Aoc.Day3
  doctest Aoc.Day4

  test "day2 part 1" do
    input = File.stream!("./data/day2.txt")

    assert Aoc.Day2.solve(input) == 47136
  end

  test "day2 part 2" do
    input = File.stream!("./data/day2.txt")

    assert Aoc.Day2.solve_b(input) == 250
  end

  test "day4 part 1" do
    input = File.stream!("./data/day4.txt")

    assert Aoc.Day4.solve(input) == 455
  end
end

