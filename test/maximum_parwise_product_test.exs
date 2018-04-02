defmodule MaximumParwiseProductTest do
  use ExUnit.Case

  test "calculates maximum parwise product" do
    assert MPP.mpp([1, 2, 3, 4, 5, 5, 8, 6, 9]) == 72
  end
end
