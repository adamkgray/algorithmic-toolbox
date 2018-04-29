defmodule BinarySearch do
  @moduledoc """
  Find the index of an item in a sorted list in logarithmic time
  """
  @doc """
  Binary search
  """
  @spec search([integer()], integer()) :: integer() | -1
  def search(list, n) do
    high = list
      |> length
      |> Kernel.-(1)

    search(list, n, 0, high)
  end

  @doc false
  def search(list, n, low, high) when low <= high do
    index = low
      |> Kernel.+(high)
      |> div(2)

    value = Enum.at(list, index)

    cond do
      n > value -> search(list, n, index + 1, high)
      n < value -> search(list, n, low, index - 1)
      true -> index
    end
  end

  # Return -1 if the item is not in the list
  @doc false
  def search(_list, _n, low, high) when low > high, do: -1

end
