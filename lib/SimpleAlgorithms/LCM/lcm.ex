defmodule LCM do
  @moduledoc """
  Compute the Least Common Multiple (LCM) of two integers a and b.
  """

  require GCD

  @doc """
  Compute the Least Common Multiple (LCM)

  ## Examples
  ```
  iex> LCM.lcm(28851538, 1183019)
  1933053046

  iex> LCM.lcm(21, 6)
  42

  ```
  """
  @spec lcm(integer(), integer()) :: integer()
  def lcm(a, b) do
    abs(a)
    |> div(GCD.gcd(a, b))
    |> Kernel.*(abs(b))
  end
end

