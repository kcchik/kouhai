defmodule Kouhai.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    belongs_to :user, Kouhai.User
    has_many :comments, Kouhai.Comment
    has_many :post_votes, Kouhai.PostVote

    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
