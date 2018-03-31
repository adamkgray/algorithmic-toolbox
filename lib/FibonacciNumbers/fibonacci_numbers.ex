defmodule FibonacciNumbers do
  @moduledoc """
  Given an integer N, find the Nth fibonacci number
  """

  @doc """
  Read from stdin
  """
  def read_input do
    {input, _} = IO.gets("") |> Integer.parse
    input
  end

  @doc """
  Compute the Nth fibonacci number

  Definition:
  f(0) = 0
  f(1) = 1
  f(n) = f(n - 1) + f(n - 2)

  ## Examples

    iex> FibonacciNumbers.f(99)
    218922995834555169026

  """
  def f(n) when n >= 0 and n < 2 do
    n
  end

  def f(n) when n > 1 do
    f(n, 0, 1, 2)
  end

  def f(n, a, b, count) do
    c = a + b
    cond do
      n == count -> c
      true -> f(n, b, c, count + 1)
    end
  end

  def main do
    read_input()
    |> f()
    |> IO.inspect()
  end

end

