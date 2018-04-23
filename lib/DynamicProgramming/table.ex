defmodule Table do
  @moduledoc """
  Create and update values for a 2-d table for dynamic programming algorithms
  """

  @doc """
  Initialize a 2-d from two params

  ## Paramters

    ### edit disatnce
      - str_one: String
      - str_two: String

    ### discrete knapsack
      - weight = Integer
      - items = List of integer key-value pairs

  ## Return
    - table: list of lists

  ## Examples

    iex> Table.create("abcd", "efgh", :edit_distance)
    [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]

    iex> Table.create(5, [{2, 2}, {3, 3}, {4, 4}, {5, 5}], :knapsack)
    [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ]

  """
  def create(str_one, str_two, :edit_distance) do
    rows = String.length(str_one)
    columns = String.length(str_two)
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  @doc false
  def create(weight, items, :knapsack) do
    rows = length(items)
    columns = weight
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  @doc """
  Read the value from a table at a given set of coordinates
  """
  def read(table, {row, column}) do
    table
    |> Enum.at(row)
    |> Enum.at(column)
  end

  @doc """
  Update the value of a table at a given set of coordinates
  """
  def update_at(table, {row, column}, value) do
    updated_row = table
      |> Enum.at(row)
      |> List.replace_at(column, value)

    List.replace_at(table, row, updated_row)
  end
end
