defmodule FibonacciNumbers do
  @moduledoc """
  Given an integer N, find the Nth fibonacci number
  """

  @doc """
  Compute the Nth fibonacci number

  ## Examples
  ```
  iex> FibonacciNumbers.f(99)
  218922995834555169026

  ```

  """
  @spec f(integer()) :: integer()
  def f(n) when n >= 0 and n < 2 do
    n
  end

  @doc false
  def f(n) when n > 1 do
    f(n, 0, 1, 2)
  end

  @doc false
  def f(n, a, b, count) when count < n do
    c = a + b
    f(n, b, c, count + 1)
  end

  @doc false
  def f(n, a, b, count) when count == n do
    a + b
  end
end

