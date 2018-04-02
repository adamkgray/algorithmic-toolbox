defmodule LCM do
  @moduledoc """
  Compute the Least Common Multiple (LCM) of two integers a and b.
  """

  @doc """
  A more convenient function for multiplication
  """
  def times(a, b) do
    a * b
  end

  @doc """
  Compute the Greatest Common Denominator (GCD)

  For more information about this algorithm, see /GCD/gcd.ex
  """
  def gcd([a, 0]) do
    a
  end

  def gcd([a, b]) do
    a_prime = rem(a, b)
    gcd([b, a_prime])
  end

  @doc """
  Compute the Least Common Multiple (LCM). The LCM is found via reduction by the GCM.

  The generic formula for this algorithm is:
  lcm(a, b) = ( |a| / gcd(a, b) ) * |b|

  ## Examples

    iex> LCM.lcm([28851538, 1183019])
    1933053046

    iex> LCM.lcm([21, 6])
    42

  """
  def lcm([a, b]) do
    abs(a)
    |> div( gcd([a, b]) )
    |> times( abs(b) )
  end
end

