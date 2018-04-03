defmodule MoneyChange do
  @moduledoc """
  Given an integer N, find the minimum number of coins neede to change the input value into coins with denominations 1, 5 and 10
  """

  @doc """
  Calculate least amount of coins needed

  ## Examples

    iex> MoneyChange.change(999)
    104

  """
  def change(n) when n >= 1 do
    change(n, 10, 0)
  end

  defp change(n, denomination, total) do
    coins = div(n, denomination)
    new_total = total + coins
    value_gained = denomination * coins

    cond do
      denomination == 10 -> change(n - value_gained, 5, new_total)
      denomination == 5 -> change(n - value_gained, 1, new_total)
      denomination == 1 -> new_total
    end
  end

end
