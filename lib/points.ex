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

  def flip(points) do
    points
    |> Enum.map(fn {x, y} -> {x, 5 - y} end)
  end

  def rotate(points, 0), do: points

  def rotate(points, degrees) when degrees in [90, 180, 270] do
    rotate_90(points)
    |> rotate(degrees - 90)
  end

  def to_string(points) do
    map =
      points
      |> Enum.map(fn key -> {key, "◾️"} end)
      |> Map.new()

    for y <- 1..4, x <- 1..4 do
      Map.get(map, {x, y}, "◻️")
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
