defmodule EditDistance do
  @moduledoc """
  Given two strings, find the minimum number of edits necessary to transform one string into the other
  """

  require Table

  @doc """
  Compute the edit distance between two strings

  ## Parameters
    - str_one: String
    - str_two: String

  ## Return
    - edit_distance: Integer

  ## Examples

    iex> EditDistance.edit_distance("ports", "short")
    3

    iex> EditDistance.edit_distance("same", "same")
    0

    iex> EditDistance.edit_distance("Spain", "Spaain")
    1

  """
  def edit_distance(str_one, str_two) do
    max_row_index = String.length(str_one)
    max_column_index = String.length(str_two)

    # Initialize empty table
    Table.create(str_one, str_two, :edit_distance)
    # Iterate through strings to fill table with edit values
    |> fill(str_one, str_two, 0, 0, max_row_index, max_column_index)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, the table is finished
  @doc false
  def fill(table, _, _, row_index, _, max_row_index, _) when row_index > max_row_index, do: table

  # When we reach the final colum, move to the next row
  @doc false
  def fill(table, str_one, str_two, row_index, column_index, max_row_index, max_column_index) when column_index > max_column_index do
    fill(table, str_one, str_two, row_index + 1, 0, max_row_index, max_column_index)
  end

  @doc """
  Fill a table with edit values
  """
  def fill(table, str_one, str_two, row_index, column_index, max_row_index, max_column_index) do
    table
    |> Table.update_at({row_index, column_index}, edit(table, str_one, str_two, row_index, column_index))
    |> fill(str_one, str_two, row_index, column_index + 1, max_row_index, max_column_index)
  end

  # When comparing two empty strings, and the value will always be 0
  @doc false
  def edit(_, _, _, row_index, column_index) when row_index == 0 and column_index == 0, do: 0

  # If str_one is empty, it will take as many edits as there are graphemes in str_two
  @doc false
  def edit(_, _, _, row_index, column_index) when row_index == 0, do: column_index

  # If str_two is empty, it will take as many edits as there are graphemes in str_one
  @doc false
  def edit(_, _, _, row_index, column_index) when column_index == 0, do: row_index

  @doc """
  Compute the edit value of two strings at given point on a table.

  A: If the two letters are the same, the edit value is the same as that at (row - 1, column - 1).

  B: Otherwise, the edit value is the minimum of the edit values at
  (row - 1, column - 1) and (row - 1, column) and (row, column - 1), plus 1.

  ## Visualization

  A:

  0 | 3    0 | 3
  -----    -----
  3 | ?    3 | 0 <- two letters are equal, so value is taken from top left corner

  B:

  2 | 3    2 | 3
  -----    -----
  1 | ?    1 | 2 <- two letters are not equal, so value is the minimum of the three, plus one

  """
  def edit(table, str_one, str_two, row_index, column_index) do
    this_letter = str_one |> letter(row_index)
    that_letter = str_two |> letter(column_index)

    cond do
      this_letter == that_letter -> Table.read(table, {row_index - 1, column_index - 1})
      true -> min_edit(table, row_index, column_index)
    end
  end

  @doc """
  Compute the minimum of three edits, plus one
  """
  def min_edit(table, row_index, column_index) do
    edit_one = Table.read(table, {row_index - 1, column_index - 1})
    edit_two = Table.read(table, {row_index - 1, column_index})
    edit_three = Table.read(table, {row_index, column_index - 1})

    [edit_one, edit_two, edit_three]
    |> Enum.min()
    |> Kernel.+(1)
  end

  @doc """
  Helper method to extract a letter from a string.
  """
  def letter(str, i) do
    String.at(str, i - 1)
  end

end
