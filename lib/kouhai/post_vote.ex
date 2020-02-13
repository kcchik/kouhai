defmodule Kouhai.PostVote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_votes" do
    belongs_to :post, Kouhai.Post
    belongs_to :user, Kouhai.User

    field :upvote, :boolean

    timestamps()
  end

  @doc false
  def changeset(post_votes, attrs) do
    post_votes
    |> cast(attrs, [:upvote])
    |> validate_required([:upvote])
  end
end
