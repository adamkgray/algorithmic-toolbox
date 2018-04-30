defmodule FractionalKnapsack do
  @moduledoc """
  Given a knapsack that can hold up to a certain weight,
  and a list of items with weights and values,
  find the maximum amount of value that can be put in the knapsack
  without going over its weight limit.
  """

  @doc """
  Calculate the maximum value that can fit in a sack of given capacity.
  Items are given as a keyword list in the format {worth, weight}

  ## Examples
  ```
  iex> FractionalKnapsack.fractional_knapsack(50, [{60, 20}, {100, 50}, {120, 30}])
  180

  ```
  """
  @spec fractional_knapsack(integer(), [{integer(), integer()}]) :: integer()
  def fractional_knapsack(weight, items) do
    fractional_knapsack(weight, 0, sort(items))
  end

  @doc false
  defp fractional_knapsack(_weight, value, []), do: value
  @doc false
  defp fractional_knapsack(weight, value, [head | tail]) do
    new_value = weight
      |> div(elem(head, 1))
      |> Kernel.*(elem(head, 0))
      |> Kernel.+(value)

    new_weight = weight
      |> div(elem(head, 1))
      |> Kernel.*(elem(head, 1))
      |> Kernel.*(-1)
      |> Kernel.+(weight)

    fractional_knapsack(new_weight, new_value, tail)
  end

  @doc false
  def sort(items) do
    require QuickSortBy
    QuickSortBy.sort(items, &compare/2)
  end

  @doc false
  def compare({a_1, a_2}, {b_1, b_2}) do
    ratio_a = div(a_1, a_2)
    ratio_b = div(b_1, b_2)
    ratio_a < ratio_b
  end
end
