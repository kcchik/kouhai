defmodule Kouhai.CommentVote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comment_votes" do
    belongs_to :comment, Kouhai.Comment
    belongs_to :post, Kouhai.Post
    belongs_to :user, Kouhai.User

    field :upvote, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(comment_vote, attrs) do
    comment_vote
    |> cast(attrs, [:upvote])
    |> validate_required([:upvote])
  end
end
