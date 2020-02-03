defmodule KouhaiWeb.Plugs.Authenticate do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    with [token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, id} <- Phoenix.Token.verify(conn, "salt", token, max_age: 86400) do
      assign(conn, :user, id)
    else
      _ -> conn
    end
  end
end
