defmodule Aoc.Day6 do
  @doc """
  http://adventofcode.com/2017/day/6

  """
  def solve(str) do
    str
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> count_cycles()
  end

  @doc """
    iex> Aoc.Day6.count_cycles([0, 2, 7, 0])
    5
  """
  def count_cycles(banks) do
    banks
    |> Stream.unfold(fn (xs) -> {xs, reallocate(xs)} end)
    |> Enum.reduce_while([], fn (xs, yss) ->
      if Enum.find(yss, fn (ys) -> ys == xs end) do
        {:halt, yss}
      else
        {:cont, [ xs | yss]}
      end
    end)
    |> Enum.count()
  end

  def reallocate_cycle(current = {n, xs}) do
    {current, {n + 1, reallocate(xs)}}
  end

  @doc """
    iex> Aoc.Day6.reallocate([0, 2, 7, 0])
    [2, 4, 1, 2]

    iex> Aoc.Day6.reallocate([2, 4, 1, 2])
    [3, 1, 2, 3]

    iex> Aoc.Day6.reallocate([3, 1, 2, 3])
    [0, 2, 3, 4]

    iex> Aoc.Day6.reallocate([0, 2, 3, 4])
    [1, 3, 4, 1]

    iex> Aoc.Day6.reallocate([1, 3, 4, 1])
    [2, 4, 1, 2]
  """
  def reallocate(xs) do
    xs
    |> take_max_blocks()
    |> Stream.unfold(fn (x) -> {x, allocate(x)} end)
    |> Enum.reduce_while([], fn (t, _) ->
      if elem(t, 0) == 0 do
        {:halt, elem(t, 2)}
      else
        {:cont, t}
      end
    end)
  end

  @doc """
    iex> Aoc.Day6.take_max_blocks([0, 2, 7, 0])
    {7, 3, [0, 2, 0, 0]}
  """
  def take_max_blocks(blocks) do
    {max, index} =
      blocks
      |> Enum.with_index()
      |> Enum.max_by(&elem(&1, 0))

    next = if index == length(blocks) - 1, do: 0, else: index + 1
    {max, next, List.replace_at(blocks, index, 0)}
  end

  @doc """
    iex> Aoc.Day6.allocate({7, 3, [0, 2, 0, 0]})
    {6, 0, [0, 2, 0, 1]}

    iex> Aoc.Day6.allocate({6, 0, [0, 2, 0, 1]})
    {5, 1, [1, 2, 0, 1]}
  """
  def allocate({n, i, xs}) when n >= 0 and i <= length(xs) - 1 do
    if n == 0 do
      {n, i, xs}
    else
      j = if i == length(xs) - 1, do: 0, else: i + 1
      {n - 1, j, List.update_at(xs, i, &(&1 + 1))}
    end
  end
end
