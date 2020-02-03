defmodule KouhaiWeb.PostController do
  use KouhaiWeb, :controller

  alias Kouhai.{Repo, Post, User}

  def index(conn, %{"user_id" => user_id}) do
    user = Repo.get!(User, user_id)
    posts = Repo.all(Ecto.assoc(user, :posts))
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"user_id" => user_id, "post" => post_params}) do
    user = Repo.get!(User, user_id)
    changeset = Post.changeset(%Post{user: user}, post_params)
    post = Repo.insert!(changeset)
    render(conn, "show.json", post: post)
  end

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    user = Repo.get!(User, user_id)
    post = Repo.get!(Ecto.assoc(user, :posts), id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"user_id" => user_id, "id" => id, "post" => post_params}) do
    user = Repo.get!(User, user_id)
    post = Repo.get!(Ecto.assoc(user, :posts), id)
    changeset = Post.changeset(post, post_params)
    Repo.update!(changeset)
    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"user_id" => user_id, "id" => id}) do
    user = Repo.get!(User, user_id)
    post = Repo.get!(Ecto.assoc(user, :posts), id)
    Repo.delete!(post)
    send_resp(conn, :no_content, "")
  end
end
