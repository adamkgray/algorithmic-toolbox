defmodule FOfNModMTest do
  use ExUnit.Case

  test "calculates pisano period" do
    assert FOfNModM.pisano(3) == 8
  end

  test "calculates f of n mod m" do
    assert FOfNModM.f_of_n_mod_m({2816213588, 30524}) == 10249
  end
end
