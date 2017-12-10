defmodule Aoc.Day7 do
  @doc """
  http://adventofcode.com/2017/day/7

    iex> Aoc.Day7.solve([
    ...>   "pbga (66)",
    ...>   "xhth (57)",
    ...>   "ebii (61)",
    ...>   "havc (66)",
    ...>   "ktlj (57)",
    ...>   "fwft (72) -> ktlj, cntj, xhth",
    ...>   "qoyq (66)",
    ...>   "padx (45) -> pbga, havc, qoyq",
    ...>   "tknk (41) -> ugml, padx, fwft",
    ...>   "jptl (61)",
    ...>   "ugml (68) -> gyxo, ebii, jptl",
    ...>   "gyxo (61)",
    ...>   "cntj (57)",
    ...> ])
    "tknk"
  """
  def solve(xs) do
    programs = Enum.map(xs, &parse_program/1)
    names = Enum.map(programs, &elem(&1, 1))
    discs = Enum.reduce(programs, [], fn ({_, _, x}, acc) -> x ++ acc  end)

    List.first(names -- discs)
  end

  @doc """
    iex> Aoc.Day7.parse_program("pbga (66)")
    {66, "pbga", []}

    iex> Aoc.Day7.parse_program("tknk (41) -> ugml, padx, fwft")
    {41, "tknk", ["ugml", "padx", "fwft"]}
  """
  def parse_program(raw) do
    [program | disc] = String.split(raw, "->")
    {name, weight} = program |> String.split() |> List.to_tuple()

    {parse_weight(weight), name, parse_disc(disc)}
  end

  @doc """
    iex> Aoc.Day7.parse_weight("(66)")
    66
  """
  def parse_weight(raw) do
    raw
    |> String.trim_leading("(")
    |> String.trim_trailing(")")
    |> String.to_integer()
  end

  def parse_disc([]), do: []
  def parse_disc([str]) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
  end
end
