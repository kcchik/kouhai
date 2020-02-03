defmodule KouhaiWeb.Services.Auth do
  import Plug.Conn

  def authorize(conn, id) do
    if to_string(conn.assigns[:user]) != id do
      conn
      |> send_resp(:unauthorized, "unauthorized")
      |> halt()
    end
  end
end
