defmodule KouhaiWeb.PageController do
  use KouhaiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
