defmodule MaxRevenue do
  @moduledoc """
  You have a website with spots for advertising.
  You are given two lists, a and b.
  List a is the numbers of clicks an advertising spot on your website receives on average.
  List b is the monetary values of each ad you could fill the spots with.

  Find the maximum revenue you can make by optimizing ad placement.
  """

  @doc """
  Calculate the max revenue

  ## Examples
  ```
  iex> MaxRevenue.max_revenue([3, 2], [5, 4])
  23

  ```
  """
  @spec max_revenue([integer()], [integer()]) :: integer()
  def max_revenue(list_a, list_b) do
    max_revenue(list_a, list_b, 0)
  end

  @doc false
  def max_revenue([], [], total) do
    total
  end

  @doc false
  def max_revenue(list_a, list_b, total) do
    largest_a = largest(list_a)
    largest_b = largest(list_b)
    new_total = total + (largest_a * largest_b)

    new_list_a = List.delete(list_a, largest_a)
    new_list_b = List.delete(list_b, largest_b)

    max_revenue(new_list_a, new_list_b, new_total)
  end

  @doc false
  def largest(list) do
    largest(list, 0)
  end

  @doc false
  def largest([head | tail], value) do
    cond do
      head > value -> largest(tail, head)
      true -> largest(tail, value)
    end
  end

  @doc false
  def largest([], value) do
    value
  end
end
