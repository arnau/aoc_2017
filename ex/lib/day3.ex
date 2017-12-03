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
  def solve(x) do
    distance(x)
  end

  @doc """
    iex> Aoc.Day3.distance(1)
    0

    iex> Aoc.Day3.distance(12)
    3
  """
  def distance(x) do
    cardinal_distance(x) + center_distance(x)
  end

  @doc """
  Rings:

  1    1
  2    9
  3    25
  4    49
  n    m = (2n - 1)^2
       sqrt(m) = 2n - 1
       (sqrt(m) + 1) / 2 = n

    iex> Aoc.Day3.ring(1)
    1

    iex> Aoc.Day3.ring(9)
    2

    iex> Aoc.Day3.ring(25)
    3

    iex> Aoc.Day3.ring(49)
    4

    iex> Aoc.Day3.ring(12)
    3

    iex> Aoc.Day3.ring(2)
    2

    iex> Aoc.Day3.ring(80)
    5
  """
  def ring(x) do
    ((:math.sqrt(x) + 1) / 2)
    |> Float.ceil()
    |> trunc()
  end

  @doc """
    iex> Aoc.Day3.cardinals(1)
    [1, 1, 1, 1]

    iex> Aoc.Day3.cardinals(2)
    [2, 4, 6, 8]

    iex> Aoc.Day3.cardinals(3)
    [11, 15, 19, 23]
  """
  def cardinals(ring) do
    [east(ring), north(ring), west(ring), south(ring)]
  end

  @doc """
    iex> Aoc.Day3.east(1)
    1

    iex> Aoc.Day3.east(2)
    2

    iex> Aoc.Day3.east(3)
    11
  """
  def east(ring), do:
    4 * :math.pow(ring, 2) - 11 * ring + 8 |> trunc()

  @doc """
    iex> Aoc.Day3.north(1)
    1

    iex> Aoc.Day3.north(2)
    4

    iex> Aoc.Day3.north(3)
    15
  """
  def north(ring) do
    4 * :math.pow(ring, 2) - 9  * ring + 6 |> trunc()
  end

  @doc """
    iex> Aoc.Day3.west(1)
    1

    iex> Aoc.Day3.west(2)
    6

    iex> Aoc.Day3.west(3)
    19
  """
  def west(ring) do
    4 * :math.pow(ring, 2) - 7  * ring + 4 |> trunc()
  end

  @doc """
    iex> Aoc.Day3.south(1)
    1

    iex> Aoc.Day3.south(2)
    8

    iex> Aoc.Day3.south(3)
    23
  """
  def south(ring) do
    4 * :math.pow(ring, 2) - 5  * ring + 2 |> trunc()
  end

  @doc """
    Smallest distance between the input and a cardinal.

    iex> Aoc.Day3.cardinal_distance(3)
    1

    iex> Aoc.Day3.cardinal_distance(12)
    1

    iex> Aoc.Day3.cardinal_distance(12)
    1

    iex> Aoc.Day3.cardinal_distance(25)
    2
  """
  def cardinal_distance(x) do
    ring(x)
    |> cardinals()
    |> Enum.map(&abs(&1 - x))
    |> Enum.min()
  end

  @doc """
  Distance to the center of the spiral (smallest ring).

    iex> Aoc.Day3.center_distance(1)
    0

    iex> Aoc.Day3.center_distance(2)
    1

    iex> Aoc.Day3.center_distance(12)
    2
  """
  def center_distance(x) do
    ring(x) - 1
  end
end
