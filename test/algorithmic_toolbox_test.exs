defmodule AlgorithmicToolboxTest do
  use ExUnit.Case
  doctest AlgorithmicToolbox

  test "greets the world" do
    assert AlgorithmicToolbox.hello() == :world
  end
end
