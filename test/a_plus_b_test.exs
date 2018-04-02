defmodule APlusBTest do
  use ExUnit.Case
  test "adds a to b" do
    assert APlusB.sum({1, 1}) == 2
  end
end
