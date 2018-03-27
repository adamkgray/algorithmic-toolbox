[a, b] = IO.gets("") |> String.split(" ")

{a, _} = Integer.parse(a)
{b, _} = Integer.parse(b)

IO.puts(a + b)

