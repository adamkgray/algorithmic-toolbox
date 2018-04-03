defmodule FractionalKnapsackTest do
  use ExUnit.Case

  test "calculates maximum value possible" do
    items = [{10, 2}, {20, 5}, {30, 3}]
    max_weight = 47

    assert FractionalKnapsack.fractional_knapsack(max_weight, items) == 460
  end

  test "sorts a keyword list by value per unit of weight" do
    unsorted_items = [{100, 50}, {100, 100}, {100, 10}]
    sorted_items = [{100, 10}, {100, 50}, {100, 100}]

    assert FractionalKnapsack.sort(unsorted_items) == sorted_items
  end
end
