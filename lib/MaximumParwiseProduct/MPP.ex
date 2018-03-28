defmodule Helper do
  def read_line do
    IO.gets("") |> String.replace("\n", "")
  end

  def convert_to_int(value) do
    {a, _} = Integer.parse(value)
    a
  end

  def largest_values([head | tail], value1, value2) do
    cond do
      head > value1 -> largest_values(tail, head, value2)
      head > value2 -> largest_values(tail, value1, head)
      true -> largest_values(tail, value1, value2)
    end
  end

  def largest_values([], value1, value2) do
    {value1, value2}
  end

end

_ = Helper.read_line() # throw away the first line
raw_input = Helper.read_line() |> String.split(" ")
input = for value <- raw_input, do: Helper.convert_to_int(value)

{largest, second_largest} = Helper.largest_values(input, 0, 0)

IO.inspect(largest * second_largest)

