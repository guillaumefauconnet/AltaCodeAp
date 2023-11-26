defmodule AltamessengerapiWeb.UserController do
  use AltamessengerapiWeb, :controller

  alias Altamessengerapi.Messenger
  alias Altamessengerapi.Messenger.User

  action_fallback AltamessengerapiWeb.FallbackController

  def index(conn, _params) do
    users = Messenger.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Messenger.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Messenger.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Messenger.get_user!(id)

    with {:ok, %User{} = user} <- Messenger.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Messenger.get_user!(id)

    with {:ok, %User{}} <- Messenger.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
