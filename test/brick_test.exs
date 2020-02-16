defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick

  test "Creates a new brick" do
    assert new().name == :i
  end

  test "Creates a new random brick" do
    brick = new_random()

    assert brick.name in [:i, :l, :z, :o, :t]
    assert brick.rotation in [0, 90, 180, 270]
    assert brick.reflection in [true, false]
    assert brick.location == {40, 0}
  end

  test "Should manipulate brick" do
    brick =
      new()
      |> left()
      |> right()
      |> down()
      |> spin_90()

    assert brick.name in [:i, :l, :z, :o, :t]
    assert brick.rotation == 90
    assert brick.reflection == false
    assert brick.location == {40, 1}
  end
end
