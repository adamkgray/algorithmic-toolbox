defmodule MaximumParwiseProduct do
  @moduledoc """
  Given a list of integers, find the maximum parwise product
  """

  @doc """
  Compute the maximum parwise product of a list of integers

  ## Examples
  ```
  iex> MaximumParwiseProduct.mpp([1, 5, 3, 4, 5])
  25

  ```
  """
  @spec mpp([integer()]) :: integer()
  def mpp(list) do
    list
    |> largest_values()
    |> multiplied_together()
  end

  @doc false
  def multiplied_together({a, b}), do: a * b

  @doc false
  def largest_values(list) do
    largest_values(list, 0, 0)
  end

  @doc false
  def largest_values([head | tail], value1, value2) do
    cond do
      head > value1 -> largest_values(tail, head, value1)
      head > value2 -> largest_values(tail, value1, head)
      true -> largest_values(tail, value1, value2)
    end
  end

  @doc false
  def largest_values([], value1, value2) do
    {value1, value2}
  end
end


