defmodule MergeSort do
  def sort([]) do
    []
  end

  def sort([n]) do
    [n]
  end

  def sort(list) do
    half = list
      |> length()
      |> div(2)

    {left, right} = list |> Enum.split(half)

    merge(sort(left), sort(right))
  end

  def merge(list_a, list_b) do
    merge(list_a, list_b, [])
  end

  def merge([], [], accumulator) do
    accumulator
  end

  def merge([head | tail], [], accumulator) do
    merge(tail, [], accumulator ++ [head])
  end

  def merge([], [head | tail], accumulator) do
    merge([], tail, accumulator ++ [head])
  end

  def merge(a = [head_a | tail_a], b = [head_b | tail_b], accumulator) do
    cond do
      head_a == head_b -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])
      head_a < head_b -> merge(tail_a, b, accumulator ++ [head_a])
      head_a > head_b -> merge(a, tail_b, accumulator ++ [head_b])
    end
  end
end
