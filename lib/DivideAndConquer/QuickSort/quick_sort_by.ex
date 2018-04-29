defmodule QuickSortBy do
  @moduledoc """
  QuickSort sorts a list by taking an element of the list, i,
  and then partitioning the rest of the elemtents into two lists,
  one of those elements which are less than i, and one of those which are greater
  It then recursively calls itself on these sub-lists
  until it has reached single-element lists
  """

  @doc false
  def sort([], _function), do: []

  @doc false
  def sort([n], _function), do: [n]

  @doc """
  QuickSort with a random pivot and partitions are decided by a user-suplied function

  ## Examples
  ```
  iex> QuickSortBy.sort([3, 2, 1], &Kernel.>/2)
  [1, 2, 3]

  iex> QuickSortBy.sort([1, 2, 3], &Kernel.</2)
  [3, 2, 1]

  ```
  """
  def sort(list, function) do
    middle = list
      |> length
      |> div(2)

    {left, [pivot | right]} = Enum.split(list, middle)

    {lower, higher} = partition(pivot, left ++ right, function)
    sort(lower, function) ++ [pivot] ++ sort(higher, function)
  end

  @doc false
  def partition(pivot, list, function) do
    partition(pivot, list, [], [], function)
  end

  @doc false
  def partition(pivot, [head | tail], lower, higher, function) do
    cond do
      function.(head, pivot) -> partition(pivot, tail, lower, higher ++ [head], function)
      true -> partition(pivot, tail, lower ++ [head], higher, function)
    end
  end

  @doc false
  def partition(_pivot, [], lower, higher, _function) do
    {lower, higher}
  end
end
