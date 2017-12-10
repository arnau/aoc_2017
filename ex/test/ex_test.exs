defmodule ExTest do
  use ExUnit.Case

  doctest Aoc.Day1
  doctest Aoc.Day2
  doctest Aoc.Day3
  doctest Aoc.Day4
  doctest Aoc.Day5
  doctest Aoc.Day6

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

  test "day4 part 2" do
    input = File.stream!("./data/day4.txt")

    assert Aoc.Day4.solve_b(input) == 186
  end

  test "day5 part 1" do
    input = File.stream!("./data/day5.txt")

    assert Aoc.Day5.solve(input) == 360603
  end

  @tag :slow
  test "day5 part 2" do
    input = File.stream!("./data/day5.txt")

    assert Aoc.Day5.solve_b(input) == 25347697
  end

  @tag :slow
  test "day6 part 1" do
    input = "4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5"

    assert Aoc.Day6.solve(input) == 12841
  end

  @tag :slow
  test "day6 part 2" do
    input = "4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5"

    assert Aoc.Day6.solve_b(input) == 8038
  end
end
