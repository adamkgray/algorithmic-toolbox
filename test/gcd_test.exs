defmodule GCDTest do
  use ExUnit.Case

  test "calculates the greatest common divisor" do
    assert GCD.gcd(28851538, 1183019) == 17657
  end
end
