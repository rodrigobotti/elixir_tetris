defmodule Tetris.Points do
  alias __MODULE__, as: Points

  def translate(points, {x, y}) do
    points
    |> Enum.map(fn {dx, dy} -> {dx + x, dy + y} end)
  end

  def transpose(points) do
    points
    |> Enum.map(fn {x, y} -> {y, x} end)
  end

  def mirror(points) do
    points
    |> Enum.map(fn {x, y} -> {5 - x, y} end)
  end

  def mirror(points, false), do: points
  def mirror(points, true), do: mirror(points)

  def flip(points) do
    points
    |> Enum.map(fn {x, y} -> {x, 5 - y} end)
  end

  def rotate(points, 0), do: points

  def rotate(points, degrees) when degrees in [90, 180, 270] do
    rotate_90(points)
    |> rotate(degrees - 90)
  end

  def with_color(points, color) do
    points
    |> Enum.map(&add_color(&1, color))
  end

  defp add_color({_x, _y, _z} = point, _color), do: point
  defp add_color({x, y}, color), do: {x, y, color}

  def color_block(:blue), do: "🟦"
  def color_block(:green), do: "🟩"
  def color_block(:orange), do: "🟧"
  def color_block(:red), do: "🟥"
  def color_block(:yellow), do: "🟨"

  defp block_color_entry({ x, y }), do:  {{x, y}, "⬜️"}
  defp block_color_entry({ x, y, color }), do:  {{x, y}, color_block(color)}

  def to_string(points) do
    map =
      points
      |> Enum.map(&block_color_entry/1)
      |> Map.new()

    for y <- 1..4, x <- 1..4 do
      Map.get(map, {x, y}, "⬛️")
    end
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  def print(points) do
    points
    |> Points.to_string()
    |> IO.puts()

    points
  end

  defp rotate_90(points) do
    points
    |> transpose()
    |> mirror()
  end
end
