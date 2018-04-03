defmodule GCD do
  @moduledoc """
  Find the Greatest Common Denominator (GCD) of two integers a and b
  """

  @doc """
  Compute the GCD of a and b

  This is the Euclidean algorithm for finding gcd(a, b)
  The euclidean algorithm states that:
    gcd(a, b) = gcd(b, a % b)

  ## Examples

    iex> GCD.gcd([357, 234])
    3

  """
  def gcd([a, 0]) do
    a
  end

  def gcd([a, b]) do
    a_prime = rem(a, b)
    gcd([b, a_prime])
  end
end


