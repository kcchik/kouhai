defmodule KouhaiWeb.Plugs.Authentication do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    case Phoenix.Token.verify(conn, "salt", conn.params["token"], max_age: 86400) do
      {:ok, id} ->
        assign(conn, :user, id)
      {:error, _} ->
        conn
    end
  end
end
