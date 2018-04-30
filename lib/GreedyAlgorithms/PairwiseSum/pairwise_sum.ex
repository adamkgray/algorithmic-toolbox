defmodule PairwiseSum do
  @moduledoc """
  Given positive integer n, represent n as the sum of as many distinct, increasing, positive integers as possible.
  """

  @doc """
  Calculate the maximum number k such that n can be represented as a sum of k pairwise distinct positive integers.

  Return value is a tuple where the first element is k,
  and the second element is a list of possible such integers

  ## Examples
  ```
  iex> PairwiseSum.max_distinct(77)
  {11, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 22]}

  iex> PairwiseSum.max_distinct(78)
  {12, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]}

  ```
  """
  @spec max_distinct(integer()) :: {integer(), [integer()]}
  def max_distinct(n) when n > 0 do
    max_distinct(n, 0, 0, [])
  end

  @doc false
  def max_distinct(n, i, sum, list) do
    i = i + 1
    new_sum = sum + i

    cond do
      new_sum > n -> {i - 1, add_difference_to_last_elem(n, sum, list)}
      new_sum == n -> {i, list ++ [i]}
      true -> max_distinct(n, i, new_sum, list ++ [i])
    end
  end

  # In the case that the new_sum of the i'th iteration surpassed n,
  # we need to instead add to the i - 1 element of the list,
  # so that the sum of the list is n
  @doc false
  def add_difference_to_last_elem(n, sum, list) do
    last_value = list
      |> List.last()
      |> Kernel.+(n)
      |> Kernel.-(sum)

    list |> List.replace_at(-1, last_value)
  end
end
