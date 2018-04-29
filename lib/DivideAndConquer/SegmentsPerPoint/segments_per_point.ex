defmodule SegmentsPerPoint do
  @moduledoc """
  Given N points on a number line, and M segments on that same number line,
  find the number of segments each point lies within
  """

  @doc """
  Calculate the number of segments each point lies within

  The solution to this problem works like this:
  1) Reformat the list of points, reformat the list of segments
  2) Combine these two lists and sort them
  3) Iterate through this sorted list, keeping track of the number of lefts and rights, and where the points occur in between them
  4) The number of segments a point crosses is the minumum of (1) the lefts that come before it minus the rights before it and (2) the rights that come after it

  Output is a list of tuples where the first element is a point and the second
  element is the number of segments it lies within

  ## Examples
  ```
  iex> SegmentsPerPoint.find([3, 6], [{5, 7}, {2, 7}])
  [{3, 1}, {6, 2}]

  ```
  """
  def find(points, segments) do
    points
    |> remap_points()
    |> Kernel.++(remap_segments(segments))
    |> sort()
    |> count_segments_per_point()
    |> format(points, [])
  end

  @doc """
  Combine the output of count_segments_per_point with the initial points given to the
  calculate function and format them to produce a list of tuple where the first element
  is the point and the second is the number of segments it intersects

  ## Examples
  ```
  iex> SegmentsPerPoint.format({%{4 => 1}, 1}, [4], [])
  [{4, 1}]

  ```
  """
  def format({_, _}, [], accumulator), do: accumulator
  def format({store, right}, [value | tail], accumulator) do
    segments = store
      |> Map.get(value)
      |> min(right)
    format({store, right}, tail, accumulator ++ [{value, segments}])
  end

  @doc """
  Given a sorted list of key-value pairs, where the first element is an integer
  and the second element is an atom (:left, :point, or :right), iterate through it
  to produce a tuple which contains (1) the total number of :right's and (2) a map where the keys
  are points and the values are the number of :left's that preceded it minus the number of :right's that preceded it.

  ## Examples
  ```
  iex> SegmentsPerPoint.count_segments_per_point([{3, :left}, {4, :point}, {5, :right}])
  {%{4 => 1}, 1}

  ```
  """
  def count_segments_per_point(list), do: count_segments_per_point(list, 0, 0, %{})

  def count_segments_per_point([], _left, right, store) do
    {store, right}
  end

  def count_segments_per_point([{value, id} | tail], left, right, store) do
    case id do
      :left -> count_segments_per_point(tail, left + 1, right, store)
      :right -> count_segments_per_point(tail, left - 1, right + 1, store)
      :point -> count_segments_per_point(tail, left, right, Map.put(store, value, left))
    end
  end

  @doc """
  Remap all points to a key-value list where the first value is
  the point, and the second value is an atom :point

  ## Examples
  ```
  iex> SegmentsPerPoint.remap_points([3, 5, 4, 1, 7])
  [{3, :point}, {5, :point}, {4, :point}, {1, :point}, {7, :point}]

  ```
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
  is a start or end of the segment, and the second value
  is an atom :left or :right

  For example, the segment {3, 4} becomes {3, :left}, {4, :right}

  ## Examples
  ```
  iex> SegmentsPerPoint.remap_segments([{1, 4}, {5, 9}])
  [{1, :left}, {4, :right}, {5, :left}, {9, :right}]

  ```
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

  ## Examples
  ```
  iex> SegmentsPerPoint.sort([{4, :right}, {4, :point}, {3, :left}, {3, :point}])
  [{3, :left}, {3, :point}, {4, :point}, {4, :right}]

  ```
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

  ## Examples
  ```
  iex> SegmentsPerPoint.merge([{3, :point}], [{3, :left}, {3, :right}])
  [{3, :left}, {3, :point}, {3, :right}]

  ```
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
  def merge(:handle_equal, a = [head_a | tail_a],  b = [head_b | tail_b], accumulator) do
    {_, id_a} = head_a
    {_, id_b} = head_b
    cond do
      # left and left, right and right, or point and point
      id_a == id_b -> merge(tail_a, tail_b, accumulator ++ [head_a, head_b])

      # left vs right
      id_a == :left and id_b == :right -> merge(tail_a, b, accumulator ++ [head_a])
      id_a == :right and id_b == :left -> merge(a, tail_b, accumulator ++ [head_b])

      # left vs point
      id_a == :left and id_b == :point -> merge(tail_a, b, accumulator ++ [head_a])
      id_a == :point and id_b == :left -> merge(a, tail_b, accumulator ++ [head_b])

      # right vs point
      id_a == :point and id_b == :right -> merge(tail_a, b, accumulator ++ [head_a])
      id_a == :right and id_b == :point -> merge(a, tail_b, accumulator ++ [head_b])
    end
  end
end
