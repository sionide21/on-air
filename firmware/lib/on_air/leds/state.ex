defmodule OnAir.LEDs.State do
  defstruct [:i2c, :led_state]

  def init(i2c) do
    %__MODULE__{
      i2c: i2c,
      led_state: %{
        0 => {0, 0, 0},
        1 => {0, 0, 0},
        2 => {0, 0, 0},
        3 => {0, 0, 0}
      }
    }
  end

  def pixel_count(%__MODULE__{led_state: leds}) do
    Enum.count(leds)
  end

  def set_color(state, pixel, color) do
    %{state | led_state: Map.update!(state.led_state, pixel, fn _ -> color end)}
  end

  def update_colors(state, color_fun) do
    led_state =
    state.led_state
    |> Enum.sort()
    |> Enum.map(fn {pixel, color} -> {pixel, color_fun.(pixel, color)} end)
    |> Map.new()

    %{state | led_state: led_state}
  end

  def encode_pixels(%__MODULE__{led_state: leds}) do
    leds
    |> Enum.sort()
    |> Enum.map(fn {_, {r, g, b}} -> <<g, r, b>> end)
    |> Enum.join()
  end
end
