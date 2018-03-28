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

  def fib_number(n) when n > 2 do
    fib_number(n, {0, 1}, 3)
  end

  def fib_number(n, {a, b}, count) do
    c = a + b
    cond do
      n == count -> c
      true -> fib_number(n, {b, c}, count + 1)
    end
  end

end

Helper.read_input |> Helper.fib_number |> IO.inspect
