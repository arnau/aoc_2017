defmodule Aoc.Day4 do
  @doc """
  http://adventofcode.com/2017/day/4


    iex> Aoc.Day4.solve(["aa bb cc dd ee"])
    1

    iex> Aoc.Day4.solve(["aa bb cc dd ee", "aa bb cc dd aa"])
    1

    iex> Aoc.Day4.solve(["aa bb cc dd ee", "aa bb cc dd aa", "aa bb cc dd aaa"])
    2
  """
  def solve(xs) do
    xs
    |> Stream.map(&String.split/1)
    |> Stream.map(&is_valid/1)
    |> Enum.filter(&(&1))
    |> length()
  end

  def solve_b(xs) do
    xs
    |> Stream.map(&String.split/1)
    |> Stream.map(&is_valid(&1, :no_anagrams))
    |> Enum.filter(&(&1))
    |> length()
  end

  @doc """
    iex> Aoc.Day4.is_valid(["aa", "bb", "cc", "dd", "ee"])
    true

    iex> Aoc.Day4.is_valid(["aa", "bb", "cc", "dd", "aa"])
    false

    iex> Aoc.Day4.is_valid(["aa", "bb", "cc", "dd", "aaa"])
    true

    iex> Aoc.Day4.is_valid(["aa", "bb", "cc", "dd", "ee"], :no_anagrams)
    true

    iex> Aoc.Day4.is_valid(["aab", "baa"], :no_anagrams)
    false
  """
  def is_valid(words) do
    length(words) == length(Enum.uniq(words))
  end

  def is_valid(words, :no_anagrams) do
    words = Enum.map(words, fn (word) -> word |> String.graphemes() |> Enum.sort()  end)

    length(words) == length(Enum.uniq(words))
  end
end
