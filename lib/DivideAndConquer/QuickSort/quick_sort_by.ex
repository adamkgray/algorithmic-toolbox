defmodule QuickSortBy do
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
