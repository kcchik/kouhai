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

  def create(conn, %{"user_id" => user_id, "post" => post_params}) do
    user = Repo.get!(User, user_id)
    changeset = Post.changeset(%Post{user: user}, post_params)
    post = Repo.insert!(changeset)

    render(conn, "show.json", post: post)
  end

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    post = get(user_id, id)

    render(conn, "show.json", post: post)
  end

  def update(conn, %{"user_id" => user_id, "id" => id, "post" => post_params}) do
    post = get(user_id, id)
    changeset = Post.changeset(post, post_params)
    Repo.update!(changeset)

    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"user_id" => user_id, "id" => id}) do
    post = get(user_id, id)
    Repo.delete!(post)

    send_resp(conn, :no_content, "")
  end

  def feed(conn, %{"user_id" => user_id}) do
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
