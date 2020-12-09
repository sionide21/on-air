defmodule OnAir.LEDs do
  alias OnAir.LEDs.State
  alias Circuits.I2C

  use GenServer

  @commands %{
    set_output_pin: 1,
    select_speed: 2,
    set_pixel_count: 3,
    set_colors: 4,
    update_display: 5
  }

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def set_color(pixel, color = {_red, _green, _blue}) do
    GenServer.call(__MODULE__, {:set_color, pixel, color})
  end

  def update_colors(color_fun) do
    GenServer.call(__MODULE__, {:update_colors, color_fun})
  end

  def init([]) do
    {:ok, i2c} = I2C.open("i2c-1")

    i2c
    |> State.init()
    |> init_seesaw()
    |> display()
    |> respond(:ok)
  end

  def handle_call({:set_color, pixel, color}, _from, state) do
    state
    |> State.set_color(pixel, color)
    |> display()
    |> respond({:reply, :ok})
  end

  def handle_call({:update_colors, color_fun}, _from, state) do
    state
    |> State.update_colors(color_fun)
    |> display()
    |> respond({:reply, :ok})
  end

  defp init_seesaw(state) do
    state
    |> write(:set_output_pin, <<24>>)
    |> write(:select_speed, <<1>>)
    |> write(:set_pixel_count, <<0, 2 + 3 * State.pixel_count(state)>>)
  end

  defp display(state) do
    state
    |> write(:set_colors, <<0, 0, State.encode_pixels(state)::binary>>)
    |> write(:update_display)
  end

  defp write(state, cmd, msg \\ <<>>) do
    {:ok, cmd_num} = Map.fetch(@commands, cmd)
    I2C.write(state.i2c, 0x49, <<0x0E, cmd_num, msg::binary>>)
    state
  end

  defp respond(state, {:reply, value}) do
    {:reply, value, state}
  end

  defp respond(state, value) do
    {value, state}
  end
end
