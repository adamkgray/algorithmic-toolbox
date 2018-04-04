defmodule QuickSort do
  def sort([]) do
    []
  end

  def sort([n]) do
    [n]
  end

  def sort([head | tail]) do
    {lower, higher} = partition(head, tail)
    sort(lower) ++ [head] ++ sort(higher)
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
