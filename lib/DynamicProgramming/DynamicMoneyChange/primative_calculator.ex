defmodule PrimativeCalculator do
  @moduledoc """
  Given an integer, find the fewest amount of steps necessary to change 1 into that integer,
  The possible operations are:
  1) Add 1
  2) Multiply by 2
  3) Multiply by 3

  Output is a list where the head is the number of steps necessary,
  and the tail consists of each step transforming 1 to the integer
  """

  def calc(n) when n == 0 or n == 1, do: [0, 1]

  @doc """
  Calculate the minimum number of steps necessary transform 1 into n

  ## Examples

    iex> PrimativeCalculator.calc(6)
    [2, 1, 3, 6]

    iex> PrimativeCalculator.calc(9)
    [2, 1, 3, 9]

  """
  def calc(n) when n > 1 do
    records = [[0, 1], [0, 1]]
    calc(n, 2, records)
  end

  def calc(_), do: "Input must be greater than or equal to 0"

  def calc(n, i, records) do
    # n - 1 always works
    index = i - 1
    number_of_operations = records
      |> Enum.at(index)
      |> List.first()
      |> Kernel.+(1)

    # consider dividing by 2
    {index, number_of_operations} = cond do
      rem(i, 2) == 0 and count(records, div(i, 2)) < number_of_operations
        -> {div(i, 2), count(records, div(i, 2))}
      true
        -> {index, number_of_operations}
    end

    # consider dividing by 3
    {index, number_of_operations} = cond do
      rem(i, 3) == 0 and count(records, div(i, 3)) < number_of_operations
        -> {div(i, 3), count(records, div(i, 3))}
      true
        -> {index, number_of_operations}
    end

    new_records = build_records(records, number_of_operations, index, i)

    cond do
      i == n -> List.last(new_records)
      true -> calc(n, i + 1, new_records)
    end
  end


  def build_records(records, number_of_operations, index, i) do
    [_ | steps] = Enum.at(records, index)
    record_to_add = [number_of_operations] ++ steps ++ [i]
    records ++ [record_to_add]
  end

  def count(records, index) do
    records
    |> Enum.at(index)
    |> List.first()
    |> Kernel.+(1)
  end
end
