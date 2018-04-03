defmodule MaxRevenue do
  @moduledoc """
  You have a website with spots for advertising
  You are given two lists, a and b
  List a is the numbers of clicks an advertising spot on your website receives on average
  List b is the monetary values of each ad you could fill the spots with

  Find the maximum revenue you can make by optimizing ad placement
  """

  @doc """
  Calculate the max revenue

  ## Examples

    iex> MaxRevenue.max_revenue([3, 2], [5, 4])
    23

  """
  def max_revenue(list_a, list_b) do
    max_revenue(list_a, list_b, 0)
  end

  def max_revenue([], [], total) do
    total
  end

  def max_revenue(list_a, list_b, total) do
    largest_a = largest(list_a)
    largest_b = largest(list_b)
    new_total = total + (largest_a * largest_b)

    new_list_a = List.delete(list_a, largest_a)
    new_list_b = List.delete(list_b, largest_b)

    max_revenue(new_list_a, new_list_b, new_total)
  end

  @doc """
  Find the largest integer in a list

  ## Examples

    iex> MaxRevenue.largest([56, 12, 89])
    89

  """
  def largest(list) do
    largest(list, 0)
  end

  def largest([head | tail], value) do
    cond do
      head > value -> largest(tail, head)
      true -> largest(tail, value)
    end
  end

  def largest([], value) do
    value
  end
end
