defmodule AltamessengerapiWeb.MessageControllerTest do
  use AltamessengerapiWeb.ConnCase

  import Altamessengerapi.MessengerFixtures
  import Altamessengerapi.AccountsFixtures

  alias Altamessengerapi.Messenger.Message

  @update_attrs %{
    message: "some updated message"
  }
  @invalid_attrs %{message: nil}

  setup %{conn: conn} do
    user = user_fixture()
    conn = conn
           |> post(~p"/api/users/token", %{
      "username" => user.email,
      "password" => valid_user_password()
    })

    %{"token" => token } = json_response(conn, 200)

    conn = recycle(conn)
    conn = put_req_header(conn, "accept", "application/json")
    conn = put_req_header(conn, "authorization", "Bearer" <> " " <> token)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all messages", %{conn: conn} do
      conn = get(conn, ~p"/api/messages")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create message" do
    test "renders message when data is valid", %{conn: conn} do
      message = message_fixture()
      conn = post(conn, ~p"/api/messages", %{
        "message" => %{
          "message" => message.message,
          "channel_id" => message.channel_id,
          "user_id" => message.user_id
        }
      })
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/messages/#{id}")

      assert %{
               "id" => ^id,
               "message" => "some message"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/messages", message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update message" do
    setup [:create_message]

    test "renders message when data is valid", %{conn: conn, message: %Message{id: id} = message} do
      conn = put(conn, ~p"/api/messages/#{message}", message: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/messages/#{id}")

      assert %{
               "id" => ^id,
               "message" => "some updated message"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, message: message} do
      conn = put(conn, ~p"/api/messages/#{message}", message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete(conn, ~p"/api/messages/#{message}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/messages/#{message}")
      end
    end
  end

  defp create_message(_) do
    message = message_fixture()
    %{message: message}
  end
end
