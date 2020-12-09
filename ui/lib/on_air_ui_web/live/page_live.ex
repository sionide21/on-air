defmodule OnAirUIWeb.PageLive do
  use OnAirUIWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <form phx-change="color-change" phx-submit="color-change">
      <input type="color" name="color">
    </form>
    """
  end

  def handle_event("color-change", %{"color" => "#" <> color}, socket) do
    OnAirUIWeb.Endpoint.broadcast("color", "change", %{color: to_rgb(color)})
    {:noreply, socket}
  end

  defp to_rgb(hex) do
     hex
     |> String.graphemes()
     |> Enum.chunk_every(2)
     |> Enum.map(& &1 |> Enum.join() |> String.to_integer(16))
     |> List.to_tuple()
  end
end
