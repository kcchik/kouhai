defmodule KouhaiWeb.Plugs.Authenticate do
  import Plug.Conn

  alias KouhaiWeb.Services.Auth

  def init(default), do: default

  def call(conn, _) do
    with [token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, id} <- Auth.verify(conn, token) do
      assign(conn, :user, id)
    else
      _ ->
        conn
        |> send_resp(:unauthorized, "unauthorized")
        |> halt()
    end
  end
end
