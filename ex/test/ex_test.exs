defmodule ExTest do
  use ExUnit.Case

  doctest Aoc.Day1
  doctest Aoc.Day2
  doctest Aoc.Day3
  doctest Aoc.Day4
  doctest Aoc.Day5
  doctest Aoc.Day6
  doctest Aoc.Day7
  doctest Aoc.Day8

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

  test "day7 part 1" do
    input = File.stream!("./data/day7.txt")

    assert Aoc.Day7.solve(input) == "airlri"
  end

  test "day7 part 2" do
    input = File.stream!("./data/day7.txt")

    assert Aoc.Day7.solve_b(input) == {:error, {24, [{666, 1614}, {1215, 1623}, {504, 1614}, {579, 1614}, {58, 1614}]}, 1206}
  end

  test "day8 part 1" do
    input = File.stream!("./data/day8.txt")

    assert Aoc.Day8.solve(input) == 5215
  end
end
