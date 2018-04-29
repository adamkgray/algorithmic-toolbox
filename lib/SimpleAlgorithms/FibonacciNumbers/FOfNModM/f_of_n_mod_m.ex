defmodule FOfNModM do
  @moduledoc """
  For two integers n and m, find f(n) % m
  """

  require FibonacciNumbers

  @doc false
  def pisano(1), do: 1

  @doc """
  Calculate the Pisano period of an integer

  ## Examples
  ```
  iex> FOfNModM.pisano(2)
  3

  iex> FOfNModM.pisano(100)
  300

  iex> FOfNModM.pisano(9875)
  19500

  ```
  """
  @spec pisano(integer()) :: integer()
  def pisano(m) when m > 1 do
    # The period starts with (0, 1), so we plug them in here by default
    # No need to calculate
    a = 0
    b = 1
    pisano(m, 0, a, b)
  end

  @doc false
  def pisano(m, i, a, b) do
    # create c
    c = rem(a + b, m)

    # b moves to a
    a = b

    # c moves to b
    b = c

    cond do
      # each period begins with (0, 1), so this indicates we are done
      a == 0 and b == 1 -> i + 1
      true -> pisano(m, i + 1, a, b)
    end
  end

  @doc """
  Calculate f(n) % m

  ## Examples
  ```
  iex> FOfNModM.f_of_n_mod_m(98765, 43210)
  8415

  ```
  """
  @spec f_of_n_mod_m(integer(), integer()) :: integer()
  def f_of_n_mod_m(n, m) do
    n
    |> rem(pisano(m))
    |> FibonacciNumbers.f()
    |> rem(m)
  end
end
