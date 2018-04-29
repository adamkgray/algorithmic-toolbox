defmodule Table do
  @moduledoc """
  Create and update values a 2-d table for dynamic programming algorithms

  ## Examples
  ```
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

  ```
  """

  @doc """
  Initialize a 2-d table from two strings
  """
  @spec create(String.t, String.t, :edit_distance) :: [[0]]
  def create(str_one, str_two, :edit_distance) do
    rows = String.length(str_one)
    columns = String.length(str_two)
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  @doc """
  Initialize a 2-d table from a weight and list of items
  """
  @spec create(integer(), [integer()], :knapsack) :: [[0]]
  def create(weight, items, :knapsack) do
    rows = length(items)
    columns = weight
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  @doc """
  Initialize a 2-d table from two integers
  """
  @spec create(integer(), integer(), :partition) :: [[0]]
  def create(rows, columns, :partition) do
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  @doc """
  Read the value from a table at a given set of coordinates
  """
  @spec read([[any()]], {integer(), integer()}) :: [[any()]]
  def read(table, {row, column}) do
    table
    |> Enum.at(row)
    |> Enum.at(column)
  end

  @doc """
  Update the value of a table at a given set of coordinates
  """
  @spec update_at([[any()]], {integer(), integer()}, any()) :: [[any()]]
  def update_at(table, {row, column}, value) do
    updated_row = table
      |> Enum.at(row)
      |> List.replace_at(column, value)

    List.replace_at(table, row, updated_row)
  end
end
