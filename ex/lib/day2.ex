defmodule Aoc.Day2 do
  @doc """
  http://adventofcode.com/2017/day/2

    iex> Aoc.Day2.solve(["5\t1\t9\t5","7\t5\t3","2\t4\t6\t8"])
    18
  """
  def solve(rows) do
    rows
    |> Stream.map(&parse_row/1)
    |> Stream.map(&row_diff/1)
    |> Enum.sum()
  end

  @doc """
    iex> Aoc.Day2.solve_b(["5\t9\t2\t8", "9\t4\t7\t3", "3\t8\t6\t5"])
    9
  """
  def solve_b(rows) do
    rows
    |> Stream.map(&parse_row/1)
    |> Stream.map(&row_div/1)
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

  @doc """
    Could be done with:

      xsi = Enum.with_index(xs)
      (for {x, i} <- xsi, {y, j} <- xsi, i != j && rem(x, y) == 0, do: div(x, y))
      |> List.first

    But `Enum.reduce_while/2` seems more fun.

    iex> Aoc.Day2.row_div([5, 9, 2, 8])
    4

    iex> Aoc.Day2.row_div([9, 4, 7, 3])
    3

    iex> Aoc.Day2.row_div([3, 8, 6, 5])
    2
  """
  def row_div(xs) do
    xsi = Enum.with_index(xs)

    xsi
    |> Enum.reduce_while(0, fn (xi, acc) ->
      case divide(xi, xsi) do
        {:ok, result} -> {:halt, result}
        _ -> {:cont, acc}
      end
    end)
  end

  @doc """
    iex> Aoc.Day2.divide({5, 0}, Enum.with_index([5, 9, 2, 8]))
    :not_found

    iex> Aoc.Day2.divide({8, 3}, Enum.with_index([5, 9, 2, 8]))
    {:ok, 4}
  """
  def divide({x, i}, xsi) do
    Enum.reduce_while(xsi, :not_found, fn ({y, j}, acc) ->
      if i != j && rem(x, y) == 0 do
        {:halt, {:ok, div(x, y)}}
      else
        {:cont, acc}
      end
    end)
  end
end
