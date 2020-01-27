defmodule KouhaiWeb.Plugs.Authentication do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    case Phoenix.Token.verify(conn, "salt", conn.params["api_key"], max_age: 86400) do
      {:ok, _} ->
        conn
      {:error, _} ->
        conn
        |> send_resp(401, "Unauthorized")
        |> halt
    end
  end
end