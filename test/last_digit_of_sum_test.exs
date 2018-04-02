defmodule LastDigitOfSumTest do
  use ExUnit.Case

  test "calculates the last digit of sum up to Nth fibonacci number" do
    assert LastDigitOfSum.last_digit_of_sum(345) == 2
  end
end
