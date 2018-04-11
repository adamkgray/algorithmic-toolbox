defmodule SegmentsPerPoint do
  @moduledoc """
  Given N points on a number line, and M segments on that same number line,
  find the number of segments each point lies within
  """

  @doc """
  Calculate the number of segments each point lies within
  """
  def calculate(points, segments) do
    points = remap_points(points)
    segments = remap_segments(segments)
    points_and_segments = sort(points ++ segments)
    points_and_segments
  end

  @doc """
  Remap all points to a key-value list where the first value is
  the point, and the second value is an atom :point
  """
  def remap_points(points) do
    remap_points(points, [])
  end

  def remap_points([head | tail], accumulator) do
    remap_points(tail, accumulator ++ [{head, :point}])
  end

  def remap_points([], accumulator) do
    accumulator
  end

  @doc """
  Remap all segments to a key-value list where the first value
  is a start or end of the segments, and the second value
  is an atom "left" or "right"

  For example, the segment {3, 4} becomes {3, :left}, {4, :right}
  """
  def remap_segments(segments) do
    remap_segments(segments, [])
  end

  def remap_segments([{left, right} | tail], accumulator) do
    remap_segments(tail, accumulator ++ [{left, :left}, {right, :right}])
  end

  def remap_segments([], accumulator) do
    accumulator
  end

  @doc """
  A specialized merge sort algorithm that sorts not only by integer value,
  but also by :left, :point, and :right,
  where :left < :point < :right

  The sort half looks like any other merge sort algorithm
  """
  def sort([]), do: []
  def sort([a]), do: [a]
  def sort(list) do
    half = list
      |> length()
      |> div(2)

    {left, right} = Enum.split(list, half)

    merge(sort(left), sort(right))
  end

  @doc """
  A specialized merge sort algorithm that sorts not only by integer value,
  but also by :left, :point, and :right,
  where :left < :point < :right

  The merge half of the algorithm contains the logic for the :left, :point, :right system
  """
  # Entry point to merge algorithm
  def merge(list_a, list_b) do
    merge(list_a, list_b, [])
  end

  def merge([], [], accumulator), do: accumulator ++ []
  def merge(a, [], accumulator), do: accumulator ++ a
  def merge([], a, accumulator), do: accumulator ++ a
  def merge(a = [head_a | tail_a], b = [head_b | tail_b], accumulator) do
    {value_a, _} = head_a
    {value_b, _} = head_b
    cond do
      value_a > value_b -> merge(a, tail_b, accumulator ++ [head_b])
      value_b > value_a -> merge(tail_a, b, accumulator ++ [head_a])
      value_a == value_b -> merge(:handle_equal, a, b, accumulator)
    end
  end

  # When the two value in our list are equal, we must sort them according to their identifier (id)
  # The rules for merging are => :left < :point < :right
  def merge(:handle_equal, [head_a | tail_a], [head_b | tail_b], accumulator) do
    {_, id_a} = head_a
    {_, id_b} = head_b
    cond do
      # left vs left
      id_a == :left and id_b == :left -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])

      # right vs right
      id_a == :right and id_b == :right -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])

      # point vs point
      id_a == :point and id_b == :point -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])

      # left vs right
      id_a == :left and id_b == :right -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])
      id_a == :right and id_b == :left -> merge(tail_a, tail_b, accumulator ++ [head_b, head_a])

      # left vs point
      id_a == :point and id_b == :left -> merge(tail_a, tail_b, accumulator ++ [head_b, head_a])
      id_a == :left and id_b == :point -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])

      # right vs point
      id_a == :point and id_b == :right -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])
      id_a == :right and id_b == :point -> merge(tail_a, tail_b, accumulator ++ [head_b, head_a])
    end
  end
end
