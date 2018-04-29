defmodule LastDigitOfSum do
  @moduledoc """
  Given an integer N, find the last digit of the sum of all fibonacci numbers f(0) ... f(n)
  """

  @doc """
  Calculate the last digit of the sum f(0) ... f(n)

  ## Examples
  ```
  iex> LastDigitOfSum.last_digit_of_sum(100)
  5

  ```
  """
  @spec last_digit_of_sum(integer()) :: integer()
  def last_digit_of_sum(n) do
    n
    |> Kernel.+(2)
    |> rem(60)
    |> FibonacciNumbers.f()
    |> Kernel.-(1)
    |> rem(10)
  end
end
