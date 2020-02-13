defmodule KouhaiWeb.UserController do
  use KouhaiWeb, :controller

  alias Kouhai.{Repo, User}
  alias KouhaiWeb.Services.Auth

  def index(conn, _) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        render(conn, KouhaiWeb.ErrorView, "changeset.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)
    Repo.update!(changeset)
    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete!(user)
    send_resp(conn, :no_content, "")
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    user = Repo.get_by!(User, email: email)
    generate_token(conn, user, password)
  end

  def sign_up(conn, %{"password" => password} = user_params) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        generate_token(conn, user, password)
      {:error, changeset} ->
        render(conn, KouhaiWeb.ErrorView, "changeset.json", changeset: changeset)
    end
  end

  defp generate_token(conn, user, password) do
    case Comeonin.Bcrypt.check_pass(user, password) do
      {:ok, _} ->
        token = Auth.sign(conn, user.id)
        send_resp(conn, :ok, token)
      {:error, message} ->
        send_resp(conn, :forbidden, message)
    end
  end
end
