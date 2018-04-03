defmodule MoneyChangeTest do
  use ExUnit.Case

  test "calculates least number of coins" do
    assert MoneyChange.change(28) == 6
  end
end
