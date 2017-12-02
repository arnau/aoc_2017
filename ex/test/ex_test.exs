defmodule ExTest do
  use ExUnit.Case

  doctest Aoc.Day1

  test "day2" do
    input = File.stream!("./data/day2.txt")

    assert Aoc.Day2.solve(input) == 47136
  end
end
