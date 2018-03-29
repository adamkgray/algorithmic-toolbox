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

  ## Examples
    iex> FibonacciNumbersAgain.pisano(2)
    3
    iex> FibonacciNumbersAgain.pisano(100)
    300
    iex> FibonacciNumbersAgain.pisano(9875)
    19500

  """

  def pisano(1) do
    1
  end

  def pisano(m) when m > 1 do
    a = 0 # The period starts with (0, 1), so we plug them in here by default
    b = 1 # No need to calculate
    pisano(m, 0, a, b)
  end

  def pisano(m, i, a, b) do
    c = rem(a + b, m)            # create c
    a = b                        # b moves to a
    b = c                        # c moves to b
    cond do                      # previous value of a is thrown out
      a == 0 and b == 1 -> i + 1 # each period begins with (0, 1), so this indicates we are done
      true -> pisano(m, i + 1, a, b)
    end
  end

  @doc """
  Calculate F(n) % m
  Shortcut: F(n) % m = F(n % pisano(m)) % m
  This allows to calculate a much smaller n, improving runtime

  ## Examples
    iex> FibonacciNumbersAgain.fib_n_mod_m({98765, 43210})
    8415
  """
  def fib_n_mod_m({n, m}) do
    remainder = rem(n, pisano(m))
    fib_n = fib_number(remainder)
    rem(fib_n, m)
  end

  def main do
    read_input() |> fib_n_mod_m() |> IO.inspect()
  end
end
