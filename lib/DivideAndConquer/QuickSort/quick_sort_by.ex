defmodule QuickSortBy do
  @moduledoc """
  QuickSort sorts a list by taking an element of the list, i,
  and then partitioning the rest of the elemtents into two lists,
  one of those elements which are less than i, and one of those which are greater
  It then recursively calls itself on these sub-lists
  until it has reached single-element lists
  """

  @doc """
  QuickSort with a random pivot and partitions are decided by a user-suplied function

  ## Examples

    iex> QuickSortBy.sort([3, 2, 1], &Kernel.>/2)
    [1, 2, 3]

    iex> QuickSortBy.sort([1, 2, 3], &Kernel.</2)
    [3, 2, 1]

  """
  def sort([], _function) do
    []
  end

  def sort([n], _function) do
    [n]
  end

  def sort(list, function) do
    random_index = list
      |> length
      |> :rand.uniform()
      |> Kernel.-(1)

    {left, [pivot | right]} = Enum.split(list, random_index)

    {lower, higher} = partition(pivot, left ++ right, function)
    sort(lower, function) ++ [pivot] ++ sort(higher, function)
  end

  def partition(pivot, list, function) do
    partition(pivot, list, [], [], function)
  end

  def partition(pivot, [head | tail], lower, higher, function) do
    cond do
      function.(head, pivot) -> partition(pivot, tail, lower, higher ++ [head], function)
      true -> partition(pivot, tail, lower ++ [head], higher, function)
    end
  end

  def partition(_pivot, [], lower, higher, _function) do
    {lower, higher}
  end
end
