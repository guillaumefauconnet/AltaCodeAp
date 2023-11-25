defmodule Altamessengerapi.MessageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Altamessengerapi.Message` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username"
      })
      |> Altamessengerapi.Message.create_user()

    user
  end
end
