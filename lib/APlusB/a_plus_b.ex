defmodule APlusB do
  @moduledoc """
  Sum two integers a and b
  """

  @doc """
  Read from stdin
  """
  def read_input do
    [a, b] = IO.gets("") |> String.split(" ")
    {a, _} = Integer.parse(a)
    {b, _} = Integer.parse(b)
    {a, b}
  end

  @doc """
  Compute a plus b

  ## Examples

    iex> APlusB.sum({2, 3})
    5

  """
  def sum({a, b}) do
    a + b
  end

  def main do
    read_input()
    |> sum()
    |> IO.inspect()
  end
end

