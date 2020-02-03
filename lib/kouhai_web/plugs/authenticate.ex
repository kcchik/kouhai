defmodule KouhaiWeb.Plugs.Authenticate do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [token] ->
        verify_token(conn, token)
      _ ->
        conn
    end
  end

  defp verify_token(conn, token) do
    case Phoenix.Token.verify(conn, "salt", token, max_age: 86400) do
      {:ok, id} ->
        assign(conn, :user, id)
      _ ->
        conn
    end
  end
end
