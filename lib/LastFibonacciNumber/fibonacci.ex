defmodule Helper do
  @moduledoc """
  Find the last digit of the Nth fibonacci number
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
  The last digit is fib_number(n) % 10

  ## Examples

    iex> Helper.fib_number(331)
    9

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
      n == count -> rem(c, 10)
      true -> fib_number(n, {b, c}, count + 1)
    end
  end

end

Helper.read_input |> Helper.fib_number |> IO.inspect
