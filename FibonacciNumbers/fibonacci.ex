defmodule Helper do
  def read_input do
    {input, _} = IO.gets("") |> Integer.parse
    input
  end

  def fib_number(n) when n > 0 and n <= 2 do
    case n do
      1 -> 0
      2 -> 1
    end
  end

  def fib_number(input) when input > 2 do
    fib_number(input, [0, 1], 2)
  end

  def fib_number(input, list, index) do
    fib_number = Enum.at(list, index - 1) + Enum.at(list, index - 2)
    cond do
      input - 1 == index -> fib_number
      true -> fib_number(input, List.insert_at(list, index, fib_number), index + 1)
    end
  end

end

Helper.read_input |> Helper.fib_number |> IO.inspect
