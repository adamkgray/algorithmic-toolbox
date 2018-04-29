defmodule LastDigit do
  @moduledoc """
  Given an integer N, find the last digit of the Nth fibonacci number
  """

  @doc """
  Compute the last digit of the Nth fibonacci number

  ## Examples
  ```
  iex> LastDigit.f(331)
  9

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
  def f(n, a, b, count) do
    c = a + b |> rem(10)
    cond do
      n == count -> c
      true -> f(n, b, c, count + 1)
    end
  end
end

