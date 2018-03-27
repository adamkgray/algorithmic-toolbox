defmodule Helper do
  def read_input do
    {input, _} = IO.gets("") |> Integer.parse
    input
  end

  def fib_number(input) do
    fib_number(input, [0, 1], 2)
  end

  def fib_number(input, list, index) do
    new_number = Enum.at(list, index - 1) + Enum.at(list, index - 2)
    new_list = List.insert_at(list, index, new_number)
    cond do
      input - 1 == index -> List.last(new_list)
      true -> fib_number(input, new_list, index + 1)
    end
  end

end

Helper.read_input |> Helper.fib_number |> IO.inspect
