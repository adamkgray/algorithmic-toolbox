defmodule QuickSortMiddlePivot do
  @moduledoc """
  QuickSort sorts a list by taking an element of the list, i,
  and then partitioning the rest of the elemtents into two lists,
  one of those elements which are less than i, and one of those which are greater
  It then recursively calls itself on these sub-lists
  until it has reached single-element lists
  """

  @doc """
  QuickSort where the pivot is always the middle element of the given sub-list

  ## Examples

    iex> QuickSortMiddlePivot.sort([3, 2, 1])
    [1, 2, 3]

  """
  def sort([]) do
    []
  end

  def sort([n]) do
    [n]
  end

  def sort(list) do

    {left, [pivot | right]} = Enum.split(list, div(length(list), 2))

    {lower, higher} = partition(pivot, left ++ right)
    sort(lower) ++ [pivot] ++ sort(higher)
  end

  def partition(pivot, list) do
    partition(pivot, list, [], [])
  end

  def partition(pivot, [head | tail], lower, higher) do
    cond do
      head > pivot -> partition(pivot, tail, lower, higher ++ [head])
      true -> partition(pivot, tail, lower ++ [head], higher)
    end
  end

  def partition(_pivot, [], lower, higher) do
    {lower, higher}
  end
end
