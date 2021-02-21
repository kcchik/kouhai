defmodule Kouhai.CommentVote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comment_votes" do
    belongs_to :comment, Kouhai.Comment
    belongs_to :user, Kouhai.User

    field :is_upvote, :boolean

    timestamps()
  end

  @doc false
  def changeset(comment_vote, attrs) do
    comment_vote
    |> cast(attrs, [:is_upvote])
    |> validate_required([:is_upvote])
  end
end
