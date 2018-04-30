defmodule DynamicMoneyChange do
  @moduledoc """
  Given an amount of money, return the minimum number of coins needed to change it.
  Coin denominations are given in the arguments
  """

  @doc false
  def change(0, _denominations), do: 0
  @doc false
  def change(_money, []), do: 0

  @doc """
  Given an amount of money, and a list of coin denominations,
  calculate the minimum amount of coins necessary to change the money

  ## Examples
  ```
  iex> DynamicMoneyChange.change(6, [1, 4, 3])
  2

  iex> DynamicMoneyChange.change(7, [4, 3, 1])
  2

  iex> DynamicMoneyChange.change(9, [1, 3, 4])
  3

  ```
  """
  @spec change(integer(), [integer()]) :: integer()
  def change(money, denominations) do
    change(money, denominations, 1, [0])
  end

  # recurive case
  @doc false
  def change(money, denominations, i, record) when i < money do
    viable_denominations = find_viable_denominations(i, denominations)
    minimum_coins = compare(viable_denominations, i, record)
    change(money, denominations, i + 1, record ++ [minimum_coins])
  end

  # base case
  @doc false
  def change(money, denominations, i, record) when i == money do
    viable_denominations = find_viable_denominations(i, denominations)
    minimum_coins = compare(viable_denominations, i, record)
    minimum_coins
  end

  @doc false
  def compare([], _i, _record), do: 0

  @doc false
  def compare([denomination | tail], i, record) do
    coins = record
      |> Enum.at(i - denomination)
      |> Kernel.+(1)

    compare(tail, i, record, coins)
  end

  @doc false
  def compare([], _i, _record, coins), do: coins

  # iterate through viable denominations to find optimal denomination
  @doc false
  def compare([denomination | tail], i, record, coins) do
    new_coins = record
      |> Enum.at(i - denomination)
      |> Kernel.+(1)

    cond do
      new_coins < coins  -> compare(tail, i, record, new_coins)
      new_coins >= coins -> compare(tail, i, record, coins)
    end
  end

  # find viable denominations
  @doc false
  def find_viable_denominations(i, denominations) do
    find_viable_denominations(i, denominations, [])
  end

  # denominations less than or equal to i are okay
  @doc false
  def find_viable_denominations(i, [denomination | tail], viable_denominations) when denomination <= i do
    find_viable_denominations(i, tail, viable_denominations ++ [denomination])
  end

  # denominations greater than i are not okay
  @doc false
  def find_viable_denominations(i, [denomination | tail], viable_denominations) when denomination > i do
    find_viable_denominations(i, tail, viable_denominations)
  end

  # base case
  @doc false
  def find_viable_denominations(_i, [], viable_denominations) do
    viable_denominations
  end
end
