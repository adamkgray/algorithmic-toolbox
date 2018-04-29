defmodule GCD do
  @moduledoc """
  Find the Greatest Common Denominator (GCD) of two integers a and b
  """

  @doc false
  def gcd(a, 0), do: a

  @doc """
  Compute the GCD of a and b

  ## Examples
  ```
  iex> GCD.gcd(357, 234)
  3

  ```
  """
  @spec gcd(integer(), integer()) :: integer()
  def gcd(a, b) do
    a_prime = rem(a, b)
    gcd(b, a_prime)
  end
end



