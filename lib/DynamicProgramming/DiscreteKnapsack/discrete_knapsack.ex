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
  def discrete_knapsack(weight, items) do
    max_row = length(items)
    max_column = weight + 1

    # Initialize empty table
    Table.create(weight, items, :knapsack)
    # Iterate through strings to fill table with edit values
    |> fill(0, 0, max_row, max_column, weight, items)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, return
  @doc false
  def fill(table, row, _, max_row, _, _, _) when row > max_row, do: table

  # When we reach the final column, move to the next row
  @doc false
  def fill(table, row, column, max_row, max_column, weight, items) when column > max_column do
    fill(table, row + 1, 0, max_row, max_column, weight, items)
  end

  @doc """
  Make an edit at the given (row, column) coordinate and move to the next column
  """
  def fill(table, row, column, max_row, max_column, weight, items) do
    item = Enum.at(items, row - 1)

    table
    |> Table.update_at({row, column}, edit(table, row, column, item))
    |> fill(row, column + 1, max_row, max_column, weight, items)
  end

  # When there are no items, no value can be added
  @doc false
  def edit(_, row, _, _) when row == 0, do: 0

  # When max weight is zero, no value can be added
  @doc false
  def edit(_, _, column, _) when column == 0, do: 0

  # When the item's weight is too much for the given weight, take prevoius value
  @doc false
  def edit(table, row, column, {weight, _}) when weight > column do
    Table.read(table, {row - 1, column})
  end

  @doc """
  Compute the maximum value for a given weight in a table

  Return value is the maximum of ->
  A: The item's value plus the already computed value at (row - weight)
  B: The value when the given item's value is flat out ignored, i.e. the value at (row, column - 1)

  """
  def edit(table, row, column, {weight, value}) when weight <= column  do
    with_weight = table
      |> Table.read({row - 1, column - weight})
      |> Kernel.+(value)

    previous_value = Table.read(table, {row - 1, column})

    Enum.max([with_weight, previous_value])
  end

  @doc """
  Sort a keyword list of items by weight

  ## Examples

    iex(2)> DiscreteKnapsack.sort([{20, 1}, {10, 1}, {50, 1}, {15, 1}, {40, 1}])
    [{10, 1}, {15, 1}, {20, 1}, {40, 1}, {50, 1}]

  """
  def sort(items) do
    require QuickSortBy
    QuickSortBy.sort(items, &compare/2)
  end

  @doc false
  def compare({a, _}, {b, _}) do
    a > b
  end
end
