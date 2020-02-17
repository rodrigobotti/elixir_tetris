defmodule Tetris.Points do

  @spec translate([Tetris.Brick.point], {integer(), integer()}) :: [Tetris.Brick.point]
  def translate(points, {x, y}) do
    points
    |> Enum.map(fn {dx, dy} -> {dx + x, dy + y} end)
  end

end
