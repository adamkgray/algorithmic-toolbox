defmodule Partition do
  @moduledoc """
  """

  require Table

  @doc """
  Calculate whether or not it is possible to partition a list of integers into list of equal sums

  ## Examples
  ```
  iex> Partition.possible?([1, 2, 4], 2)
  false

  iex> Partition.possible?([1, 2, 3, 4, 5, 5, 7, 7, 8, 10, 12, 19, 25], 3)
  true

  iex> Partition.possible?([17, 59, 34, 57, 17, 23, 67, 1, 18, 2, 59], 3)
  true

  ```
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
    |> List.last()
    |> List.last()
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

  # Part that actually does work
  @doc false
  def fill(table, i, j, max_i, max_j, values) do
    previous_column = j - 1
    last_value = Enum.at(values, previous_column)

    cond do
      # If some element is greater than sum/partition, fill last table value with false and trigger end condition.
      # It's never going to work
      Enum.at(values, j - 1) > max_i ->
        table
        |> Table.update_at({max_i, max_j}, false)
        |> fill(max_i + 1, j, max_i, max_j, values)

      # If the value at (i, j - 1) is true, then true
      Table.read(table, {i, previous_column}) ->
        table
        |> Table.update_at({i, j}, true)
        |> fill(i, j + 1, max_i, max_j, values)

      # If i equals the last value in the list up until this point, then true
      # Because is there is an element in the list that is equal to the amount we want to sum to
      # then we can always sum to it
      i == last_value ->
        table
        |> Table.update_at({i, j}, true)
        |> fill(i, j + 1, max_i, max_j, values)

      # If i is less then the last value in the list up until this point, then false
      # In other words, it couldn't do it with the list before, and this element is too big to change that
      i < last_value ->
        table
        |> Table.update_at({i, j}, false)
        |> fill(i, j + 1, max_i, max_j, values)

      # i is greater than the last value in the list, so it is possible that this new element will allow it to sum
      i > last_value ->
        table
        |> Table.update_at({i, j}, Table.read(table, {i - last_value, previous_column}))
        |> fill(i, j + 1, max_i, max_j, values)
    end
  end

end
