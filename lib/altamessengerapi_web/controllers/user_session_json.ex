defmodule AltamessengerapiWeb.UserSessionJSON do
  @doc """
  Renders token.
  """
  def show(%{token: token}) do
    %{token: token}
  end
end
