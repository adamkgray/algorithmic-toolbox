defmodule PointsOnALine do
  @moduledoc """
  You are given a set of segments on a line.
  Your goal is to mark as few points on a line as possible,
  so that each segment contains at least one marked point.

  Note: the goal of this exercise is not to implement a sorting algorithm.
  That will come later.
  """

  @doc """
  Find the fewest number of points and where they are
  Points are given as a keyword list

  The output is a tuple where the first element is the number of points
  and the second element is a list of their locations

  ## Examples

    iex> PointsOnALine.fewest_points([{1, 3}, {2, 4}, {4, 6}, {7, 9}])
    {3, [3, 6, 9]}

    iex> PointsOnALine.fewest_points([{1, 4}, {2, 4}, {3, 4}, {7, 9}])
    {2, [4, 9]}

    iex> PointsOnALine.fewest_points([{1, 3}, {2, 5}, {3, 6}])
    {1, [3]}

  """
  def fewest_points(list) do
    fewest_points(sort(list), 0, [])
  end

  def fewest_points([], points, locations) do
    {points, locations}
  end

  # Grab the furthest point possible
  # Then, drop every segment that the point contains, and repeat the process again
  def fewest_points([head | tail], points, locations) do
    {furthest_point, index} = find_furthest_point(0, head, tail)
    fewest_points(Enum.drop(tail, index), points + 1, locations ++ [furthest_point])
  end

  @doc """
  Start from the left-most segment, and move to the right, all the while comparing with the next segment,
  finding the most amount of segments that can be covered in a single point.

  Return the coordinate of the right-most possible point, and the index of the final segment considered

  The final index will not be included in the point unless it is the actual last segment, which is
  identified by the empty list argument

  The arguments passed to this function are a starting index i, the head of the current list of segments,
  and the tail of the current list of segments

  ## Examples

    iex> PointsOnALine.find_furthest_point(0, {1, 3}, [{2, 5}, {3, 6}])
    {3, 2}

  """
  def find_furthest_point(i, {seg_start, seg_end}, [head | tail]) do
    {next_start, next_end} = head
    cond do
      next_end <= seg_end -> find_furthest_point(i + 1, {seg_start, next_end}, tail)
      next_start <= seg_end -> find_furthest_point(i + 1, {next_start, seg_end}, tail)
      true -> {seg_end, i}
    end
  end

  def find_furthest_point(i, {_seg_start, seg_end}, []) do
    {seg_end, i}
  end


  def sort(list) do
    list |> Enum.sort_by(&(elem(&1, 0)))
  end
end
