defmodule FibonacciNumbersTest do
  use ExUnit.Case

  test "calculates Nth fibonacci number" do
    assert FibonacciNumbers.f(10) == 55
  end
end
