defmodule DynamicMoneyChange do
  @moduledoc """
  Given an amount of money, return the minimum number of coins needed to chnage it
  Coin denominations are 1, 3, and 4
  """

  def change(0), do: 0
  def change(money) do
  end
end

# change(0) -> 0
# change(1) -> 1
# change(2) -> 2
# change(3) -> 1
# change(4) -> 1
# change(5) -> 2
# change(6) -> 2
