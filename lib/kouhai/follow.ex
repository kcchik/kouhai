defmodule Kouhai.Follow do
  use Ecto.Schema

  schema "follows" do
    belongs_to :followed, Kouhai.User
    belongs_to :follower, Kouhai.User

    timestamps()
  end
end
