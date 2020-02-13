defmodule KouhaiWeb.FollowController do
  use KouhaiWeb, :controller

  import Ecto.Query

  alias Kouhai.{Repo, Follow, User}

  def update(conn, %{"id" => followed_id}) do
    follower_id = conn.assigns[:user]
    follower = Repo.get!(User, follower_id)
    followed = Repo.get!(User, followed_id)
    Repo.insert!(%Follow{followed: followed, follower: follower})

    send_resp(conn, :ok, "")
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:user]
    query = from f in Follow,
      where: f.follower_id == ^user_id and f.followed_id == ^id
    follow = Repo.one!(query)
    Repo.delete!(follow)

    send_resp(conn, :no_content, "")
  end

  def following(conn, %{"user_id" => user_id}) do
    query = from f in Follow,
      where: f.follower_id == ^user_id
    following = Repo.all(query)

    render(conn, "followed_index.json", follows: following)
  end

  def followers(conn, %{"user_id" => user_id}) do
    query = from f in Follow,
      where: f.followed_id == ^user_id
    followers = Repo.all(query)

    render(conn, "follower_index.json", follows: followers)
  end
end
