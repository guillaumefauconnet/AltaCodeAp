defmodule AltamessengerapiWeb.MessageController do
  use AltamessengerapiWeb, :controller

  alias Altamessengerapi.Messenger
  alias Altamessengerapi.Messenger.Message

  action_fallback AltamessengerapiWeb.FallbackController

  def index(conn, _params) do
    messages = Messenger.list_messages()
    render(conn, :index, messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Messenger.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/messages/#{message}")
      |> render(:show, message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messenger.get_message!(id)
    render(conn, :show, message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messenger.get_message!(id)

    with {:ok, %Message{} = message} <- Messenger.update_message(message, message_params) do
      render(conn, :show, message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messenger.get_message!(id)

    with {:ok, %Message{}} <- Messenger.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
