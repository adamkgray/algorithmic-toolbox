defmodule SegmentsPerPoint do
  @moduledoc """
  Given N points on a number line, and M segments on that same number line,
  find the number of segments each point lies within
  """

  @doc """
  Calculate the number of segments each point lies within

  The solution to this problem works like this:
  - Reformat the list of points, reformat the list of segments
  - Combine these two lists and sort them
  - Iterate through this sorted list, keeping track of the number of lefts and rights, and where the points occur in between them
  - The number of segments a point crosses is the minumum of (1) the lefts that come before it minus the rights before it and (2) the rights that come after it

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

  # Combine the output of count_segments_per_point with the initial points given to the
  # calculate function and format them to produce a list of tuple where the first element
  # is the point and the second is the number of segments it intersects
  @doc false
  def format({_, _}, [], accumulator), do: accumulator
  @doc false
  def format({store, right}, [value | tail], accumulator) do
    segments = store
      |> Map.get(value)
      |> min(right)
    format({store, right}, tail, accumulator ++ [{value, segments}])
  end

  # Given a sorted list of key-value pairs, where the first element is an integer
  # and the second element is an atom (:left, :point, or :right), iterate through it
  # to produce a tuple which contains (1) the total number of :right's and (2) a map where the keys
  # are points and the values are the number of :left's that preceded it minus the number of :right's that preceded it.
  @doc false
  def count_segments_per_point(list), do: count_segments_per_point(list, 0, 0, %{})

  @doc false
  def count_segments_per_point([], _left, right, store) do
    {store, right}
  end

  @doc false
  def count_segments_per_point([{value, id} | tail], left, right, store) do
    case id do
      :left -> count_segments_per_point(tail, left + 1, right, store)
      :right -> count_segments_per_point(tail, left - 1, right + 1, store)
      :point -> count_segments_per_point(tail, left, right, Map.put(store, value, left))
    end
  end

  # Remap all points to a key-value list where the first value is
  # the point, and the second value is an atom :point
  @doc false
  def remap_points(points) do
    remap_points(points, [])
  end

  @doc false
  def remap_points([head | tail], accumulator) do
    remap_points(tail, accumulator ++ [{head, :point}])
  end

  @doc false
  def remap_points([], accumulator) do
    accumulator
  end

  # Remap all segments to a key-value list where the first value
  # is a start or end of the segment, and the second value
  # is an atom :left or :right
  @doc false
  def remap_segments(segments) do
    remap_segments(segments, [])
  end

  @doc false
  def remap_segments([{left, right} | tail], accumulator) do
    remap_segments(tail, accumulator ++ [{left, :left}, {right, :right}])
  end

  @doc false
  def remap_segments([], accumulator) do
    accumulator
  end

  # A specialized merge sort algorithm that sorts not only by integer value,
  # but also by :left, :point, and :right,
  # where :left < :point < :right
  #
  # The sort half looks like any other merge sort algorithm
  @doc false
  def sort([]), do: []

  @doc false
  def sort([a]), do: [a]

  @doc false
  def sort(list) do
    half = list
      |> length()
      |> div(2)

    {left, right} = Enum.split(list, half)

    merge(sort(left), sort(right))
  end

  # A specialized merge sort algorithm that sorts not only by integer value,
  # but also by :left, :point, and :right,
  # where :left < :point < :right
  #
  # The merge half of the algorithm contains the logic for the :left, :point, :right system
  # Entry point to merge algorithm
  @doc false
  def merge(list_a, list_b) do
    merge(list_a, list_b, [])
  end

  @doc false
  def merge([], [], accumulator), do: accumulator ++ []

  @doc false
  def merge(a, [], accumulator), do: accumulator ++ a

  @doc false
  def merge([], a, accumulator), do: accumulator ++ a

  @doc false
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
  @doc false
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
