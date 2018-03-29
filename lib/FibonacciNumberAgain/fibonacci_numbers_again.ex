defmodule FibonacciNumbersAgain do
  @moduledoc """
  For two integers n and m, find fib_number(n) % m
  Hint: you don't have to calculate all fibonacci numbers up to n!
  """

  @doc """
  Read from stdin
  """
  def read_input do
    [n, m] = IO.gets("") |> String.split(" ")
    {n, _} = Integer.parse(n)
    {m, _} = Integer.parse(m)
    {n, m}
  end


  @doc """
  Compute the Nth fibonacci number

  For more information about this algorithm, see /FibonacciNumbers/fibonacci_numbers.ex
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

  @doc """
  The Pisano period
  Returns and integer, which is the period F(i) % m

  Pisano periods always begin (0, 1 ...)
  No need to compute the first two, theyre always the same
  If the latest two are (0, 1), we return the length of our i + 1
  """

  def pisano(m) do
    a = 0
    b = 1
    pisano(m, 0, a, b)
  end

  def pisano(m, i, a, b) do
    c = rem(a + b, m) # juggle abc around
    a = b
    b = c
    cond do
      a == 0 and b == 1 -> i + 1
      true -> pisano(m, i + 1, a, b)
    end
  end

  def fib_n_mod_m({n, m}) do
    remainder = rem(n, pisano(m)) # shortcut
    fib_n = fib_number(remainder)
    rem(fib_n, m)
  end

  def main do
    read_input() |> fib_n_mod_m() |> IO.inspect()
  end
end
