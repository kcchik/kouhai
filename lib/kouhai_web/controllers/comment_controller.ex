defmodule KouhaiWeb.CommentController do
  use KouhaiWeb, :controller

  import Ecto.Query

  alias Kouhai.{Repo, Post, User, Comment}

  def index(conn, %{"post_id" => post_id}) do
    query = from c in Comment,
      where: c.post_id == ^post_id
    comments = Repo.all(query)

    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
    user_id = conn.assigns[:user]
    user = Repo.get!(User, user_id)
    post = Repo.get!(Post, post_id)
    changeset = Comment.changeset(%Comment{user: user, post: post}, comment_params)
    comment = Repo.insert!(changeset)

    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    user_id = conn.assigns[:user]
    comment = get(user_id, id)
    changeset = Comment.changeset(comment, comment_params)
    Repo.update!(changeset)

    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:user]
    comment = get(user_id, id)
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end

  defp get(user_id, id) do
    query = from c in Comment,
      where: c.user_id == ^user_id
    Repo.get!(query, id)
  end
end
