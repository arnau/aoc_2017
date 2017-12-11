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
    find_root(programs)
  end

  @doc """
    iex> Aoc.Day7.solve_b([
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
    {:error, {41, [{72, 243}, {45, 243}, {68, 251}]}, 60}
  """
  def solve_b(xs) do
    xs
    |> Enum.map(&parse_program/1)
    |> to_tree()
    |> find_sum()
  end

  @doc """
    iex> Aoc.Day7.find_sum({"tknk", {41,
    ...>     [{"ugml",
    ...>       {68,
    ...>        [{"gyxo", {61, []}}, {"ebii", {61, []}}, {"jptl", {61, []}}]}},
    ...>      {"padx",
    ...>       {45,
    ...>        [{"pbga", {66, []}}, {"havc", {66, []}}, {"qoyq", {66, []}}]}},
    ...>      {"fwft",
    ...>       {72,
    ...>        [{"ktlj", {57, []}}, {"cntj", {57, []}},
    ...>         {"xhth", {57, []}}]}}]}})
    {:error, {41, [{72, 243}, {45, 243}, {68, 251}]}, 60}

  """
  def find_sum({_, {weight, disc}}) do
    with {:ok, sums} <- (disc |> Enum.map(&find_sum/1) |> combine_results()) do
      uniqs = Enum.uniq_by(sums, &elem(&1, 1))

      if length(uniqs) > 1 do
        {:error, {weight, sums}, find_balance(uniqs)}
      else
        sum = sums |> Enum.map(fn {w, s} -> s end) |> Enum.sum()
        {:ok, {weight, weight + sum}}
      end
    else
      e -> e
    end
  end

  @doc """
    iex> Aoc.Day7.find_balance([{72, 243}, {68, 251}])
    60
  """
  def find_balance(xs) do
    [{w, dsc}, {_, right}] = Enum.sort(xs, fn ({_, a}, {_, b}) -> a >= b end)

    right - (dsc - w)
  end

  @doc """
    iex> Aoc.Day7.combine_results(
    ...>  [{:ok, {7524, 8094}}, {:ok, {2628, 8094}}, {:ok, {7179, 8094}},
    ...>   {:error,
    ...>     {24, [{666, 1614}, {1215, 1623}, {504, 1614}, {579, 1614}, {58, 1614}]},
    ...>       1206}, {:ok, {5247, 8094}}, {:ok, {7330, 8094}}, {:ok, {7596, 8094}}])
    {:error,
      {24, [{666, 1614}, {1215, 1623}, {504, 1614}, {579, 1614}, {58, 1614}]}, 1206}

    iex> Aoc.Day7.combine_results([{:ok, {7524, 8094}}, {:ok, {2628, 8094}}])
    {:ok, [{2628, 8094}, {7524, 8094}]}

    iex> Aoc.Day7.combine_results([{:ok, {7524, 8094}}, {:error, {24, [{666, 1614}, {1215, 1623}, {504, 1614}, {579, 1614}, {58, 1614}]}, 1206}])
    {:error, {24, [{666, 1614}, {1215, 1623}, {504, 1614}, {579, 1614}, {58, 1614}]}, 1206}
  """
  def combine_results(xs) do
    xs
    |> Enum.reduce_while({:ok, []}, fn
      ({:ok, x}, {:ok, xs}) -> {:cont, {:ok, [x | xs]}}
      (e = {:error, _, _}, _) -> {:halt, e}
    end)
  end

  @doc """
    iex> Aoc.Day7.to_tree([
    ...>   {"pbga", {66, []}},
    ...>   {"xhth", {57, []}},
    ...>   {"ebii", {61, []}},
    ...>   {"havc", {66, []}},
    ...>   {"ktlj", {57, []}},
    ...>   {"fwft", {72, ["ktlj", "cntj", "xhth"]}},
    ...>   {"qoyq", {66, []}},
    ...>   {"padx", {45, ["pbga", "havc", "qoyq"]}},
    ...>   {"tknk", {41, ["ugml", "padx", "fwft"]}},
    ...>   {"jptl", {61, []}},
    ...>   {"ugml", {68, ["gyxo", "ebii", "jptl"]}},
    ...>   {"gyxo", {61, []}},
    ...>   {"cntj", {57, []}},
    ...> ])
    {"tknk", {41,
             [{"ugml",
               {68,
                [{"gyxo", {61, []}}, {"ebii", {61, []}}, {"jptl", {61, []}}]}},
              {"padx",
               {45,
                [{"pbga", {66, []}}, {"havc", {66, []}}, {"qoyq", {66, []}}]}},
              {"fwft",
               {72,
                [{"ktlj", {57, []}}, {"cntj", {57, []}},
                 {"xhth", {57, []}}]}}]}}

    iex> Aoc.Day7.to_tree("pbga", %{"pbga" => {66, []}})
    {"pbga", {66, []}}

    iex> Aoc.Day7.to_tree("padx", %{
    ...> "pbga" => {66, []},
    ...> "padx" => {45, ["pbga", "havc", "qoyq"]},
    ...> "havc" => {66, []},
    ...> "qoyq" => {66, []},
    ...> })
    {"padx", {45, [{"pbga", {66, []}}, {"havc", {66, []}}, {"qoyq", {66, []}}]}}
  """
  def to_tree(xs) do
    map = Map.new(xs)
    name = find_root(xs)

    to_tree(name, map)
  end
  def to_tree(name, xs) do
    {weight, disc} = Map.get(xs, name)
    {name, {weight, Enum.map(disc, &to_tree(&1, xs))}}
  end

  def find_root(programs) do
    names = Enum.map(programs, &elem(&1, 0))
    discs = Enum.reduce(programs, [], fn ({_, {_, x}}, acc) -> x ++ acc  end)

    List.first(names -- discs)
  end

  @doc """
    iex> Aoc.Day7.parse_program("pbga (66)")
    {"pbga", {66, []}}

    iex> Aoc.Day7.parse_program("tknk (41) -> ugml, padx, fwft")
    {"tknk", {41, ["ugml", "padx", "fwft"]}}
  """
  def parse_program(raw) do
    [program | disc] = String.split(raw, "->")
    {name, weight} = program |> String.split() |> List.to_tuple()

    {name, {parse_weight(weight), parse_disc(disc)}}
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
