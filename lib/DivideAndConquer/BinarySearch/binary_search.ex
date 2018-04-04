defmodule BinarySearch do
  def search(list, n) do
    high = list
      |> length
      |> Kernel.-(1)

    search(list, n, 0, high)
  end

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

  def search(_list, _n, low, high) when low > high do
    -1
  end

end
