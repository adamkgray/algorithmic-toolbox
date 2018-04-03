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
    fewest_points(sort(list), [], [])
  end

  def fewest_points([head | tail], points, locations) do
    :nil
  end


  def sort(list) do
    list |> Enum.sort_by(&(elem(&1, 0)))
  end
end
