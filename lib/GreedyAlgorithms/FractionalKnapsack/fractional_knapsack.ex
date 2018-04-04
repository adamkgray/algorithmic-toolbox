defmodule FractionalKnapsack do
  @moduledoc """
  Given a knapsack that can hold up to a certain weight,
  and a list of items with weights and values,
  find the maximum amount of value that can be put in the knapsack
  without going over its weight limit.
  """


  @doc """
  Calculate the maximum value that can fit in a sack of given capacity
  Items are given as a keyword list in the format {worth, weight}

  ## Examples

    iex> FractionalKnapsack.fractional_knapsack(50, [{60, 20}, {100, 50}, {120, 30}])
    180

  """
  def fractional_knapsack(weight, items) do
    fractional_knapsack(:sorted, weight, 0, sort(items))
  end

  defp fractional_knapsack(:sorted, weight, value, [head | tail]) do
    new_value = weight
      |> div(elem(head, 1))
      |> times(elem(head, 0))
      |> plus(value)

    new_weight = weight
      |> div(elem(head, 1))
      |> times(elem(head, 1))
      |> times(-1)
      |> plus(weight)

    fractional_knapsack(:sorted, new_weight, new_value, tail)
  end

  defp fractional_knapsack(:sorted, _weight, value, []) do
    value
  end

  defp times(a, b) do
    a * b
  end

  defp plus(a, b) do
    a + b
  end

  @doc """
  Sort a keyword list of items by value per unit of weight

  ## Examples

    iex> FractionalKnapsack.sort([{60, 20}, {100, 50}, {120, 30}])
    [{120, 30}, {60, 20}, {100, 50}]

  """
  def sort(items) do
    require QuickSortBy
    QuickSortBy.sort(items, &compare/2)
  end

  def compare({a_1, a_2}, {b_1, b_2}) do
    ratio_a = div(a_1, a_2)
    ratio_b = div(b_1, b_2)

    ratio_a < ratio_b
  end
end
