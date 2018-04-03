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
  """
  def fewest_points(list) do
    fewest_points(sort(list), 0, [])
  end

  def fewest_points([], points, locations) do
    {points, locations}
  end

  def fewest_points([head | tail], points, locations) do
    {furthest_point, index} = find_furthest_point(0, head, tail)
    fewest_points(Enum.drop(tail, index), points + 1, locations ++ [furthest_point])
  end

  def find_furthest_point(i, {seg_start, seg_end}, [head | tail]) do
    {next_start, next_end} = head
    cond do
      next_end <= seg_end -> find_furthest_point(i + 1, {seg_start, next_end}, tail)
      next_start <= seg_end -> find_furthest_point(i + 1, {next_start, seg_end}, tail)
      true -> {seg_end, i}
    end
  end

  def find_furthest_point(i, {seg_start, _seg_end}, []) do
    {seg_start, i}
  end


  def sort(list) do
    list |> Enum.sort_by(&(elem(&1, 0)))
  end
end
