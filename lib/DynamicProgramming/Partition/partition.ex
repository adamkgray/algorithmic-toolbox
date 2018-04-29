defmodule Partition do
  @moduledoc """
  """

  require Table


  @doc """
  Calculate whether or not it is possible to partition a list of integers into list of equal sums
  """
  @spec possible?(integer(), [integer()]) :: true | false
  def possible?(values, partition) do
    sum = Enum.sum(values)

    max_i = values
            |> Enum.sum()
            |> div(partition)

    max_j = length(values)

    possible?(values, partition, max_i, max_j, sum)
  end

  # If the sum of the list can not be cleany partitioned, return false
  @doc false
  def possible?(_values, partition, _max_i, _max_j, sum) when rem(sum, partition) != 0 do
    false
  end

  # Build table recursively to find solution
  @doc false
  def possible?(values, _partition, max_i, max_j, _sum) do
    Table.create(max_i, max_j, :partition)
    |> fill(0, 0, max_i, max_j, values)
  end

  # When we reach the final row, return
  @doc false
  def fill(table, i, _j, max_i, _max_j, _values) when i > max_i do
    table
  end

  # When we reach the final column, move to the next row
  @doc false
  def fill(table, i, j, max_i, max_j, values) when j > max_j do
    fill(table, i + 1, 0, max_i, max_j, values)
  end

  # Any list can always sum to 0
  @doc false
  def fill(table, i, j, max_i, max_j, values) when i == 0 do
    table
    |> Table.update_at({i, j}, true)
    |> fill(i, j + 1, max_i, max_j, values)
  end

  # An empty list can never amount to anything
  @doc false
  def fill(table, i, j, max_i, max_j, values) when j == 0 do
    table
    |> Table.update_at({i, j}, false)
    |> fill(i, j + 1, max_i, max_j, values)
  end

  # TODO: make it work for more than just 2-way partitions!
  # Part that actually does work
  @doc false
  def fill(table, i, j, max_i, max_j, values) do
    previous_column = j - 1
    last_value = Enum.at(values, previous_column)

    cond do
      Table.read(table, {i, previous_column}) ->
        table
        |> Table.update_at({i, j}, true)
        |> fill(i, j + 1, max_i, max_j, values)

      i == last_value ->
        table
        |> Table.update_at({i, j}, true)
        |> fill(i, j + 1, max_i, max_j, values)

      i < last_value ->
        table
        |> Table.update_at({i, j}, false)
        |> fill(i, j + 1, max_i, max_j, values)

      i > last_value ->
        table
        |> Table.update_at({i, j}, Table.read(table, {i - last_value, previous_column}))
        |> fill(i, j + 1, max_i, max_j, values)
    end
  end

end
