defmodule Partition do
  @moduledoc """
  Given a list, determine whether or not it is possible to partition the list into n subsets of equal sums.
  """

  require Table

  @doc """
  Calculate whether or not it is possible to partition a list of integers into n subsets of equal sums.

  ## Examples
  ```
  iex> Partition.possible?([4, 4], 2)
  true

  iex> Partition.possible?([1, 2, 4], 2)
  false

  iex> Partition.possible?([4, 5, 6, 7, 8], 3)
  false

  iex> Partition.possible?([3, 3, 1, 3, 2], 4)
  true

  ```
  """
  @spec possible?([integer()], integer()) :: true | false
  def possible?(values, partition) do
    sum = Enum.sum(values)

    max_i = values
            |> Enum.sum()
            |> div(partition)

    max_j = length(values)

    do_possible?(values, partition, max_i, max_j, sum)
  end

  # If the sum of the list can not be cleany partitioned, return false
  @doc false
  def do_possible?(_values, partition, _max_i, _max_j, sum) when rem(sum, partition) != 0 do
    false
  end

  # Build table recursively to find solution
  # 2 way partitions are fool-proof, and require no further investigation
  @doc false
  def do_possible?(values, partition, max_i, max_j, _sum) when partition <= 2 do
    Table.create(max_i, max_j, :partition)
    |> fill(0, 0, max_i, max_j, values)
    |> List.last()
    |> List.last()
    |> elem(0)
  end

  # Build table recursively to find solution
  # If it works for this, confirm by reducing until it becomes a two-way
  @doc false
  def do_possible?(values, partition, max_i, max_j, _sum) when partition > 2 do
    {possible, used} = Table.create(max_i, max_j, :partition)
      |> fill(0, 0, max_i, max_j, values)
      |> List.last()
      |> List.last()

    case possible do
      false -> false
      true -> true and possible?(filter(values, used), partition - 1)
    end
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
    |> Table.update_at({i, j}, {true, [0]})
    |> fill(i, j + 1, max_i, max_j, values)
  end

  # An empty list can never amount to anything
  @doc false
  def fill(table, i, j, max_i, max_j, values) when j == 0 do
    table
    |> Table.update_at({i, j}, {false, []})
    |> fill(i, j + 1, max_i, max_j, values)
  end

  # Part that actually does work
  @doc false
  def fill(table, i, j, max_i, max_j, values) do
    previous_column = j - 1
    last_value = Enum.at(values, previous_column)

    cond do
      # If some element is greater than sum/partition, fill last table value with false and trigger end condition.
      # It's never going to work.
      Enum.at(values, j - 1) > max_i ->
        table
        |> Table.update_at({max_i, max_j}, {false, []})
        |> fill(max_i + 1, j, max_i, max_j, values)

      # If the value at (i, j - 1) is true, then true and previous used.
      Table.read(table, {i, previous_column}) |> elem(0) ->
        table
        |> Table.update_at({i, j}, {
          true,
          table
          |> Table.read({i, previous_column})
          |> elem(1)
        })
        |> fill(i, j + 1, max_i, max_j, values)

      # If i equals the last value in the list up until this point, then true and use just that value
      # Because if there is an element in the list that is equal to the amount we want to sum to,
      # then we can always sum to it.
      i == last_value ->
        table
        |> Table.update_at({i, j}, {true, [last_value]})
        |> fill(i, j + 1, max_i, max_j, values)

      # If i is less than the last value in the list up until this point, then false.
      # In other words, it couldn't do it with the list before, and this element is too big to change that.
      i < last_value ->
        table
        |> Table.update_at({i, j}, {false, []})
        |> fill(i, j + 1, max_i, max_j, values)

      # i is greater than the last value in the list, so it is possible that this new element will allow it to sum.
      # Inlcude the previously used stuff always, it wont matter if the first value is false anyways.
      i > last_value ->
        table
        |> Table.update_at({i, j}, {
          Table.read(table, {i - last_value, previous_column})
          |> elem(0),
          table
          |> Table.read({i - last_value, previous_column})
          |> elem(1)
          |> Kernel.++([last_value])
        })
        |> fill(i, j + 1, max_i, max_j, values)
    end
  end

  # filter out the values that were used to sum to a given amount
  @doc false
  def filter(values, [head | tail]) do
    values
    |> List.delete(head)
    |> filter(tail)
  end

  @doc false
  def filter(values, []), do: values
end
