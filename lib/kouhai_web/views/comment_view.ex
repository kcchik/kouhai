defmodule KouhaiWeb.CommentView do
  use KouhaiWeb, :view

  def render("index.json", %{comments: comments}) do
    %{comments: render_many(comments, KouhaiWeb.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{comment: render_one(comment, KouhaiWeb.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id, user: comment.user_id, post: comment.post_id, content: comment.content}
  end
end
