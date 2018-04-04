defmodule QuickSortRandomPivot do
  def sort([]) do
    []
  end

  def sort([n]) do
    [n]
  end

  def sort(list) do
    random_index = list
      |> length
      |> :rand.uniform()
      |> Kernel.-(1)

    {left, [pivot | right]} = Enum.split(list, random_index)

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
