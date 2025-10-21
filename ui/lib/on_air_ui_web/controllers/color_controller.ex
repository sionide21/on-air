defmodule OnAirUIWeb.ColorController do
  use OnAirUIWeb, :controller
  alias OnAirUI.ColorSelection

  def index(conn, _params) do
    color = ColorSelection.get_hex()
    text(conn, color <> "\n")
  end

  def set(conn, %{"color" => hex}) do
    case ColorSelection.set_hex(hex) do
      :ok -> text(conn, "ok\n")

      {:error, error} ->
        conn
        |> put_status(400)
        |> text(error <> "\n")
    end
  end

  def reset(conn, _params) do
    :ok = ColorSelection.set_color({0, 0, 0})
    text(conn, "ok\n")
  end
end
