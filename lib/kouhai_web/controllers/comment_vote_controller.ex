defmodule KouhaiWeb.CommentVoteController do
  use KouhaiWeb, :controller

  import Ecto.Query

  alias Kouhai.{Repo, CommentVote, Comment, User}

  def upvote_count(conn, %{"comment_id" => comment_id}) do
    query = from c in CommentVote,
      where: c.comment_id == ^comment_id and c.is_upvote == true
    upvotes = Repo.aggregate(query, :count)
    send_resp(conn, :ok, to_string(upvotes))
  end

  def downvote_count(conn, %{"comment_id" => comment_id}) do
    query = from c in CommentVote,
      where: c.comment_id == ^comment_id and c.is_upvote == false
    downvotes = Repo.aggregate(query, :count)
    send_resp(conn, :ok, to_string(downvotes))
  end

  def upvote(conn, %{"comment_id" => comment_id}) do
    vote(conn, comment_id, true)
  end

  def downvote(conn, %{"comment_id" => comment_id}) do
    vote(conn, comment_id, false)
  end

  defp vote(conn, comment_id, isUpvote) do
    user_id = conn.assigns[:user]
    query = from c in CommentVote,
      where: c.user_id == ^user_id and c.comment_id == ^comment_id
    case Repo.one(query) do
      nil ->
        user = Repo.get!(User, user_id)
        comment = Repo.get!(Comment, comment_id)
        changeset = CommentVote.changeset(%CommentVote{user: user, comment: comment}, %{upvote: isUpvote})
        Repo.insert!(changeset)
      vote ->
        # Delete vote if upvoted/downvoted twice
        if vote.upvote == isUpvote do
          Repo.delete!(vote)
        else
          changeset = CommentVote.changeset(vote, %{upvote: isUpvote})
          Repo.update!(changeset)
        end
    end

    send_resp(conn, :ok, "voted")
  end
end
