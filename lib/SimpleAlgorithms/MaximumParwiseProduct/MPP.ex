defmodule MPP do
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
end


