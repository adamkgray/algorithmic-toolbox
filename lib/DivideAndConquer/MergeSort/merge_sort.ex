defmodule MergeSort do
  @moduledoc """
  Sort a list of integers using the merge sort algorithm
  """

  @doc false
  def sort([]) do
    []
  end

  @doc false
  def sort([n]) do
    [n]
  end

  @doc """
  Merge sort
  """
  @spec sort([integer()]) :: [integer()]
  def sort(list) do
    half = list
      |> length()
      |> div(2)

    {left, right} = list |> Enum.split(half)

    merge(sort(left), sort(right))
  end

  @doc false
  def merge(list_a, list_b) do
    merge(list_a, list_b, [])
  end

  @doc false
  def merge([], [], accumulator) do
    accumulator
  end

  @doc false
  def merge([head | tail], [], accumulator) do
    merge(tail, [], accumulator ++ [head])
  end

  @doc false
  def merge([], [head | tail], accumulator) do
    merge([], tail, accumulator ++ [head])
  end

  @doc false
  def merge(a = [head_a | tail_a], b = [head_b | tail_b], accumulator) do
    cond do
      head_a == head_b -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])
      head_a < head_b -> merge(tail_a, b, accumulator ++ [head_a])
      head_a > head_b -> merge(a, tail_b, accumulator ++ [head_b])
    end
  end
end
