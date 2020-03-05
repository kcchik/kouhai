defmodule KouhaiWeb.UserPictureController do
  use KouhaiWeb, :controller

  alias ExAws.S3

  def show(conn, %{"user_id" => user_id}) do
    res = S3.get_object("kcchik-kouhai", "user-pictures/#{user_id}.jpg")
    |> ExAws.request!
    send_resp(conn, :ok, res.body)
  end

  def update(conn, %{"image" => image}) do
    user_id = conn.assigns[:user]
    S3.put_object("kcchik-kouhai", "user-pictures/#{user_id}.jpg", image)
    |> ExAws.request!
    send_resp(conn, :no_content, "")
  end

  def delete(conn, _) do
    user_id = conn.assigns[:user]
    S3.delete_object("kcchik-kouhai", "user-pictures/#{user_id}.jpg")
    |> ExAws.request!
    send_resp(conn, :no_content, "")
  end
end
