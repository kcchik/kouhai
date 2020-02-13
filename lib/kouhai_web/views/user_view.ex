defmodule KouhaiWeb.UserView do
  use KouhaiWeb, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, KouhaiWeb.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, KouhaiWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, email: user.email}
  end
end
