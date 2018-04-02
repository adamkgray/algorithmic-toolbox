defmodule LastDigitOfPartialSumTest do
  use ExUnit.Case

  test "calculates the last digit of partial sum up to Nth fibonacci number" do
    assert LastDigitOfPartialSum.last_digit_of_partial_sum(67, 998) == 4
  end
end
