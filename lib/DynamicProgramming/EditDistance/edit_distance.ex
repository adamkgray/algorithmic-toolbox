defmodule EditDistance do
  @moduledoc """
  Given two strings, find the minimum number of edits necessary to transform one string into the other
  """

  require Table

  @doc """
  Compute the edit distance between two strings

  ## Examples
  ```
  iex> EditDistance.edit_distance("ports", "short")
  3

  iex> EditDistance.edit_distance("same", "same")
  0

  iex> EditDistance.edit_distance("Spain", "Spaain")
  1

  ```
  """
  @spec edit_distance(String.t, String.t) :: integer()
  def edit_distance(str_one, str_two) do
    max_i = String.length(str_one)
    max_j = String.length(str_two)

    # Initialize empty table
    Table.create(str_one, str_two, :edit_distance)
    # Iterate through strings to fill table with edit values
    |> fill(str_one, str_two, 0, 0, max_i, max_j)
    # Return that last value of the last row
    |> List.last()
    |> List.last()
  end

  # When we reach the final row, the table is finished
  @doc false
  def fill(table, _str_one, _str_two, i, _j, max_i, _max_j) when i > max_i, do: table

  # When we reach the final colum, move to the next row
  @doc false
  def fill(table, str_one, str_two, i, j, max_i, max_j) when j > max_j do
    fill(table, str_one, str_two, i + 1, 0, max_i, max_j)
  end

  # Fill a table with edit values
  @doc false
  def fill(table, str_one, str_two, i, j, max_i, max_j) do
    table
    |> Table.update_at({i, j}, edit(table, str_one, str_two, i, j))
    |> fill(str_one, str_two, i, j + 1, max_i, max_j)
  end

  # When comparing two empty strings, and the value will always be 0
  @doc false
  def edit(_table, _str_one, _str_two, i, j) when i == 0 and j == 0, do: 0

  # If str_one is empty, it will take as many edits as there are graphemes in str_two
  @doc false
  def edit(_table, _str_one, _str_two, i, j) when i == 0, do: j

  # If str_two is empty, it will take as many edits as there are graphemes in str_one
  @doc false
  def edit(_table, _str_one, _str_two, i, j) when j == 0, do: i

  # Compute the edit value of two strings at given point on a table.
  #
  # A: If the two letters are the same, the edit value is the same as that at (row - 1, column - 1).
  #
  # B: Otherwise, the edit value is the minimum of the edit values at
  # (row - 1, column - 1) and (row - 1, column) and (row, column - 1), plus 1.
  #
  # Visualization
  #
  # A:
  #
  # 0 | 3    0 | 3
  # -----    -----
  # 3 | ?    3 | 0 <- two letters are equal, so value is taken from top left corner
  #
  # B:
  #
  # 2 | 3    2 | 3
  # -----    -----
  # 1 | ?    1 | 2 <- two letters are not equal, so value is the minimum of the three, plus one
  @doc false
  def edit(table, str_one, str_two, i, j) do
    this_letter = str_one |> letter(i)
    that_letter = str_two |> letter(j)

    cond do
      this_letter == that_letter -> Table.read(table, {i - 1, j - 1})
      true -> min_edit(table, i, j)
    end
  end

  # Compute the minimum of three edits, plus one
  @doc false
  def min_edit(table, i, j) do
    edit_one = Table.read(table, {i - 1, j - 1})
    edit_two = Table.read(table, {i - 1, j})
    edit_three = Table.read(table, {i, j - 1})

    [edit_one, edit_two, edit_three]
    |> Enum.min()
    |> Kernel.+(1)
  end

  # Helper method to extract a letter from a string.
  @doc false
  def letter(str, i) do
    String.at(str, i - 1)
  end

end
