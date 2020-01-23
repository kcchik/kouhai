defmodule KouhaiWeb.PostView do
  use KouhaiWeb, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, KouhaiWeb.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, KouhaiWeb.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id, user: post.user_id, name: post.content}
  end
end
