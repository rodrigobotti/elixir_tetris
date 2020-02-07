defmodule BrickTest do
  use ExUnit.Case

  alias Tetris.Brick

  test "Creates a new brick" do
    assert Brick.new().name == :i
  end

  test "Creates a new random brick" do
    brick = Brick.new_random()

    assert brick.name in [:i, :l, :z, :o, :t]
    assert brick.rotation in [0, 90, 180, 270]
    assert brick.reflection in [true, false]
  end

end
