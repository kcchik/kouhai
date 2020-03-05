defmodule KouhaiWeb.PostVoteController do
  use KouhaiWeb, :controller

  import Ecto.Query

  alias Kouhai.{Repo, PostVote, Post, User}

  def index(conn, %{"post_id" => post_id}) do
    query = from p in PostVote,
      where: p.post_id == ^post_id and p.upvote == true
    upvotes = Repo.aggregate(query, :count)

    query = from p in PostVote,
      where: p.post_id == ^post_id and p.upvote == false
    downvotes = Repo.aggregate(query, :count)

    send_resp(conn, :ok, to_string(upvotes - downvotes))
  end

  def upvote(conn, %{"post_id" => post_id}) do
    vote(conn, post_id, true)
  end

  def downvote(conn, %{"post_id" => post_id}) do
    vote(conn, post_id, false)
  end

  defp vote(conn, post_id, isUpvote) do
    user_id = conn.assigns[:user]
    query = from p in PostVote,
      where: p.user_id == ^user_id and p.post_id == ^post_id
    case Repo.one(query) do
      nil ->
        user = Repo.get!(User, user_id)
        post = Repo.get!(Post, post_id)
        changeset = PostVote.changeset(%PostVote{user: user, post: post}, %{upvote: isUpvote})
        Repo.insert!(changeset)
      vote ->
        # Delete vote if upvoted/downvoted twice
        if vote.upvote == isUpvote do
          Repo.delete!(vote)
        else
          changeset = PostVote.changeset(vote, %{upvote: isUpvote})
          Repo.update!(changeset)
        end
    end

    send_resp(conn, :ok, "voted")
  end
end
