defmodule KouhaiWeb.PostController do
  use KouhaiWeb, :controller

  import Ecto.Query

  alias Kouhai.{Repo, Post, User, Follow}

  def index(conn, %{"user_id" => user_id}) do
    query = from p in Post,
      where: p.user_id == ^user_id
    posts = Repo.all(query)

    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    user_id = conn.assigns[:user]
    user = Repo.get!(User, user_id)
    changeset = Post.changeset(%Post{user: user}, post_params)
    post = Repo.insert!(changeset)

    render(conn, "show.json", post: post)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    user_id = conn.assigns[:user]
    post = get(user_id, id)
    changeset = Post.changeset(post, post_params)
    Repo.update!(changeset)

    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:user]
    post = get(user_id, id)
    Repo.delete!(post)

    send_resp(conn, :no_content, "")
  end

  def feed(conn, _) do
    user_id = conn.assigns[:user]
    query = from f in Follow,
      where: f.follower_id == ^user_id,
      join: p in Post,
      on: p.user_id == f.followed_id,
      select: p
    posts = Repo.all(query)

    render(conn, "index.json", posts: posts)
  end

  defp get(user_id, id) do
    query = from p in Post,
      where: p.user_id == ^user_id
    Repo.get!(query, id)
  end
end
