defmodule EditDistance do
  def edit_distance(str_one, str_two) do
    Table.create(str_one, str_two)
    |> fill(str_one, str_two, 0, 0, String.length(str_one), String.length(str_two))
    |> List.last()
    |> List.last()
  end

  def fill(table, _str_one, _str_two, row_index, _column_index, max_row_index, _max_column_index) when row_index > max_row_index do
    table
  end

  def fill(table, str_one, str_two, row_index, column_index, max_row_index, max_column_index) when column_index > max_column_index do
    fill(table, str_one, str_two, row_index + 1, 0, max_row_index, max_column_index)
  end

  def fill(table, str_one, str_two, row_index, column_index, max_row_index, max_column_index) when column_index <= max_column_index do
    table
    |> Table.update_at({row_index, column_index}, edit(table, str_one, str_two, row_index, column_index))
    |> fill(str_one, str_two, row_index, column_index + 1, max_row_index, max_column_index)
  end

  def edit(_table, _str_one, _str_two, row_index, column_index) when row_index == 0 and column_index == 0 do
    0
  end

  def edit(_table, _str_one, _str_two, row_index, column_index) when row_index == 0 do
    column_index
  end

  def edit(_table, _str_one, _str_two, row_index, column_index) when column_index == 0 do
    row_index
  end

  def edit(table, str_one, str_two, row_index, column_index) do
    cond do
      letter(str_one, column_index) == letter(str_two, row_index)
        -> Table.read(table, {row_index - 1, column_index - 1})
      true
        -> min_edit(table, row_index, column_index)
    end
  end

  def min_edit(table, row_index, column_index) do
    edit = Table.read(table, {row_index - 1, column_index - 1})

    edit = cond do
      edit > Table.read(table, {row_index - 1, column_index})
        -> Table.read(table, {row_index - 1, column_index})
      true
        -> edit
    end

    edit = cond do
      edit > Table.read(table, {row_index, column_index - 1})
        -> Table.read(table, {row_index, column_index - 1})
      true
        -> edit
    end

    edit + 1
  end

  def letter(str, i) do
    str
    |> String.graphemes()
    |> Enum.at(i - 1)
  end

end

defmodule Table do
  def create(str_one, str_two) do
    rows = String.length(str_one)
    columns = String.length(str_two)
    for _ <- Range.new(0, rows), do: for _ <- Range.new(0, columns), do: 0
  end

  def read(table, {row, column}) do
    table
    |> Enum.at(row)
    |> Enum.at(column)
  end

  def update_at(table, {row, column}, value) do
    updated_row = table
      |> Enum.at(row)
      |> List.replace_at(column, value)

    List.replace_at(table, row, updated_row)
  end

  def update_row(table, row_index, row_to_add) do
    List.replace_at(table, row_index, row_to_add)
  end

  def update_column(table, column_index, column_to_add) do
    update_column(table, column_index, column_to_add, [])
  end

  defp update_column([table_head | table_tail], column_index, [column_head | column_tail], acc) do
    row = List.replace_at(table_head, column_index, column_head)
    update_column(table_tail, column_index, column_tail, acc ++ [row])
  end

  defp update_column([], _column_index, [], acc) do
    acc
  end
end
