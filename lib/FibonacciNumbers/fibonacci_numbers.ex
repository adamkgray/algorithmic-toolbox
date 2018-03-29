defmodule FibonacciNumbers do
  @moduledoc """
  Find the Nth fibonacci number
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

  fib_number(0) = 0
  fib_number(1) = 1
  fib_number(n) = fib_number(n - 1) + fib_number(n - 2)

  This algorithm keeps track of at most 3 integers at any time

  ## Examples

    iex> FibonacciNumbers.fib_number(99)
    218922995834555169026

  """
  def fib_number(n) when n >= 0 and n < 2 do
    n
  end

  def fib_number(n) when n > 1 do
    fib_number(n, {0, 1}, 2)
  end

  def fib_number(n, {a, b}, count) do
    c = a + b
    cond do
      n == count -> c
      true -> fib_number(n, {b, c}, count + 1)
    end
  end

  def main do
    read_input()
    |> fib_number()
    |> IO.inspect()
  end

end

