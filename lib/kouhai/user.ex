defmodule Kouhai.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    has_many :follows, Kouhai.Follow
    has_many :posts, Kouhai.Post

    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    # |> validate_confirmation(:password)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> downcase
    |> encrypt
  end

  defp downcase(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

  defp encrypt(changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset
      password ->
        change(changeset, Comeonin.Bcrypt.add_hash(password))
    end
  end
end
