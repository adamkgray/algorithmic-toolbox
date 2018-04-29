defmodule QuickSort do
  @moduledoc """
  QuickSort sorts a list by taking an element of the list, i,
  and then partitioning the rest of the elemtents into two lists,
  one of those elements which are less than i, and one of those which are greater
  It then recursively calls itself on these sub-lists
  until it has reached single-element lists
  """

  @doc false
  def sort([]), do: []

  @doc false
  def sort([n]), do: [n]

  @doc """
  QuickSort where the pivot is always the first element of the given sub-list

  ## Examples
  ```
  iex> QuickSort.sort([3, 2, 1])
  [1, 2, 3]

  ```
  """
  def sort([head | tail]) do
    {lower, higher} = partition(head, tail)
    sort(lower) ++ [head] ++ sort(higher)
  end

  @doc false
  def partition(pivot, list), do: partition(pivot, list, [], [])

  @doc false
  def partition(pivot, [head | tail], lower, higher) do
    cond do
      head > pivot -> partition(pivot, tail, lower, higher ++ [head])
      true -> partition(pivot, tail, lower ++ [head], higher)
    end
  end

  @doc false
  def partition(_pivot, [], lower, higher), do: {lower, higher}
end
