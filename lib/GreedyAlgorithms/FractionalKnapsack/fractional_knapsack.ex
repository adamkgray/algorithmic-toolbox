defmodule FractionalKnapsack do
  @moduledoc """
  Given a knapsack that can hold up to a certain weight,
  and a list of items with weights and values,
  find the maximum amount of value that can be put in the knapsack
  without going over its weight limit.

  Note: The purpose of this exercise is not to implement a sorting algorithm.
  That will come later. For now, we can use Elixir's Enum.sort to sort the items.
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
    items
    |> Enum.sort_by(&(elem(&1, 0) / elem(&1, 1)))
    |> Enum.reverse()
  end
end
