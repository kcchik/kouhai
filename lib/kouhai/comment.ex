defmodule Kouhai.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    belongs_to :post, Kouhai.Post
    belongs_to :user, Kouhai.User

    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
