defmodule LastDigitTest do
  use ExUnit.Case

  test "calculates last digit of the Nth fibonacci number" do
    assert LastDigit.f(8674653) == 8
  end
end
