defmodule AltamessengerapiWeb.ChannelControllerTest do
  use AltamessengerapiWeb.ConnCase

  import Altamessengerapi.MessengerFixtures
  import Altamessengerapi.AccountsFixtures

  alias Altamessengerapi.Messenger.Channel

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

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
    test "lists all channels", %{conn: conn} do
      conn = get(conn, ~p"/api/channels")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create channel" do
    test "renders channel when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/channels", channel: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/channels/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/channels", channel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update channel" do
    setup [:create_channel]

    test "renders channel when data is valid", %{conn: conn, channel: %Channel{id: id} = channel} do
      conn = put(conn, ~p"/api/channels/#{channel}", channel: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/channels/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, channel: channel} do
      conn = put(conn, ~p"/api/channels/#{channel}", channel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete channel" do
    setup [:create_channel]

    test "deletes chosen channel", %{conn: conn, channel: channel} do
      conn = delete(conn, ~p"/api/channels/#{channel}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/channels/#{channel}")
      end
    end
  end

  defp create_channel(_) do
    channel = channel_fixture()
    %{channel: channel}
  end
end
