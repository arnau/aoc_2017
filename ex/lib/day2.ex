defmodule Aoc.Day2 do
  @doc """
  http://adventofcode.com/2017/day/2

    iex> Aoc.Day2.solve(["5\t1\t9\t5"],["7\t5\t3"],["2\t4\t6\t8"])
    18
  """
  def solve(rows) do
    rows
    |> Stream.map(&parse_row/1)
    |> Stream.map(&row_diff/1)
    |> Enum.sum()
  end

  @doc """
    iex> Aoc.Day2.parse_row("5\t1\t9\t5")
    [5, 1, 9, 5]
  """
  def parse_row(str) do
    str
    |> String.split("\t")
    |> Enum.map(fn (s) -> String.to_integer(String.trim(s)) end)
  end

  @doc """
    iex> Aoc.Day2.row_diff([5, 1, 9, 5])
    8

    iex> Aoc.Day2.row_diff([7, 5, 3])
    4

    iex> Aoc.Day2.row_diff([2, 4, 6, 8])
    6
  """
  def row_diff(xs) do
    {x, y} = Enum.min_max(xs)

    y - x
  end
end
