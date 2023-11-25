defmodule Altamessengerapi.MessageTest do
  use Altamessengerapi.DataCase

  alias Altamessengerapi.Message

  describe "users" do
    alias Altamessengerapi.Message.User

    import Altamessengerapi.MessageFixtures

    @invalid_attrs %{username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Message.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Message.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{username: "some username"}

      assert {:ok, %User{} = user} = Message.create_user(valid_attrs)
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Message.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "some updated username"}

      assert {:ok, %User{} = user} = Message.update_user(user, update_attrs)
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Message.update_user(user, @invalid_attrs)
      assert user == Message.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Message.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Message.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Message.change_user(user)
    end
  end
end
