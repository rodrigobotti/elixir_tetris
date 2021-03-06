defmodule Tetris.Brick do

  @type point :: { integer, integer }
  @type brick_name :: :i | :l | :z | :o | :t
  @type attributes :: [name: brick_name]
  @type t :: %__MODULE__{
    name: brick_name(),
    location: {integer(), integer()},
    rotation: 0 | 90 | 180 | 270,
    reflection: boolean()
  }

  alias __MODULE__, as: Brick
  alias Tetris.Points

  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  @spec new(attributes | nil) :: Tetris.Brick.t()
  def new(attributes \\ []), do: __struct__(attributes)

  @spec new_random :: Tetris.Brick.t()
  def new_random do
    %Brick{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  @spec down(Tetris.Brick.t()) :: Tetris.Brick.t()
  def down(brick) do
    %Brick{brick | location: point_down(brick.location)}
  end

  @spec left(Tetris.Brick.t()) :: Tetris.Brick.t()
  def left(brick) do
    %Brick{brick | location: point_left(brick.location)}
  end

  @spec right(Tetris.Brick.t()) :: Tetris.Brick.t()
  def right(brick) do
    %Brick{brick | location: point_right(brick.location)}
  end

  @spec spin_90(Tetris.Brick.t()) :: Tetris.Brick.t()
  def spin_90(brick) do
    %Brick{brick | rotation: rotate(brick.rotation)}
  end

  @spec shape(Tetris.Brick.t()) :: [point]
  def shape(%Brick{name: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3}, {3, 3}
    ]
  end
  def shape(%Brick{name: :i}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end
  def shape(%Brick{name: :o}) do
    [
      {2, 2}, {3, 2},
      {2, 3}, {3, 3}
    ]
  end
  def shape(%Brick{name: :z}) do
    [
      {2, 1},
      {2, 2}, {3, 2},
              {3, 3}
    ]
  end
  def shape(%Brick{name: :t}) do
    [
      {2, 1},
      {2, 2}, {3, 2},
      {2, 3}
    ]
  end

  def color(%Brick{name: :i}), do: :blue
  def color(%Brick{name: :l}), do: :green
  def color(%Brick{name: :z}), do: :orange
  def color(%Brick{name: :o}), do: :red
  def color(%Brick{name: :t}), do: :yellow

  def prepare(brick) do
    brick
    |> shape()
    |> Points.rotate(brick.rotation)
    |> Points.mirror(brick.reflection)
    |> Points.with_color(color(brick))
  end

  def to_string(brick) do
    brick
    |> prepare()
    |> Points.to_string()
  end

  def print(brick) do
    brick
    |> prepare()
    |> Points.print()
    brick
  end

  defp point_down({x, y}), do: {x, y + 1}
  defp point_left({x, y}), do: {x - 1, y}
  defp point_right({x, y}), do: {x + 1, y}

  defp rotate(270), do: 0
  defp rotate(degrees), do: degrees + 90

  defp random_name do
    ~w(i l z o t)a
    |> Enum.random()
  end

  defp random_reflection do
    [true, false]
    |> Enum.random()
  end

  defp random_rotation do
    [0, 90, 180, 270]
    |> Enum.random()
  end

  defimpl Inspect, for: Brick do
    import Inspect.Algebra
    def inspect(brick, _opts) do
      concat([
        Brick.to_string(brick),
        "\n",
        "location: ", inspect(brick.location), ", ",
        "reflection: ", inspect(brick.reflection), ", ",
        "rotation: ", inspect(brick.rotation)
      ])
    end
  end

end
