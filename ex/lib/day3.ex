defmodule Aoc.Day3 do
  @doc """
  http://adventofcode.com/2017/day/3

  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...


    iex> Aoc.Day3.solve(1)
    0

    iex> Aoc.Day3.solve(12)
    3

    iex> Aoc.Day3.solve(23)
    2

    iex> Aoc.Day3.solve(1024)
    31

    iex> Aoc.Day3.solve(312051)
    430
  """
  def solve(1), do: 0
  def solve(x) do
    {x, y} = coord_stream() |> Stream.drop(x - 1) |> Enum.take(1) |> List.first()

    abs(y) + abs(x)
  end

  @doc """
    iex> Aoc.Day3.solve_b(4)
    5

    iex> Aoc.Day3.solve_b(747)
    806

    iex> Aoc.Day3.solve_b(312051)
    312453
  """
  def solve_b(x) when x > 0 do
    {_, res} = grid(x) |> List.first()

    res
  end

  @doc """
    iex> Aoc.Day3.grid(1)
    [{{1, 1}, 2},{{1, 0}, 1},{{0, 0}, 1}]

    iex> Aoc.Day3.grid(2)
    [{{0, 1}, 4},{{1, 1}, 2},{{1, 0}, 1},{{0, 0}, 1}]

    iex> Aoc.Day3.grid(4) |> List.first()
    {{-1, 1}, 5}

    iex> Aoc.Day3.grid(11) |> List.first()
    {{0, -1}, 23}
  """
  def grid(x) when x > 0 do
    coord_stream()
    |> Enum.reduce_while([], fn (coord, acc) ->
      prev = with {_, n} <- List.first(acc), do: n, else: (nil -> 0)

      curr = Enum.sum(neighbours(coord, acc))

      if prev <= x do
        {:cont, [{coord, curr} | acc]}
      else
        {:halt, acc}
      end
    end)
  end

  @doc """
    iex> Aoc.Day3.neighbours({0, 0}, [])
    [1]

    iex> Aoc.Day3.neighbours({1, 0}, [{{0, 0}, 1}])
    [1]

    iex> Aoc.Day3.neighbours({-1, 0}, [{{0, 0}, 1},{{1, 0}, 1},{{1, 1}, 2},{{0, 1}, 4},{{-1, 1}, 5}])
    [1, 4, 5]
  """
  def neighbours({0, 0}, _), do: [1]
  def neighbours({x, y}, xs) do
    Enum.flat_map(xs, fn ({coord, n}) ->
      is_neighbour = surroundings()
                     |> Enum.map(fn ({x_s, y_s}) -> {x + x_s, y + y_s} == coord end)
                     |> Enum.any?()

      if is_neighbour, do: [n], else: []
    end)
  end

  def surroundings() do
    [{-1, +1}, {0, +1}, {+1, +1},
     {-1,  0},          {+1,  0},
     {-1, -1}, {0, -1}, {+1, -1}]
  end

  @doc """
    iex> Aoc.Day3.next_coord(%{x: 0, y: 0, op: 1, count: 0, limit: 2})
    %{x: 1, y: 0, op: 1, count: 1, limit: 2}

    iex> Aoc.Day3.next_coord(%{x: 1, y: 0, op: 1, count: 1, limit: 2})
    %{x: 1, y: 1, op: -1, count: 0, limit: 4}

    iex> Aoc.Day3.next_coord(%{x: 0, y: 1, op: -1, count: 1, limit: 4})
    %{x: -1, y: 1, op: -1, count: 2, limit: 4}

    iex> Aoc.Day3.next_coord(%{x: -1, y: 1, op: -1, count: 2, limit: 4})
    %{x: -1, y: 0, op: -1, count: 3, limit: 4}
  """
  def next_coord(state = %{x: x, op: op, count: count, limit: limit}) when count < (limit / 2) do
    state
    |> Map.put(:x, x + op)
    |> Map.put(:count, count + 1)
  end
  def next_coord(state = %{y: y, op: op, count: count, limit: limit}) do
    state = state
    |> Map.put(:y, y + op)
    |> Map.put(:count, count + 1)

    if state[:count] == limit do
      state
      |> Map.put(:op, op * -1)
      |> Map.put(:limit, limit + 2)
      |> Map.put(:count, 0)
    else
      state
    end
  end

  @doc """
  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...

  k = 1, x = 0, y = 0   op = (+1), s = 1, v = :x
  inc x
  k = 2, x = 1, y = 0
  inc y
  k = 3, x = 1, y = 1
  dec x
  k = 4, x = 0, y = 1
  dec x
  k = 5, x = -1, y = 1
  dec y
  k = 6, x = -1, y = 0
  dec y
  k = 7, x = -1, y = -1

    iex> Aoc.Day3.coord_stream() |> Enum.take(1)
    [{0, 0}]

    iex> Aoc.Day3.coord_stream() |> Enum.take(3)
    [{0, 0},{1, 0},{1, 1}]

    iex> Aoc.Day3.coord_stream() |> Stream.drop(4) |> Enum.take(1)
    [{-1, 1}]

    iex> Aoc.Day3.coord_stream() |> Stream.drop(11) |> Enum.take(1)
    [{2, 1}]
  """
  def coord_stream() do
    Stream.unfold(%{x: 0, y: 0, op: 1, count: 0, limit: 2}, &coord_gen/1)
  end

  defp coord_gen(current = %{x: x, y: y}) do
    next = next_coord(current)

    {{x, y}, next}
  end
end
