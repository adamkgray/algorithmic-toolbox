defmodule LCMTest do
  use ExUnit.Case

  test "calculates least common multiple" do
    assert LCM.lcm([6, 8]) == 24
  end
end
