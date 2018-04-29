defmodule APlusB do
  @moduledoc """
  Sum two integers a and b
  """

  @doc """
  Sum two integers

  ## Examples

    iex> APlusB.sum(2, 3)
    5

  """
  @spec sum(integer(), integer()) :: integer()
  def sum(a, b) do
    a + b
  end

end

