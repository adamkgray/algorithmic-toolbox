defmodule LastDigitOfSum do
  @moduledoc """
  Given an integer N, find the last digit of the sum of all fibonacci numbers f(0) ... f(n)
  """

  require LastDigit

  def plus(a, b) do
    a + b
  end

  def minus(a, b) do
    a - b
  end

  @doc """
  Calculate the last digit of the sum f(0) ... f(n)

  Algorithm: sum f(n) = f(n + 2) - 1

  Approch: Since we only want the last digit, use the pisano period to reduce n before calculating sum
  Remember: f(n) mod m = f(n mod pisano(m)) mod m
  Since we will always do mod 10, we can use pisano(10) as a constant, which is 60

  ## Examples

    iex> LastDigitOfSum.last_digit_of_sum(100)
    5

  """
  def last_digit_of_sum(n) do
    n
    |> plus(2)
    |> rem(60)
    |> FibonacciNumbers.f()
    |> minus(1)
    |> rem(10)
  end
end
