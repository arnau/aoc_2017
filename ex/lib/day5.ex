defmodule Aoc.Day5 do
  @doc """
  http://adventofcode.com/2017/day/5


    iex> Aoc.Day5.solve(["0", "3", "0", "1", "-3"])
    5
  """
  def solve(xs) do
    data = xs
          |> Stream.map(&String.trim/1)
          |> Stream.map(&String.to_integer/1)
          |> Stream.with_index()
          |> Stream.map(fn ({x, i}) -> {i, x} end)
          |> Map.new()

    {0, data, 0}
    |> jumper()
    |> Enum.reduce_while(0, fn (res, _) -> res end)
  end

  @doc """
    iex> Aoc.Day5.jump({:cont, {0, %{0 => 0, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 0}})
    {:cont, {0, %{0 => 1, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 1}}

    iex> Aoc.Day5.jump({:cont, {0, %{0 => 1, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 1}})
    {:cont, {1, %{0 => 2, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 2}}

    iex> Aoc.Day5.jump({:cont, {1, %{0 => 2, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 2}})
    {:cont, {4, %{0 => 2, 1 => 4, 2 => 0, 3 => 1, 4 => -3}, 3}}

    iex> Aoc.Day5.jump({:cont, {4, %{0 => 2, 1 => 4, 2 => 0, 3 => 1, 4 => -3}, 3}})
    {:cont, {1, %{0 => 2, 1 => 4, 2 => 0, 3 => 1, 4 => -2}, 4}}

    iex> Aoc.Day5.jump({:cont, {1, %{0 => 2, 1 => 4, 2 => 0, 3 => 1, 4 => -2}, 4}})
    {:halt, 5}

    iex> Aoc.Day5.jump({:halt, 5})
    {:halt, 5}
  """
  def jump(res = {:halt, _steps}), do: res
  def jump({:cont, {offset, xs, steps}}) do
    {offset, xs} = Map.get_and_update(xs, offset, fn (x) -> {offset + x, x + 1} end)

    if is_nil(Map.get(xs, offset)) do
      {:halt, steps + 1}
    else
      {:cont, {offset, xs, steps + 1}}
    end
  end

  @doc """
  iex> Aoc.Day5.jumper({0, %{0 => 0, 1 => 3, 2 => 0, 3 => 1, 4 => -3}, 0}) |> Enum.take(6) |> List.last()
  {:halt, 5}
  """
  def jumper(xs) do
    Stream.unfold({:cont, xs}, &jump_gen/1)
  end

  def jump_gen(current) do
    {current, jump(current)}
  end
end
