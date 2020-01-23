defmodule Kouhai.Repo do
  use Ecto.Repo,
    otp_app: :kouhai,
    adapter: Ecto.Adapters.Postgres
end
