defmodule MajorityElement do
  @moduledoc """
  Given n of integers, determine whether any integer i occurs a majority of the time,
  that is, whether i occurs n/2 + 1 times.
  """

  @doc """
  Calculate whether or not there is a majority integer
  If it exists, return a tuple {true, integer}
  Else, return {false, :nil}

  ## Examples

    iex> MajorityElement.find([1, 2, 2, 1, 3, 2, 2])
    {true, 2}

    iex> MajorityElement.find([1, 2, 2, 1, 3, 2, 3])
    {false, :nil}

  """
  def find([]), do: {false, :nil}

  def find(list) do
    require MergeSort
    list = MergeSort.sort(list)

    final_index = list
      |> length()
      |> Kernel.-(1)

    max_i = list
      |> length()
      |> div(2)

    find(list, 0, max_i, final_index)
  end

  defp find(list, i, max_i, final_index) when i <= max_i do
    value_a = Enum.at(list, i)
    value_b = Enum.at(list, i + max_i)

    cond do
      value_a == value_b -> {true, value_a}
      true -> find(list, i + 1, max_i, final_index)
    end
  end

  defp find(_list, i, max_i, _final_index) when i > max_i do
    {false, :nil}
  end
end
