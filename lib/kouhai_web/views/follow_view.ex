defmodule KouhaiWeb.FollowView do
  use KouhaiWeb, :view

  def render("followed_index.json", %{follows: follows}) do
    %{data: render_many(follows, KouhaiWeb.FollowView, "followed.json")}
  end

  def render("followed.json", %{follow: follow}) do
    %{id: follow.followed_id}
  end

  def render("follower_index.json", %{follows: follows}) do
    %{data: render_many(follows, KouhaiWeb.FollowView, "follower.json")}
  end

  def render("follower.json", %{follow: follow}) do
    %{user: follow.follower_id}
  end
end
