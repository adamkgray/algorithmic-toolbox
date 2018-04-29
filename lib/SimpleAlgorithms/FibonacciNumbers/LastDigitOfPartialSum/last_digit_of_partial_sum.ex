defmodule LastDigitOfPartialSum do
  @moduledoc """
  Given to integers m and n, find the last digit of the partial sum of all fibonacci numbers f(m), f(m + 1) ... f(n)
  """

  require LastDigitOfSum

  @doc """
  Calculate the partial ficonacci sum m to n

  ## Examples
  ```
  iex> LastDigitOfPartialSum.last_digit_of_partial_sum(3, 7)
  1

  iex> LastDigitOfPartialSum.last_digit_of_partial_sum(10, 200)
  2

  ```
  """
  @spec last_digit_of_partial_sum(integer(), integer()) :: integer()
  def last_digit_of_partial_sum(m, n) when m <= n do
    difference = LastDigitOfSum.last_digit_of_sum(n) - LastDigitOfSum.last_digit_of_sum(m - 1)
    cond do
      difference < 0 -> difference + 10
      true -> difference
    end
  end
end
