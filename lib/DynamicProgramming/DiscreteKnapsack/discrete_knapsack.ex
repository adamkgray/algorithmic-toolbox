defmodule DiscreteKnapsack do
  @moduledoc """
  Given a knapsack of max weight W, and a list of items with weights-values,
  find the maximum amount of value that can be put into the knapsack without going
  over W, using each item whole and only once
  """

  require Table

  @doc """
  Compute the maximum value for the discrete knapsack problem
  """
  @spec discrete_knapsack(integer(), [{integer(), integer()}]) :: integer()
  def discrete_knapsack(weight, items) do
    max_i = length(items)
    max_j = weight + 1

    # Initialize empty table
    Table.create(weight, items, :knapsack)
    # Iterate through strings to fill table with edit values
    |> fill(0, 0, max_i, max_j, weight, items)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, return
  @doc false
  def fill(table, i, _j, max_i, _max_j, _weight, _items) when i > max_i, do: table

  # When we reach the final column, move to the next row
  @doc false
  def fill(table, i, j, max_i, max_j, weight, items) when j > max_j do
    fill(table, i + 1, 0, max_i, max_j, weight, items)
  end

  # Make an edit at the given (row, column) coordinate and move to the next column
  @doc false
  def fill(table, i, j, max_i, max_j, weight, items) do
    item = Enum.at(items, i - 1)

    table
    |> Table.update_at({i, j}, edit(table, i, j, item))
    |> fill(i, j + 1, max_i, max_j, weight, items)
  end

  # When there are no items, no value can be added
  @doc false
  def edit(_table, i, _j, _item) when i == 0, do: 0

  # When max weight is zero, no value can be added
  @doc false
  def edit(_table, _i, j, _item) when j == 0, do: 0

  # When the item's weight is too much for the given weight, take the value above in the table
  @doc false
  def edit(table, i, j, {weight, _}) when weight > j do
    Table.read(table, {i - 1, j})
  end

  # Compute the maximum value for a given weight in a table
  #
  # Return value is the maximum of:
  # A) The item's value plus the already computed value at (row - weight)
  # B) The value when the given item's value is flat out ignored, i.e. the value at (row, column - 1)
  @doc false
  def edit(table, i, j, {weight, value}) when weight <= j  do
    with_weight = table
      |> Table.read({i - 1, j - weight})
      |> Kernel.+(value)

    previous_value = Table.read(table, {i - 1, j})

    Enum.max([with_weight, previous_value])
  end
end
