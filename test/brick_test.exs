defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick
  alias Tetris.Points

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

  test "Should return points for i shape" do
    list =
      new(name: :i)
      |> shape()

    assert {2, 2} in list
  end

  test "Should return points for o shape" do
    list =
      new(name: :o)
      |> shape()

    assert {3, 3} in list
  end

  test "Should translate a list of points" do
    actual =
      new()
      |> shape()
      |> Points.translate({1, 1})
      |> Points.translate({0, 1})

    assert actual == [{3, 3}, {3, 4}, {3, 5}, {3, 6}]
  end
end
