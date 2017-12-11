defmodule Aoc.Day8 do
  @doc """
  http://adventofcode.com/2017/day/8

    iex> Aoc.Day8.solve(["b inc 5 if a > 1",
    ...>                 "a inc 1 if b < 5",
    ...>                 "c dec -10 if a >= 1",
    ...>                 "c inc -20 if c == 10"])
    1
  """
  def solve(xs) do
    xs
    |> Enum.map(&parse_statement/1)
    |> process()
    |> elem(0)
    |> Map.values()
    |> Enum.max()
  end

  @doc """
    iex> Aoc.Day8.solve_b(["b inc 5 if a > 1",
    ...>                   "a inc 1 if b < 5",
    ...>                   "c dec -10 if a >= 1",
    ...>                   "c inc -20 if c == 10"])
    10
  """
  def solve_b(xs) do
    xs
    |> Enum.map(&parse_statement/1)
    |> process()
    |> elem(1)
  end

  @doc """
    iex> Aoc.Day8.process([{"b", "inc", 5, "a", ">", 1},
    ...>                   {"a", "inc", 1, "b", "<", 5},
    ...>                   {"c", "dec", -10, "a", ">=", 1},
    ...>                   {"c", "inc", -20, "c", "==", 10}])
    {%{"a" => 1, "c" => -10}, 10}
  """
  def process(xs) do
    xs
    |> Enum.reduce({%{}, 0}, &process_statement/2)
  end

  @doc """
    iex> Aoc.Day8.process_statement({"b", "inc", 5, "a", ">", 1}, {%{}, 0})
    {%{}, 0}

    iex> Aoc.Day8.process_statement({"a", "inc", 1, "b", "<", 5}, {%{}, 0})
    {%{"a" => 1}, 1}

    iex> Aoc.Day8.process_statement({"c", "dec", -10, "a", ">=", 1}, {%{"a" => 1}, 1})
    {%{"a" => 1, "c" => 10}, 10}

    iex> Aoc.Day8.process_statement({"c", "inc", -20, "c", "==", 10}, {%{"a" => 1, "c" => 10}, 10})
    {%{"a" => 1, "c" => -10}, 10}
  """
  def process_statement({reg, op, value, reg2, ord, b}, {acc, max}) do
    if ord(ord, Map.get(acc, reg2, 0), b) do
      acc_ = Map.update(acc, reg, op(op, 0, value), &op(op, &1, value))
      max_ = acc_ |> Map.values() |> Enum.max()
      {acc_, Enum.max([max, max_])}
    else
      {acc, max}
    end
  end

  @doc """
    iex> Aoc.Day8.parse_statement("b inc 5 if a > 1")
    {"b", "inc", 5, "a", ">", 1}
  """
  def parse_statement(statement) do
    [reg, op, value, "if", reg2, ord, b] = String.split(statement)
    {reg, op, String.to_integer(value), reg2, ord, String.to_integer(b)}
  end

  @doc """
    iex> Aoc.Day8.op("inc", 0, 5)
    5

    iex> Aoc.Day8.op("inc", 5, 2)
    7
  """
  def op("inc", reg, value) do
    reg + value
  end
  def op("dec", reg, value) do
    reg - value
  end

  @doc """
    iex> Aoc.Day8.ord(">", 1, 2)
    false
  """
  def ord(">", a, b), do: a > b
  def ord("<", a, b), do: a < b
  def ord("<=", a, b), do: a <= b
  def ord(">=", a, b), do: a >= b
  def ord("==", a, b), do: a == b
  def ord("!=", a, b), do: a != b
end
