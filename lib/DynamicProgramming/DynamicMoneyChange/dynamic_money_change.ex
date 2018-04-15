defmodule DynamicMoneyChange do
  @moduledoc """
  Given an amount of money, return the minimum number of coins needed to change it
  Coin denominations are given in the arguments
  """

  def change(0, _denominations), do: 0
  def change(_money, []), do: 0

  @doc """
  Given an amount of money, and a list of coin denominations,
  calcualte the minimum amount of coins necessary to change the money

  ## Examples

    iex> DynamicMoneyChange.change(6, [1, 3, 4])
    2

    iex> DynamicMoneyChange.change(7, [1, 3, 4])
    2

    iex> DynamicMoneyChange.change(9, [1, 3, 4])
    3

  """
  def change(money, denominations) do
    change(money, denominations, 1, [0])
  end

  def change(money, denominations, i, record) do
    viable_denominations = find_viable_denominations(i, denominations)
    minimum_coins = compare(viable_denominations, i, record)

    cond do
      i == money -> minimum_coins
      true       -> change(money, denominations, i + 1, record ++ [minimum_coins])
    end
  end

  def compare([], _i, _record) do
    0
  end

  def compare([denomination | tail], i, record) do
    coins = record
      |> Enum.at(i - denomination)
      |> Kernel.+(1)

    compare(tail, i, record, coins)
  end

  def compare([], _i, _record, coins) do
    coins
  end

  def compare([denomination | tail], i, record, coins) do
    new_coins = record
      |> Enum.at(i - denomination)
      |> Kernel.+(1)

    cond do
      new_coins < coins  -> compare(tail, i, record, new_coins)
      new_coins >= coins -> compare(tail, i, record, coins)
    end
  end

  def find_viable_denominations(i, denominations) do
    find_viable_denominations(i, denominations, [])
  end

  def find_viable_denominations(i, [denomination | tail], viable_denominations) do
    cond do
      denomination <= i -> find_viable_denominations(i, tail, viable_denominations ++ [denomination])
      denomination > i  -> find_viable_denominations(i, tail, viable_denominations)
    end
  end

  def find_viable_denominations(_i, [], viable_denominations) do
    viable_denominations
  end
end
