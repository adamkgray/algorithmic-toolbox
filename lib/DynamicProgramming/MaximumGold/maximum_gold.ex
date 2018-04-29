defmodule MaximumGold do
  @moduledoc """
  Given a bag of weight W, and a set of gold bars (each of some weight),
  find the most weight that can be put in the bag without going over and using each bar once.
  """

  require Table

  @doc """
  Compute optimal weight that can be put in bag.

  ## Examples
  ```
  iex(16)> MaximumGold.max(6, [3, 3, 4, 1])
  6

  ```
  """
  @spec max(integer(), [integer()]) :: integer()
  def max(weight, bars) do
    max_j = weight + 1
    max_i = length(bars)

    # Initialize empty table
    Table.create(weight, bars, :knapsack)
    # Iterate through strings to fill table with edit values
    |> fill(0, 0, max_i, max_j, bars)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, return
  @doc false
  def fill(table, i, _j, max_i, _max_j, _bars) when i > max_i, do: table

  # When we reach the final column, move to the next row
  @doc false
  def fill(table, i, j, max_i, max_j, bars) when j > max_j do
    fill(table, i + 1, 0, max_i, max_j, bars)
  end

  # Make an edit at the given (row, column) coordinate and move to the next column
  @doc false
  def fill(table, i, j, max_i, max_j, bars) do
    bar = Enum.at(bars, i - 1)
    new_edit = edit(table, i, j, bar)

    Table.update_at(table, {i, j}, new_edit)
    |> fill(i, j + 1, max_i, max_j, bars)
  end

  # When there are no bars, nothing can be added
  @doc false
  def edit(_table, i, _j, _bar) when i == 0, do: 0

  # When max weight is zero, no bars can be added
  @doc false
  def edit(_table, _i, j, _bar) when j == 0, do: 0

  # When the bar's weight is too much for the given weight, take prevoius value
  @doc false
  def edit(table, i, j, bar) when bar > j do
    Table.read(table, {i - 1, j})
  end

  # Compute the maximum value for a given bar in a table
  #
  # Return value is the maximum of:
  # A) The bar's value plus the already computed value at (row - weight)
  # B) The value when the given bar's value is flat out ignored, i.e. the value at (row, column - 1)
  @doc false
  def edit(table, i, j, bar) when bar <= j  do
    with_bar = table
      |> Table.read({i - 1, j - bar})
      |> Kernel.+(bar)

    previous_value = Table.read(table, {i - 1, j})

    Enum.max([with_bar, previous_value])
  end
end
