defmodule OnAir.PhoenixAdapter do
  alias OnAir.LEDs

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    :ok = Phoenix.PubSub.subscribe(OnAirUI.PubSub, "color")
    {:ok, []}
  end

  def handle_info(%Phoenix.Socket.Broadcast{payload: %{color: color}, event: "change", topic: "color"}, state) do
    LEDs.update_colors(fn _, _ -> color end)
    {:noreply, state}
  end
end
