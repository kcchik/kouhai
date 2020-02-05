defmodule Kouhai.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    has_many :posts, Kouhai.Post
    has_many :follows, Kouhai.Follow

    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> encrypt()
  end

  defp encrypt(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Bcrypt.add_hash(password))
  end
end
