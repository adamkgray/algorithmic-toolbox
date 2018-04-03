defmodule LargestNumber do
  def convert_to_strings(list) do
    convert_to_strings(list, [])
  end

  def convert_to_strings([], new_list) do
    new_list
  end

  def convert_to_strings([head | tail], new_list) do
    convert_to_strings(tail, new_list ++ [Integer.to_string(head)])
  end
end
