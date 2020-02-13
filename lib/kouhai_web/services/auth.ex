defmodule KouhaiWeb.Services.Auth do
  import Plug.Conn

  # @salt System.get_env("KOUHAI_SALT")
  @salt "salt"

  def authorize(conn, id) do
    if to_string(conn.assigns[:user]) != id do
      conn
      |> send_resp(:forbidden, "forbidden")
      |> halt
    end
  end

  def sign(conn, id) do
    Phoenix.Token.sign(conn, @salt, id)
  end

  def verify(conn, token) do
    Phoenix.Token.verify(conn, @salt, token, max_age: 86400)
  end
end
