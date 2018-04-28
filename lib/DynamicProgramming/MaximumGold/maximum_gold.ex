defmodule MaximumGold do
  @moduledoc """
  """

  require Table

  @doc """
  ## Examples

    iex(16)> MaximumGold.max(6, [3, 3, 4, 1])
    6

  """
  def max(weight, bars) do
    max_column = weight + 1
    max_row = length(bars)

    # Initialize empty table
    Table.create(weight, bars, :knapsack)
    # Iterate through strings to fill table with edit values
    |> fill(0, 0, max_row, max_column, bars)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, return
  @doc false
  def fill(table, row, _, max_row, _, _) when row > max_row, do: table

  # When we reach the final column, move to the next row
  @doc false
  def fill(table, row, column, max_row, max_column, bars) when column > max_column do
    fill(table, row + 1, 0, max_row, max_column, bars)
  end

  @doc """
  Make an edit at the given (row, column) coordinate and move to the next column
  """
  def fill(table, row, column, max_row, max_column, bars) do
    bar = Enum.at(bars, row - 1)
    new_edit = edit(table, row, column, bar)

    Table.update_at(table, {row, column}, new_edit)
    |> fill(row, column + 1, max_row, max_column, bars)
  end

  # When there are no bars, nothing can be added
  @doc false
  def edit(_, row, _, _) when row == 0, do: 0

  # When max weight is zero, no bars can be added
  @doc false
  def edit(_, _, column, _) when column == 0, do: 0

  # When the bar's weight is too much for the given weight, take prevoius value
  @doc false
  def edit(table, row, column, bar) when bar > column do
    Table.read(table, {row - 1, column})
  end

  @doc """
  Compute the maximum value for a given bar in a table

  Return value is the maximum of ->
  A: The bar's value plus the already computed value at (row - weight)
  B: The value when the given bar's value is flat out ignored, i.e. the value at (row, column - 1)

  """
  def edit(table, row, column, bar) when bar <= column  do
    with_bar = table
      |> Table.read({row - 1, column - bar})
      |> Kernel.+(bar)

    previous_value = Table.read(table, {row - 1, column})

    Enum.max([with_bar, previous_value])
  end
end
