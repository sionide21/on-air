defmodule OnAir.PhoenixAdapter do
  alias OnAir.LEDs

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    :ok = OnAirUI.ColorSelection.register()
    {:ok, []}
  end

  def handle_info({:color_change, color}, state) do
    LEDs.update_colors(fn _, _ -> color end)
    {:noreply, state}
  end
end
