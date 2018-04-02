defmodule LastDigit do
  @moduledoc """
  Given an integer N, find the last digit of the Nth fibonacci number
  """

  @doc """
  Read from stdin
  """
  def read_input do
    {input, _} = IO.gets("") |> Integer.parse
    input
  end

  @doc """
  Compute the last digit of the Nth fibonacci number

  This algorithm keeps track of at most 3 integers at any time.
  The last digit is f(n) % 10

  ## Examples

    iex> LastDigit.f(331)
    9

  """
  def f(n) when n >= 0 and n < 2 do
    n
  end

  def f(n) when n > 1 do
    f(n, 0, 1, 2)
  end

  def f(n, a, b, count) do
    c = a + b |> rem(10)
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

