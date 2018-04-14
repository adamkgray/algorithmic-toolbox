defmodule PrimativeCalculator do
  @moduledoc """
  operators are +1, *2, *3
  """

  def calc(n) when n == 0 or n == 1, do: [0, 1]

  def calc(n) when n > 1 do
    records = [[0, 1], [0, 1]]
    calc(n, 2, records)
  end

  def calc(_), do: "Input must be greater than or equal to 0"

  def calc(n, i, records) do
    # n - 1 always works
    number_of_operations = records
      |> Enum.at(i - 1)
      |> List.first()
      |> Kernel.+(1)

    # consider dividing by 2
    number_of_operations = cond do
      rem(i, 2) == 0 and count(records, div(i, 2)) < number_of_operations
        -> count(records, div(i, 2))
      true
        -> number_of_operations
    end

    # consider dividing by 3
    number_of_operations = cond do
      rem(i, 3) == 0 and count(records, div(i, 3)) < number_of_operations
        -> count(records, div(i, 3))
      true
        -> number_of_operations
    end

    new_records = build_records(records, number_of_operations, i)
    IO.inspect(records)

    cond do
      i == n -> List.last(new_records)
      true -> calc(n, i + 1, new_records)
    end
  end


  def build_records(records, number_of_operations, i) do
    IO.inspect {"i", i, "#/op", number_of_operations}
    [_ | steps] = Enum.at(records, number_of_operations)
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
