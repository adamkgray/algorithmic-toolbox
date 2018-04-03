defmodule MPP do
  def read_input do
    _ = IO.gets("")
    raw_input = IO.gets("") |> String.replace("\n", "") |> String.split(" ")
    for value <- raw_input, do: convert_to_int(value)
  end

  def convert_to_int(value) do
    {a, _} = Integer.parse(value)
    a
  end

  def multiplied({a, b}) do
    a * b
  end

  def largest_values(list) do
    largest_values(list, 0, 0)
  end

  def largest_values([head | tail], value1, value2) do
    cond do
      head > value1 -> largest_values(tail, head, value1)
      head > value2 -> largest_values(tail, value1, head)
      true -> largest_values(tail, value1, value2)
    end
  end

  def largest_values([], value1, value2) do
    {value1, value2}
  end

  def mpp(list) do
    list
    |> largest_values()
    |> multiplied()
  end

  def main do
    read_input()
    |> mpp()
    |> IO.inspect()
  end

end

