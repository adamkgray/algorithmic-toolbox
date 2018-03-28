defmodule Helper do
  def read_input do
    [a, b] = IO.gets("") |> String.split(" ")
    {a, _} = Integer.parse(a)
    {b, _} = Integer.parse(b)
    [a, b]
  end

  def gcd([a, 0]) do
    a
  end

  def gcd([a, b]) do
    a_prime = rem(a, b)
    gcd([b, a_prime])
  end
end

Helper.read_input |> Helper.gcd |> IO.inspect


